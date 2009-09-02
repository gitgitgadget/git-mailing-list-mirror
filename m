From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] Import git show output easily
Date: Wed, 2 Sep 2009 21:54:53 +0100
Message-ID: <b0943d9e0909021354y3c795265p693131b44928e0fe@mail.gmail.com>
References: <20090902175039.21633.25294.stgit@pc1117.cambridge.arm.com>
	 <a1e915350909021351l315358a0s9d8c076440bc0fb7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 02 22:55:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Miwr8-0004JH-3E
	for gcvg-git-2@lo.gmane.org; Wed, 02 Sep 2009 22:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbZIBUyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Sep 2009 16:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbZIBUyx
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 16:54:53 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:51324 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbZIBUyw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Sep 2009 16:54:52 -0400
Received: by bwz19 with SMTP id 19so1034502bwz.37
        for <git@vger.kernel.org>; Wed, 02 Sep 2009 13:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2DUMy3RmD4W53L0xVlDQLAoaDKZVi6ZqHW5++aGHmF4=;
        b=Dum3nvoLzLsuKFzBhLZi7RznDfbAWA0CPVuwx61UNU9vWPYocNZaHW7QM9M3Oekz9G
         8Kqeu6TNfSXzj2uzRmGyhwLj8CO85PtYTAKWn3/xLFnwRUj7w5r7nLHamASNvt+MnAMx
         gEnicErJF8vWyZO7vi8BZVkqHVF647sp4GXEI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TsIEjhaJ9wueIGTawW8cBEX3jotWyZ0BWqiEyN0Spv16rGBEwQgveOufKt0VrLcfYk
         726KTt8JILpRBMwX7DJlkGRz4aE0AijbqB1eKvgDiOwAAxXi178wxGol8Kk9qoGtfrHx
         yhMLD29BihdbfmJVn7EH2YI7UseOAfgVyDdmM=
Received: by 10.223.144.67 with SMTP id y3mr3820191fau.40.1251924893775; Wed, 
	02 Sep 2009 13:54:53 -0700 (PDT)
In-Reply-To: <a1e915350909021351l315358a0s9d8c076440bc0fb7@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127631>

2009/9/2 Gustav H=E5llberg <gustav@gmail.com>:
> It would really rock if stg import could handle the regular patch "-p=
<N>" flag.
> In particular, I miss -p0 as some broken versioning systems default t=
o
> such output.

It's probably just a matter of passing the right flag to git-apply.
I'll try to have a look before -rc3.

--=20
Catalin
