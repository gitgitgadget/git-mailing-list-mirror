From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Signed tags in octopus merge..
Date: Sat, 14 Jan 2012 13:30:11 -0800
Message-ID: <CA+55aFzRN2F5PZDZPRmbj9occZwA6E6Pi+S+M_Qq2EfS6sctyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 14 22:30:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmBBO-0001gJ-Ol
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 22:30:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755443Ab2ANVae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 16:30:34 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:49936 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918Ab2ANVad (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 16:30:33 -0500
Received: by werb13 with SMTP id b13so1197594wer.19
        for <git@vger.kernel.org>; Sat, 14 Jan 2012 13:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=oWXZr/c1JtMsCMIqqtbk3GsiDDnyF3UZ0aaovs3n2ew=;
        b=j7KgHX+UPs/ZWOA0x/PzKEO+qP5w5xwzZy2L9Nrjon9miPmWt/oWgc68NTI5TuUw2o
         ECoPu1lZg04wItF2lQMABJ4MDsazQ8PmEz1z++9b+qC4X2jqrBUDlXJF0RY8k2L6qMpL
         ZoZogY2fv2fvViBiqNUXry0e8VpWC1YKQ6Gyw=
Received: by 10.216.139.195 with SMTP id c45mr1294653wej.18.1326576632202;
 Sat, 14 Jan 2012 13:30:32 -0800 (PST)
Received: by 10.216.172.213 with HTTP; Sat, 14 Jan 2012 13:30:11 -0800 (PST)
X-Google-Sender-Auth: IYmnh40riEUgbIJ-Lto8QOxfWQQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188580>

Just a heads-up and congrats: octopus merges of signed tags work well,
and did exactly the RightThing(tm), both at merge time and with
"--show-signature".

I knew it was supposed to work, but I have to admit that I was a bit
apprehensive about it when I tried.

Current top-of-head (commit 81d48f0aee54) in the kernel, in case you care.

Good job,

                 Linus
