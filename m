From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [RFC/PATCH] Documentation: Don't assume git-sh-setup and
	git-parse-remote are in the PATH
Date: Sat, 28 Jun 2008 22:58:17 +0200
Message-ID: <20080628205817.GB3172@steel.home>
References: <20080627151001.BIA19424@m4500-01.uchicago.edu>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Sat Jun 28 22:59:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KChVx-0003xi-IL
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 22:59:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbYF1U61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 16:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751688AbYF1U60
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 16:58:26 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:12439 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbYF1U6T (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 16:58:19 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jeZV
Received: from tigra.home (Fa959.f.strato-dslnet.de [195.4.169.89])
	by post.webmailer.de (fruni mo51) (RZmta 16.45)
	with ESMTP id a07322k5SI0j11 ; Sat, 28 Jun 2008 22:58:17 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 598FB277BD;
	Sat, 28 Jun 2008 22:58:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3778256D2A; Sat, 28 Jun 2008 22:58:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080627151001.BIA19424@m4500-01.uchicago.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86742>

Jonathan Nieder, Fri, Jun 27, 2008 22:10:01 +0200:
>  --------
> +[verse]
> +'PATH=$(git --exec-path):$PATH'
>  '. git-parse-remote'

You missed quoting. exec-path can contain whitespace. What do you need
exec-path in PATH for?
