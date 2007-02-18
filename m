From: Xavier Maillard <zedek@gnu.org>
Subject: Re: format-patch and send-email
Date: Sun, 18 Feb 2007 19:17:25 +0100
Message-ID: <9388.1171822645@localhost>
References: <5680.1171788594@localhost> <7vps87hlbp.fsf@assigned-by-dhcp.cox.net>
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 19:20:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIqeC-00076V-DF
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 19:20:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXBRSUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 13:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751818AbXBRSUI
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 13:20:08 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:37911 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbXBRSUH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 13:20:07 -0500
Received: from localhost.localdomain (chn51-3-88-163-173-156.fbx.proxad.net [88.163.173.156])
	by smtp2-g19.free.fr (Postfix) with ESMTP id C790A7CE6;
	Sun, 18 Feb 2007 19:20:05 +0100 (CET)
Received: from localhost (IDENT:1001@localhost [127.0.0.1])
	by localhost.localdomain (8.13.8/8.13.8) with ESMTP id l1IIHP7o009390;
	Sun, 18 Feb 2007 19:17:26 +0100
In-reply-to: <7vps87hlbp.fsf@assigned-by-dhcp.cox.net> 
Comments: In-reply-to Junio C Hamano <junkio@cox.net>
   message dated "Sun, 18 Feb 2007 01:22:18 -0800."
X-Mailer: MH-E 8.0.2; nmh 1.2; GNU Emacs 22.0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40083>

Hi Junio,

Junio C Hamano <junkio@cox.net> wrote:

> Xavier Maillard <zedek@gnu.org> writes:
>
>> [SNIP SNIP] 
> 
> The "format-patch" output was designed to (minimally) mimic what
> you would see in a UNIX mbox as if you (or whoever would apply
> the e-mailed patches to repository) received it, so that anybody
> can later run "am" on it.  The first "From " is what sometimes
> is called "UNIX-From " line, which separates each piece of
> e-mail in mbox formatted mailbox file.  The second one is used
> to record the author of the patch.
> 
> The commit log message is expected to be:
> 
> 	A single line description of a patch
> 
> 	More detailed explanation of the patch with
>         possibly multi-line or multi-paragraph text.
> 
> and the single line description becomes the subject.

Ok so I need to revert my usual practise :)

 
Thank you for your answers. I know have understood what was wrong
;)

Regards,

Xavier
