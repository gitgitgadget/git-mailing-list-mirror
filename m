From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: --color-diff='.' considered useful
Date: Mon, 16 Nov 2015 15:25:55 +0100
Message-ID: <5649E773.7040705@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 16 15:26:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyKjL-00017K-F7
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 15:26:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbbKPOZ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Nov 2015 09:25:59 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:34460 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750778AbbKPOZ6 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Nov 2015 09:25:58 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 16A5E2039E
	for <git@vger.kernel.org>; Mon, 16 Nov 2015 09:25:58 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 16 Nov 2015 09:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=NAw
	7+y5w9H6Vb4UOObR0A2l/eHE=; b=RF5uFR3St5fjdbxYA2lKfU2HADivVYNu0Ea
	qKKn2NjjCr9+ZcTDHGgQOPgZ9npAmJ0Tba7khTaQoCubajwIdV+q4xmI5SCEH4te
	Uy58mZq5m8DsyPYouwPQwLPvEZc5WB/nVdkb2P/wl4V/+nMJhZmirAfSvtKkqZob
	7/hWJ3fI=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=content-transfer-encoding:content-type
	:date:from:message-id:mime-version:subject:to:x-sasl-enc
	:x-sasl-enc; s=smtpout; bh=NAw7+y5w9H6Vb4UOObR0A2l/eHE=; b=i8vZm
	DVB8dNh+EInpsbLIkDqOyxR3QRkPwuggvdGBukLg8VES7w05pQE10yZGlS59T1E7
	d4bapy9uLtIVy1CgfZIKdIZ2K1cMPUPiB2a2lN8QZ2UZhhq7rlMSiQt9z/Jc10J8
	Z+G6H4viJ8uIVNIV6bVPkrV3fpm7OO3WnvUSQw=
X-Sasl-enc: 6CfXvnaiBuxzPwqVaKHiqoN6MPUTrq1RkOKfXWLpiKo5 1447683957
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id AB228C018FA
	for <git@vger.kernel.org>; Mon, 16 Nov 2015 09:25:57 -0500 (EST)
X-Mozilla-News-Host: news://news.gmane.org:119
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281343>

git tip of the day:

git diff --color-words=3D'.'
git show --color-words=3D'.'

That will help you find that 1 character change that a failed default
word split hides from your eyes.=EF=BB=BF

I guess everyone here will know already, but I found that super useful
and much easier than trying to get a meaningful word split for that 100=
+
char TeX source line without a single space...

Cheers,
Michael
