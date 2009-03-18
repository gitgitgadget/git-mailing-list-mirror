From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: Missing trailing newline with git log --pretty=format
Date: Wed, 18 Mar 2009 23:04:51 +0100
Organization: SUSE Labs / Novell
Message-ID: <200903182304.51387.agruen@suse.de>
References: <200903182223.58800.agruen@suse.de> <200903182256.43817.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Wed Mar 18 23:08:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk3vK-0002bh-EI
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753836AbZCRWGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753889AbZCRWGE
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:06:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:35341 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752030AbZCRWGC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:06:02 -0400
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3F1938672B;
	Wed, 18 Mar 2009 23:06:00 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <200903182256.43817.markus.heidelberg@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113689>

On Wednesday, 18 March 2009 22:56:43 Markus Heidelberg wrote:
> Use tformat instead of format.

Hmm ... didn't know that, thanks. Now I wonder why anyone would ever want 
format instead of tformat ;)

> Or better for a script use 
>
> 	$ git rev-list HEAD^^..HEAD

Much better, thanks.

Andreas
