From: Ravi Shekhar Jethani <rsjethani@gmail.com>
Subject: Rationale behind 'extern' on protypes in .h files
Date: Sun, 22 Dec 2013 21:21:30 +0530
Message-ID: <CAKTJ_1zecXP03k_2YRnm_26n=anxkG6=k+isZxnnjWgfec70LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 22 16:51:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VulJZ-0007B4-8I
	for gcvg-git-2@plane.gmane.org; Sun, 22 Dec 2013 16:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab3LVPvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Dec 2013 10:51:32 -0500
Received: from mail-lb0-f194.google.com ([209.85.217.194]:64989 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3LVPvb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Dec 2013 10:51:31 -0500
Received: by mail-lb0-f194.google.com with SMTP id u14so590953lbd.9
        for <git@vger.kernel.org>; Sun, 22 Dec 2013 07:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=Vb1qus9CO9n/8rG9fnOBTRidvotFYnGZpO/93hEFYCY=;
        b=JvV8g4iIV6ECpg32wc+IFJHhJ7S8tYm20zAtS7a5Axu31KZV2/igisLTJeM/wd3yHu
         bhPwwFWtaeDZfXiXg+ocN8YNalrphP/MoKrHijv9YzC0CKcNqnUHi2uz8gGi8SucTJnC
         bCvrhb0w9elRX6k95ZmP8uVHfWINdy8sLgBlv8iWyPCSBJoWvauL556KZte5eBgno+Ki
         o7DGVNBjfFC6S+bzLhmlrzq/3HL7V5lT/QHDec8zxTzz6oK9Mk1I7/lc7zEQy9kvXBYd
         cBMX5xXZsUHhmFcA9kCMWBXpOXgWznTaMCa3624+HYWk9JQO5C2wP8vh9JSta/aNwX82
         VneA==
X-Received: by 10.152.19.65 with SMTP id c1mr1239079lae.49.1387727490056; Sun,
 22 Dec 2013 07:51:30 -0800 (PST)
Received: by 10.114.18.43 with HTTP; Sun, 22 Dec 2013 07:51:30 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239644>

Hi,
I am a C & Data Structure teacher at at an institute. Up until now I
have only written classroom type C code. I always had interest in
operating systems especially Linux Kernel but never got into anything
just passively followed 'lwn.net', 'dr dobbs magazine' etc.

But the series '30 Linux Kernel Developers in 30 Weeks' on 'linux.com'
has really pushed me over the edge and  I have this new found interest
towards Linux and C. As these articles suggest that I should have a
good experience in user space before I can even touch the kernel. So
to get a feel of how actual real world C projects look like I have
taken two excellent projects as my reference 'Git' and 'libvirt'. Also
'Linux Formrnal Scratch' to get started towards Linux internals.

Although I have a good understanding of the basic/advanced concepts
like pointers, memory management etc but many concepts like good error
handling mechanism, unit testing, build systems etc. were always
blurry but I know that this is just a start towards a long journey
towards Linux Kernel.


Now, my real question :
1) I cannot understand the reason behind making function prototypes as
extern. What purpose does this serve? AFAIK we put definition in a .c
file and the prototype in a .h thats it.

2) Why are some  prototypes in some of the .h file are extern and
others are not?

Thank you guys for reading through. Any suggestions are humbly welcome.
Ravi S. Jethani
