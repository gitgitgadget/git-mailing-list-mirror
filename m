From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: In tree object, Must the
Date: Sun, 8 Apr 2012 12:43:56 +0900
Message-ID: <CAFT+Tg-+s5=pFNwY7ZMxem4z6YHu53kyOs0B_rkmphq=mEtpTg@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 05:44:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGj3O-0005r7-3Z
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 05:44:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab2DHDn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 23:43:57 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58578 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab2DHDn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 23:43:56 -0400
Received: by obbtb18 with SMTP id tb18so4611146obb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 20:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type;
        bh=Q27bvqG9uo17qyZxU2Y54Zab0yYtw87aEbkrdiVLxWo=;
        b=vzMCwIT3m8JjYE2i1L/JfrjNPVMrxFCIUwmd4Y71sx+bRrn7KYlOa3X6X3t0VEGG/K
         AQOQIG9ty7DZbQ+yPyTS+zMMm/+sLqofLU8qf1ZyAnL5CvVvkUAwV5aB8z3/eUmCs0dm
         BRJV1s8hdssMX9kfpjiMYUqfG3ri8sythh4UOzGli1hPm61hPhNHtBoOlPZ3ezAbH+fD
         qXqifJI8RXrYjrbJOPx9LYpTNVi28c3QKG/4cCgB335yz24/HAIVCWgJXx7VYhLLZsmW
         5Df30FFg1CnPv5i6DoKHkKsocong8Pd6uizXtNb/XeSDkp8TdFRopvf5IFJfOpWNyiYY
         qhQQ==
Received: by 10.182.202.104 with SMTP id kh8mr4346164obc.1.1333856636183; Sat,
 07 Apr 2012 20:43:56 -0700 (PDT)
Received: by 10.182.53.98 with HTTP; Sat, 7 Apr 2012 20:43:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194971>

Hello,

I'm implementing Git using node.js, and I have a question while I
write some code to store tree object.

Tree object looks a table consists of three fields: blob's mode, name
and id, as below.

e.g.)
$ git cat-file -p 45799547
100644 blob cd242b1e5bb403500feb49a1aa656c21c6c0be69	Makefile
100644 blob bf382321749577d52bd2fbf2281df0510b4bad31	README.md
100644 blob 5441bb48428611a3cb140d8192d39484fcf3b742	fsutil.js
100644 blob 0af680a5c0dd4482b09aa7f8e837234bed0b7cfa	package.json
040000 tree 39a4d45669addfb1e8f0a499deebc5b97b4edfa0	test

It seems that the table is stored in order by blob's name.

If it is true, what happens if it is not ordered?

Does that cause any troubles to users to use a git repository created
and managed by my Git implementation?
