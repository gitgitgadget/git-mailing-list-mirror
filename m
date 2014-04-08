From: "K. Kwan" <kkwansj_888@yahoo.com>
Subject: Changes based on a branch not yet merged back to master
Date: Tue, 8 Apr 2014 11:22:44 -0700 (PDT)
Message-ID: <1396981364.85181.YahooMailNeo@web121903.mail.ne1.yahoo.com>
References: <1396956140.85747.YahooMailNeo@web121901.mail.ne1.yahoo.com>
Reply-To: "K. Kwan" <kkwansj_888@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 08 20:22:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WXafg-0006Fo-Bi
	for gcvg-git-2@plane.gmane.org; Tue, 08 Apr 2014 20:22:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932823AbaDHSWt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Apr 2014 14:22:49 -0400
Received: from nm21-vm4.bullet.mail.ne1.yahoo.com ([98.138.91.181]:26062 "EHLO
	nm21-vm4.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932820AbaDHSWp convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 8 Apr 2014 14:22:45 -0400
Received: from [98.138.100.103] by nm21.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:22:44 -0000
Received: from [98.138.87.5] by tm102.bullet.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:22:44 -0000
Received: from [127.0.0.1] by omp1005.mail.ne1.yahoo.com with NNFMP; 08 Apr 2014 18:22:44 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 937392.37015.bm@omp1005.mail.ne1.yahoo.com
Received: (qmail 85836 invoked by uid 60001); 8 Apr 2014 18:22:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1396981364; bh=x6l+xEaPfKJE8zTqZf7hAG3+21bbdF8su6Y2LcOohLw=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=2yAthIgDqWaSx1tq+U06Xdz0nalwu0mJoLMoyjSpC3YAVsXtAmxnpZWHkDL6lhUhni+zyqyS9rzLA/TAt+7feIh86sKcLZ10kSr3zeSt0vTc1u/Ef2WQZl1EEmab8jgk4drnbA1RFIn71e6dXbeNsZkkXj23zb2IBEKCHSftB5E=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=xyGjnn0oUWb1QtItcajswjC+XwNVXMfcR6GL6tG65xJTs7WbeVoKJeNU9c5c75fOffoIDgMnJQ2JmG4wIoUtEQPbYYkDkQUC21Oe0p9ypuX/vg9aKCEH4lXDRU58g4dNgiln3HlYRW7QzD61AP53zA1AbGM2U93g9abvpJSiOZU=;
X-YMail-OSG: mKUDwpoVM1lAzMwSw0G7KPUOszoxT.KVt3Jm5qcgbMbmUXq
 T.uRXQsCIVmwGFtLHdUys4ZPdhTs_YEh1erM9Q090ru45ftomOMR9AVELPHS
 S.r0WoPXAq2gQb8mAkoycxjDSVLUaebhJWKbHID4X2ZV7JOR.HFBH3MJcETF
 37Bf97TEFxg2PNTP49pfKCtCjERqOIkUxLBuhMFcw.pVuYs7rc8oWSOZXv5Y
 f6fyOSpmGWQdBQuYTmNviIZ.jtdkPgYiU4IQl9nb6E7_Sc7hdUtSiG6N0RqT
 FOJo8C1t58wc8qx2YG9X5V2DUDxamHw4F907n7RMaSZ2tCtmOmxyccPHjxFZ
 XV7i3mD1aC.RCHODF.Z4f4ZFcDJmOKjxMUiBDqkmxHVknBNDdGt4Z1t8y_6o
 svtwv28wzUtPCZ8mmTFRTZlIaj4CEdYHIt1UOoavmZxF2vitbzfv_By8mq2V
 40cF58mcMEOi10u1scdaGOHCNcZrgxnvpbWPnlJOJb1cgmSmPvTxxv5S3Aom
 px3P39wnO4PUZGmA8oRSDM21p7GYD2cqVYfALTg2eu.jbiU1p
Received: from [98.207.18.107] by web121903.mail.ne1.yahoo.com via HTTP; Tue, 08 Apr 2014 11:22:44 PDT
X-Rocket-MIMEInfo: 002.001,CkkgaGF2ZSBhIGZlYXR1cmUgYnJhbmNoIChBKSBjb250YWluaW5nIGNoYW5nZXMgYXdhaXRpbmcgY29kZSByZXZpZXcuIEkgbm93IG5lZWQgdG8gYmVnaW4gd29yayBvbiBuZXcgZmVhdHVyZSAoQikgdGhhdCBpcyBkZXBlbmRlbnQgb24gbmV3IGZpbGVzIGFuZCBjaGFuZ2VzIG1hZGUgaW4gYnJhbmNoIChBKS4KCgpJcyB0aGVyZSAicHJvcGVyIiB3YXkgdG8gcmViYXNlIGp1c3QgdGhlIGNoYW5nZXMgbWFkZSBpbiBicmFuY2ggKEIpIGJhY2sgb250byBtYXN0ZXIgKE0pIGJyYW5jaCByZXN1bHRpbmcgZnJvbSABMAEBAQE-
X-Mailer: YahooMailWebService/0.8.182.648
In-Reply-To: <1396956140.85747.YahooMailNeo@web121901.mail.ne1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245940>


I have a feature branch (A) containing changes awaiting code review. I =
now need to begin work on new feature (B) that is dependent on new file=
s and changes made in branch (A).


Is there "proper" way to rebase just the changes made in branch (B) bac=
k onto master (M) branch resulting from the merge of branch (A)


My tree would look like this:

- x - x - x (master)=20

=A0=A0=A0=A0=A0=A0 \ x - x (A) x - x (B)


But after merge of branch (A), I would like it to look like this:

- x - x - x ---- x (master)
=A0=A0=A0=A0=A0=A0 \=A0=A0=A0=A0=A0=A0=A0=A0/ \
=A0=A0=A0=A0=A0=A0=A0=A0x - x (A)=A0=A0x - x (B)


Perhaps this?

$ git checkout master
$ git pull origin master
$ git merge A
$ git rebase --onto master A B


Regards.
