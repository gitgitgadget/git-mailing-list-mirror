From: chenjinlei <chenjinlei456@sina.com>
Subject: bug to report
Date: Fri, 8 Apr 2016 18:01:27 +0800
Message-ID: <16238819-B46A-40C7-943A-EBD22EAACEF6@sina.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 08 12:35:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoTlP-0002JL-W3
	for gcvg-git-2@plane.gmane.org; Fri, 08 Apr 2016 12:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896AbcDHKfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Apr 2016 06:35:34 -0400
Received: from mail3-165.sinamail.sina.com.cn ([202.108.3.165]:51984 "HELO
	smtp545-122.mail.sina.com.cn" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with SMTP id S1757244AbcDHKfd convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Apr 2016 06:35:33 -0400
X-Greylist: delayed 495 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 Apr 2016 06:35:32 EDT
Received: from unknown (HELO [192.168.1.59])([101.251.0.9])
	by sina.com with ESMTP
	8 Apr 2016 18:01:43 +0800 (CST)
X-Sender: chenjinlei456@sina.com
X-Auth-ID: chenjinlei456@sina.com
X-SMAIL-MID: 2634095767201
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291020>


I=E2=80=99m encounter a problem due to my own stupidity=E2=80=A6
#1 I pushed a project named Android to my repository.
#2 I `mv Android android`, cause I think it=E2=80=99s no good to use th=
e uppercase as my project name.
#3 I pushed it to my repository again=E2=80=A6

I found that there `Adnroid` and `android` exist in my repository, and =
I want to delete the former one.
So I tried to `git pull && git rm Android`, but guess what? I can=E2=80=
=99t pull the `Android`=E2=80=A6=E2=80=A6

I found that OS X is case-insensitive, while github repository is case-=
sensitive, thus I can=E2=80=99t `rm Android` any more. It becomes a gos=
ht in my repository and I can never delete it!


OS: OS X
git version: 2.6.4 (Apple Git-63)
