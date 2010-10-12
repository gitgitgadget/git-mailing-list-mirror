From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: git ls-files handles paths differently in Windows and Mac (probably Linux)
Date: Tue, 12 Oct 2010 17:24:56 +0400
Message-ID: <60B60680-78BD-4FFF-8472-8C853956CB1A@jetbrains.com>
References: <3C33A244-2449-4A3C-A8B5-2060CE61EE04@jetbrains.com> <4CB45E86.2030703@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 12 15:25:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5eqr-0002tS-72
	for gcvg-git-2@lo.gmane.org; Tue, 12 Oct 2010 15:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab0JLNZB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Oct 2010 09:25:01 -0400
Received: from mail.intellij.net ([213.182.181.98]:60779 "EHLO
	mail.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313Ab0JLNZA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Oct 2010 09:25:00 -0400
Received: (qmail 16518 invoked by uid 89); 12 Oct 2010 13:24:57 -0000
Received: by simscan 1.1.0 ppid: 16474, pid: 16509, t: 0.0132s
         scanners: regex: 1.1.0 clamav: 0.96
/m: 52
Received: from unknown (HELO loki-mac-pro.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@172.26.240.110)
  by mail.intellij.net with ESMTPA; 12 Oct 2010 13:24:57 -0000
In-Reply-To: <4CB45E86.2030703@viscovery.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158835>


Hannes,

how did you figure that? I mean - which tool did you use to see which f=
iles are accessed in Linux?=20



12.10.2010, =D7 17:11, Johannes Sixt =CE=C1=D0=C9=D3=C1=CC(=C1):

> Am 10/12/2010 14:14, schrieb Kirill Likhodedov:
>> I want to see which files were changed in the specific directory of =
my
>> working tree, so I call ls-files:
>>> git ls-files -douvm --exclude-standard -- MYDIR
>>=20
>> On Mac (and probably on Linux) git inspects the content of MYDIR and
>> gives me the status of not-indexed changes in this directory. On
>> Windows git gives the same result (only changes in MYDIR), but it sc=
ans
>> the whole repository!
>=20
> On Linux, this scans the whole repository, too. Therefore, at least t=
he
> Windows version should not be *that* wrong. ;-)
>=20
> -- Hannes

----------------------------------
Kirill Likhodedov
JetBrains, Inc
http://www.jetbrains.com
"Develop with pleasure!"
