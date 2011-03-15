From: Guy Maurel <guy-kde@maurel.de>
Subject: Re: a problem with the gitconfig file for user.email
Date: Tue, 15 Mar 2011 18:45:51 +0100
Message-ID: <201103151845.52330.guy-kde@maurel.de>
References: <loom.20110313T182907-610@post.gmane.org> <vpqy64iy7r3.fsf@bauges.imag.fr> <7v8vwihbfx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 18:53:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzYQi-0003Ft-I3
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 18:53:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208Ab1CORxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 13:53:06 -0400
Received: from hosting.xaranet.de ([80.237.242.67]:56080 "EHLO
	hosting.xaranet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab1CORxG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 13:53:06 -0400
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Mar 2011 13:53:05 EDT
Received: from falun.localnet (p5B30494E.dip.t-dialin.net [91.48.73.78])
	by hosting.xaranet.de (Postfix) with ESMTPSA id 477615409F;
	Tue, 15 Mar 2011 18:45:56 +0100 (CET)
User-Agent: KMail/1.13.6 (Linux/2.6.37-ARCH; KDE/4.6.0; x86_64; ; )
In-Reply-To: <7v8vwihbfx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169082>

Hello!

Thanks for helping, but...
On Monday, March 14, 2011 12:01:38 AM Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> > Guy Maurel <guy-kde@maurel.de> writes:
> >> why is it necessary to have a <TAB> before the email keyword in the
> >> [user] section?
> > 
> > It isn't. I've just checked with email right at the beginning of the
> > line, without tab or space, and it works (with the latest git.git).
> > 
> >> If not, one get the error message:
> >>   fatal: bad config file line 2 in /home/guy-kde/.gitconfig
> > 
> > Please, give a short and reproducible senario (eg. the full content of
> > .gitconfig, and the command you've typed to get this).
I had very little things:
[user]
      name = Guy Maurel
      email = guy-kde@maurel.de
^^ these are spaces
> 
> Good suggestion.  I suspect this is some third party programs or hooks
> that are trying to hand parse the config file.  In the distant past, some
> of our perl based Porcelains may have done so but I think these days
> everything we ship should be reading from "git config" output or calling
> git_config() from C.
I am using kernel 2.6.37-ARCH and git 1.7.4.1-1 64bits
But I cannot reproduce the problem *today*.
I am sorry, so sorry. I bet your pardon.

As I made a git config --add user.email  guy-kde@maurel.de
I got a <TAB> before the email keyword, this leads me to my question.

Thanks for helping
-- 
guy
