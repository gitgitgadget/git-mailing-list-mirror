From: Ethan Reesor <firelizzard@gmail.com>
Subject: Git prompt
Date: Sun, 10 Feb 2013 16:05:32 -0500
Message-ID: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 22:14:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4eDx-0001DR-Mo
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 22:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756840Ab3BJVNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 16:13:46 -0500
Received: from mail-qe0-f54.google.com ([209.85.128.54]:40905 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201Ab3BJVNp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 16:13:45 -0500
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Feb 2013 16:13:45 EST
Received: by mail-qe0-f54.google.com with SMTP id 1so2359623qeb.13
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 13:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=Ct+4UAf3qgjktH+krs/Wp4hHMR8hCwFKAJYvLkSex5w=;
        b=lBhba5TWFn7E2ZcTjXxSBvmU9yQH3d0IsSvtHBTVrZER0Ut68iwjseBGauNRweFaIG
         0hxO9tIKbvGTGmcFR0l1Sd3gTjybeuvIsvY8koNjd3jj3w4eSSx1Y/3yAXTe2ePE8esl
         FsCWGzcye/egRxLdyLWn2/+xXNs6s55RAWSQIuCqiSW7MWLpp77lalnKFchJ7+5pAoIv
         AKj7ScbDgE8pTzp+z2uyo0E/4iJHcPqEyn7A3wxQ7kxb95gTbfD40WlIIK7xJU0ZwyAR
         zNQaOyLNajNkU6Cn2LaqOWG7AILY0Xa+51s9DSqROSFXLhOV/pVl6YH4N+O2PaoCrQkf
         S2Ig==
X-Received: by 10.224.210.135 with SMTP id gk7mr4668295qab.57.1360530353092;
 Sun, 10 Feb 2013 13:05:53 -0800 (PST)
Received: by 10.49.95.225 with HTTP; Sun, 10 Feb 2013 13:05:32 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215934>

I have a git user set up on my server. It's prompt is set to
git-prompt and it's git-shell-commands is empty. The server works as a
git remote using ssh and the git user. When I `ssh git@server` I get a
prompt where I can do nothing. When you ssh to github.com, you recieve
this message: "Hi username! You've successfully authenticated, but
GitHub does not provide shell access."

How do I make the git user work like github where, upon attempting to
get a prompt, the connection is closed?

--
Ethan Reesor
