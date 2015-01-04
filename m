From: =?UTF-8?B?Sm/DsyDDgWTDoW0=?= <adam@jooadam.hu>
Subject: git stash fails on symlinked directory
Date: Sun, 4 Jan 2015 05:24:18 +0100
Message-ID: <CAKZ+miDM+cEShR2L4a5cbdSOO6=OJinA4NprkG7pLsLSnN_s8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 04 05:24:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7ckD-00075v-6v
	for gcvg-git-2@plane.gmane.org; Sun, 04 Jan 2015 05:24:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbbADEYU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Jan 2015 23:24:20 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:53158 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752213AbbADEYT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Jan 2015 23:24:19 -0500
Received: by mail-qg0-f43.google.com with SMTP id z107so14193286qgd.16
        for <git@vger.kernel.org>; Sat, 03 Jan 2015 20:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=1CdFFIfhhGATidZ2aQv/HhS5rEdHa4IjtXZcU4Hhhao=;
        b=zlxXYn4b0/OHSLRPDDpInsnX0AZOh5yAgR8NoEpCl75VN7a5vBLywPftbNCAdDlbUe
         MTQ2NmNJ68lWLnZkGIwBxQNQLTEH5277CPFuCNKFKkjnuD/ISIrwv0A5INpImgjsuAqA
         87tU5eg7yGM6ZV33qUbAoBvlCnqzxncZBUz4YMxXAzILi2frSfyAyeFfecUfv8cVAsFM
         7OXYxyVD8ei/dZpEr2VKfFGQitc5vxjQGQNsgOPndMpI+ksksoldPannMWyPGz1dgOaQ
         +YGOgtG32ZQBcxTl8zo8QOcoUFpKjWxj7oTPEijsE7fd2hd51hWBc/DgUEwTchQVK3lQ
         7rHw==
X-Received: by 10.140.82.136 with SMTP id h8mr127652107qgd.75.1420345458746;
 Sat, 03 Jan 2015 20:24:18 -0800 (PST)
Received: by 10.140.20.243 with HTTP; Sat, 3 Jan 2015 20:24:18 -0800 (PST)
X-Google-Sender-Auth: ImdL1WfOjfexiAf8X_DVx5uzYYc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262001>

Hello,

I=E2=80=99ve just run into this issue described earlier elsewhere:

* http://permalink.gmane.org/gmane.comp.version-control.git/241909
* https://groups.google.com/forum/#!topic/git-users/hbhf7-QTbFM

Is this a bug (it certainly seems like one to me). Is this something
developers are aware of?


Thanks,
=C3=81d=C3=A1m
