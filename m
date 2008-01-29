From: Perrin Meyer <perrinmeyer@yahoo.com>
Subject: lost history with directory move?
Date: Mon, 28 Jan 2008 17:22:42 -0800 (PST)
Message-ID: <66024.57523.qm@web52812.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 29 02:29:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJfIR-0001D8-Ao
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 02:29:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752986AbYA2B3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jan 2008 20:29:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753905AbYA2B3Y
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 20:29:24 -0500
Received: from web52812.mail.re2.yahoo.com ([206.190.49.1]:28421 "HELO
	web52812.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752361AbYA2B3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2008 20:29:24 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Mon, 28 Jan 2008 20:29:23 EST
Received: (qmail 58426 invoked by uid 60001); 29 Jan 2008 01:22:43 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:MIME-Version:Content-Type:Message-ID;
  b=R8f1AXPrhDt8DJ+vCU0BodfLLhkrm5hc1AVFdnOoDhMPxkVrYkxhCbhICQXXWJ9aIwoKUg0zoChKDzeKAYAYTpkMa9aIoAUOyVHoMIXsAeN5ima2HJliMKEFZ/gbqj1RtmSktXWekbkOOXRYrL8k9gEfnXRhcZo9B0Tf8HtHuco=;
X-YMail-OSG: tdLWRSgVM1mzx1ssvOyhgXiq4hTxON.WM2EhL74aIQ_y7oSO3YaHQ8hKbnjMUAMva5uPzj_2fQ--
Received: from [216.52.12.233] by web52812.mail.re2.yahoo.com via HTTP; Mon, 28 Jan 2008 17:22:42 PST
X-Mailer: YahooMailRC/818.31 YahooMailWebService/0.7.160
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71912>



I'm confused about history and directory renaming. Where did my history go? 

I have a git repo with a doc/ directory, which I renamed to Documentation/ 

$ mv doc/ Documentation/
$ git commit -a 
where I see a lot of deletes
$ git push

$ git add Documentation/
$ git commit -a
and I see that a all my doc files added, as expected. 
$ git push 

But when I got to look at the history of the Documentation/ directory

$ git log Documentation/

I only see one commit message 

even if I do a 

$ git log --follow Documentation/

I don't see my history.

Even if I try a single file

$ git log --follow README

I only see the single rename commit, not any history. 

What did I do wrong?  

I'm guessing, in hindsight, that I probably should have done

$ mv doc/ Documentation/
$ git add Documentation/
$ git commit -a 

but is there anyway to get my history back given what I have done? 

Thanks for the help.  I'm using git version 1.5.3.8 

Perrin Meyer 
