From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Adding a 'version' command to the server (was:
	git@vger.kernel.org)
Date: Sat, 28 Jun 2008 13:43:37 +0200
Message-ID: <20080628114337.GA3489@steel.home>
References: <7viqvupm3l.fsf@gitster.siamese.dyndns.org> <486572BC.9070201@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 13:44:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCYr9-00075G-6f
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 13:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbYF1Lnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 07:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbYF1Lnm
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 07:43:42 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:15993 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750930AbYF1Lnl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 07:43:41 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jeZV
Received: from tigra.home (Fa959.f.strato-dslnet.de [195.4.169.89])
	by post.webmailer.de (klopstock mo39) (RZmta 16.45)
	with ESMTP id q02414k5SAsAlA ; Sat, 28 Jun 2008 13:43:38 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3C416277BD;
	Sat, 28 Jun 2008 13:43:38 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 16A6656D2A; Sat, 28 Jun 2008 13:43:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <486572BC.9070201@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86712>

Lea Wiemann, Sat, Jun 28, 2008 01:07:40 +0200:
> Junio C Hamano wrote:
>> It is still possible to connect to older remote end with new clients, but
>> you have to explicitly ask for "git-upload-pack" by using --upload-pack=
>> option when running "git fetch"
>
> Now that the current git won't work with older servers anyway, what  
> about using this opportunity to add a 'version' command to the server?  
> With such a command, such problems would seem to be quite easily  
> avoidable in the future, since the client can discriminate based on the  
> server's version.

And exactly how are the incompatibility problems avoided? By denying
the service if the versions don't match?
