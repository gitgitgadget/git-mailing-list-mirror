From: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 00/13] Eliminate 'top' and 'bottom' files
Date: Sun, 16 Sep 2007 12:25:02 +0200
Message-ID: <FB41854B-DC41-4E9F-89E3-2300EE616FD4@lysator.liu.se>
References: <20070914222819.7001.55921.stgit@morpheus.local> <20070915234244.GD25507@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=ISO-8859-1;
	delsp=yes	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin.marinas@gmail.com
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 12:25:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWrJQ-0005f3-SM
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 12:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbXIPKZI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 16 Sep 2007 06:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbXIPKZH
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 06:25:07 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:47037 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396AbXIPKZG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 Sep 2007 06:25:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id BDD90200A1FD;
	Sun, 16 Sep 2007 12:25:05 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 03489-01-6; Sun, 16 Sep 2007 12:25:05 +0200 (CEST)
Received: from [192.168.1.198] (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	by mail.lysator.liu.se (Postfix) with ESMTP id F2771200A1FC;
	Sun, 16 Sep 2007 12:25:04 +0200 (CEST)
In-Reply-To: <20070915234244.GD25507@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.752.3)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58310>


16 sep 2007 kl. 01.42 skrev Karl Hasselstr=F6m:

> On 2007-09-15 00:31:09 +0200, David K=E5gedal wrote:
>
>> The following series removes the 'bottom' and 'top' files for each
>> patch, and instead uses the commit objects to keep track of the
>> patches.
>
> Wonderful! Does this ensure that there's a bijection between patches
> and commits at _all_ times, or am I missing something?

That's the intention, at least. As far as I could tell, the biject =20
already held, except temporarily in the middle of executing some =20
commands.  So I had to refactor them to never create that intermedate =20
state.

>> The last two patches do the final cleansing. Obviously, this changes
>> the format, and the format version should be increased and and
>> update function be written. So it's not really ready to go in yet.
>
> It's a trivial format update, though: just delete those two files and
> increase the number from 2 to 3.
>
> Hmm, wait, no. Right. We also have to create commits for those patche=
s
> that don't have exactly one commit object. Not that there'll be many
> of them, but better not make assumptions ...

I haven't seen any such patches, but I haven't tried everything. =20
Neither do the test suite test everything.

--=20
David K=E5gedal
davidk@lysator.liu.se
