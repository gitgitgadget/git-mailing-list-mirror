From: Michael Ludwig <michael.ludwig@xing.com>
Subject: Re: git status showing phantom modifications
Date: Mon, 25 Jan 2010 12:43:45 +0100
Message-ID: <4017EB11-4B29-4599-B19A-91BC39632BBF@xing.com>
References: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>
 <be6fef0d1001250303p2c12381ao7d3a8a1d48eebb56@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 25 12:50:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZNSF-00028e-45
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 12:50:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752690Ab0AYLt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 06:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616Ab0AYLt5
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 06:49:57 -0500
Received: from mail43-3.xing.com ([62.96.140.163]:55552 "EHLO
	mail43-3.xing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596Ab0AYLt4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 06:49:56 -0500
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jan 2010 06:49:56 EST
Received: from localhost (localhost [127.0.0.1])
	by mail43-3.xing.com (Postfix) with ESMTP id DB32F30004931
	for <git@vger.kernel.org>; Mon, 25 Jan 2010 12:43:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xing.com; h=
	mime-version:content-transfer-encoding:content-type
	:content-language:accept-language:in-reply-to:references
	:message-id:subject:date:from:received:received:received:
	x-virus-scanned; s=main; t=1264419826; bh=/OhBDovxsYx5RdkracuVy2
	Mb1bPwIECsUkYCz13v2rU=; b=CIdaqFu0povu/mFS6Cp7qgiA2ccK0tuEiCuqJd
	jheDIahj+6IZWKAqpEvN/jCi2vxhNekudmyqub8ErcX52XN1vnRgrV40ip+1EdXw
	Hyxp4nQ+YrHcvtYolyiV2AdFCizoqdhQycFBBCualspvMSBXyN+hpI1w4+FE2+4y
	THHqc=
X-Virus-Scanned: Debian amavisd-new at obc-mail43-3.rz.xing.com
Received: from mail43-3.xing.com ([127.0.0.1])
	by localhost (obc-mail43-3.rz.xing.com [127.0.0.1]) (amavisd-new, port 10030)
	with ESMTP id IUDNXdXlgmu4 for <git@vger.kernel.org>;
	Mon, 25 Jan 2010 12:43:46 +0100 (CET)
Received: from luftpostix.xing.hh (unknown [172.20.1.5])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail43-3.xing.com (Postfix) with ESMTPS id C47CB3000078C
	for <git@vger.kernel.org>; Mon, 25 Jan 2010 12:43:46 +0100 (CET)
Received: from luftpostix.xing.hh ([172.20.1.5]) by luftpostix.xing.hh
 ([172.20.1.5]) with mapi; Mon, 25 Jan 2010 12:43:46 +0100
Thread-Topic: git status showing phantom modifications
Thread-Index: Acqds6bOJ4GMjyH5RAqtIx3WrId17w==
In-Reply-To: <be6fef0d1001250303p2c12381ao7d3a8a1d48eebb56@mail.gmail.com>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137956>

Am 25.01.2010 um 12:03 schrieb Tay Ray Chuan:
> On Mon, Jan 25, 2010 at 6:41 PM, Michael Ludwig <michael.ludwig@xing.com> wrote:
>> michael@wladimir:/cygdrive/m/REPOS6.TECH.git/comp :-) git st
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working directory)
>> #
>> #       modified:   mw/wsdl-version.txt
>> #       modified:   net/httpsrvr/iis6.wodo
>> #       ... and about 100 more of that ...
> 
> try running git diff. I suspect the changes are to filemodes. What
> does your git config look like regarding this (particularly
> core.fileMode)?

Running git diff informed me there were no changes to content, which is
what I forgot to add to the description of the problem.

Unfortunately, right now I'm not at the system where this occurred, so
I can't say what git config looks like. I did not, however, make any
customization other than user.email and alias.st and some others.

Reading up about core.fileMode in git-config(1), I think you've pointed
me to the solution. I should probably just set it to false. If that doesn't
solve the issue, I'll report back.

Google also found me an old patch that might be related to the problem:

[PATCH] Force core.filemode to false on Cygwin.
http://marc.info/?l=git&m=116754085018507&w=2

-- 
Michael.Ludwig (#) XING.com
