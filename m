From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: In tree object, must the blobs are ordered?
Date: Sun, 8 Apr 2012 13:13:52 +0900
Message-ID: <CAFT+Tg-6HVB3ij0oa8xaY+jRqKDVY+D=uQ_LhTgXL3tva0tYPg@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 08 06:14:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGjWH-0002Yy-72
	for gcvg-git-2@plane.gmane.org; Sun, 08 Apr 2012 06:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819Ab2DHENx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Apr 2012 00:13:53 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49837 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773Ab2DHENx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Apr 2012 00:13:53 -0400
Received: by obbtb18 with SMTP id tb18so4623637obb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 21:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=o2MtwgYvlO9JeJSL7wBrLlFcCPFVSDFlFnOjiJh3X5c=;
        b=pMKFqbqHEk0RXbBjOp2IR+0ntVpVawKaZwqhiUBU71zXcyOvC7/nP3E8sZS8gDueuD
         tSk/5Ha/zJ2oeihQEclq/1xlVLzwXaT//mN/LG1dlhNUqQ11w5iM+wnkzruli639/uwl
         HrMoCWaMnoYIkl1VIVULRBgjTFl70Z/5QFua+rVEUjsWQy4+wsCUaPePB4ZkWUUs9es/
         KCj3sBQzEWgbNi3lrhq0QawWdfzsjOSV5sNz4V0kNbFG6jmirqzEP1k2qN0a3345T7wo
         8mvWfac5qLJCStuGftE2T1aQWxig4m/L54y1AJTrp+CGx3Yy2m/xD4hiUZHyinqts27s
         FLpQ==
Received: by 10.182.16.1 with SMTP id b1mr4326470obd.31.1333858432416; Sat, 07
 Apr 2012 21:13:52 -0700 (PDT)
Received: by 10.182.53.98 with HTTP; Sat, 7 Apr 2012 21:13:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194972>

Oops, the title was wrong.

2012=B3=E2 4=BF=F9 8=C0=CF =BF=C0=C8=C4 12:43, Yi, EungJun <semtlenori@=
gmail.com>=B4=D4=C0=C7 =B8=BB:
> Hello,
>
> I'm implementing Git using node.js, and I have a question while I
> write some code to store tree object.
>
> Tree object looks a table consists of three fields: blob's mode, name
> and id, as below.
>
> e.g.)
> $ git cat-file -p 45799547
> 100644 blob cd242b1e5bb403500feb49a1aa656c21c6c0be69    Makefile
> 100644 blob bf382321749577d52bd2fbf2281df0510b4bad31    README.md
> 100644 blob 5441bb48428611a3cb140d8192d39484fcf3b742    fsutil.js
> 100644 blob 0af680a5c0dd4482b09aa7f8e837234bed0b7cfa    package.json
> 040000 tree 39a4d45669addfb1e8f0a499deebc5b97b4edfa0    test
>
> It seems that the table is stored in order by blob's name.
>
> If it is true, what happens if it is not ordered?
>
> Does that cause any troubles to users to use a git repository created
> and managed by my Git implementation?
