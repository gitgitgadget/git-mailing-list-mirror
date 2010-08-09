From: =?UTF-8?B?xLBzbWFpbCBEw7ZubWV6?= <ismail@namtrac.org>
Subject: Encoding problem on OSX?
Date: Mon, 9 Aug 2010 16:58:57 +0300
Message-ID: <AANLkTiky2uUHfOsh8rNXZPEqTLcNSZowy=Qcm+4Hjn_n@mail.gmail.com>
References: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 09 16:03:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiSx6-0002jY-QF
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 16:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab0HIN7S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Aug 2010 09:59:18 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53890 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756424Ab0HIN7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Aug 2010 09:59:18 -0400
Received: by gxk23 with SMTP id 23so3404828gxk.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 06:59:17 -0700 (PDT)
Received: by 10.150.132.17 with SMTP id f17mr17705271ybd.442.1281362357358; 
	Mon, 09 Aug 2010 06:59:17 -0700 (PDT)
Received: by 10.231.206.198 with HTTP; Mon, 9 Aug 2010 06:58:57 -0700 (PDT)
In-Reply-To: <AANLkTikh12guRxCK2Vf=WvshzX8P-fYTyu3qxYWNJ2px@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152964>

Hi all;

On master & maint branch,=C2=A0t4201-shortlog.sh test 2 fails with:

expecting success:

git shortlog HEAD >log &&
fuzz log >log.predictable &&
test_cmp expect.template log.predictable

--- expect.template 2010-08-09 13:45:46.000000000 +0000
+++ log.predictable 2010-08-09 13:45:46.000000000 +0000
@@ -1,8 +1,8 @@
=C2=A0A U Thor (5):
=C2=A0=C2=A0 =C2=A0 =C2=A0 SUBJECT
=C2=A0=C2=A0 =C2=A0 =C2=A0 SUBJECT
- =C2=A0 =C2=A0 =C2=A0SUBJECT
- =C2=A0 =C2=A0 =C2=A0SUBJECT
+ =C2=A0 =C2=A0 =C2=A0SUBJECT=F0=9D=84=9Es =F0=9D=84=9Es a very, very l=
ong f=F0=9D=84=9Erst l=F0=9D=84=9Ene for the comm=F0=9D=84=9Et
message to see =F0=9D=84=9Ef =F0=9D=84=9Et =F0=9D=84=9Es wrapped correc=
tly
+ =C2=A0 =C2=A0 =C2=A0SUBJECT????s ????s a very, very long f????rst l??=
??ne for the
comm????t message to see ????f ????t ????s wrapped correctly
=C2=A0=C2=A0 =C2=A0 =C2=A0 SUBJECT

I am not sure if this is a known problem so I am reporting it.

Regards,
ismail
