From: Alexander Gladysh <agladysh@gmail.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local changes
Date: Wed, 7 Apr 2010 05:07:23 +0400
Message-ID: <x2kc6c947f61004061807yf6d63879s5d37bd735b39ded8@mail.gmail.com>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
	 <20100406233601.GA27533@progeny.tock>
	 <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
	 <20100407004353.GA11346@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 03:07:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzJjv-0007Ij-U7
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 03:07:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332Ab0DGBH1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 21:07:27 -0400
Received: from mail-pz0-f193.google.com ([209.85.222.193]:48569 "EHLO
	mail-pz0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756117Ab0DGBH0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 21:07:26 -0400
Received: by pzk31 with SMTP id 31so554870pzk.33
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 18:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5q2y4JjDngnchVvCF4UPI4q1AJ9sz9dumW39YDXuDcY=;
        b=BP5cEhvNhB5ZXbfWC6plVQKliCVmRZoBURIKOtdqhHMJ1d1ZZEZnxGycW1UIuSitGq
         krEzujuoMEVjozmCTMItrhKNuhr6ozLTr4PXTqqD4+8q01yawrllKz6/NO6ntQPTPiER
         WWeftAt5oMLIWlTk/OUMYW6mY4rFj5ah6iHEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sfEp9/ROBSsD279usVsnzV5onitFSsNmtKSA112uDjduvKRABr45VBddJbd1AKYe58
         IiVVdOiWHKlK5qeiaU607khI0yhJQAwAZLnoIQQCPxqsFHeg/PDrUS1uP00f5496V/1w
         E6YOiZY2D7i5bjIwkZTSh1d57EI80VMLc7N9E=
Received: by 10.140.194.5 with HTTP; Tue, 6 Apr 2010 18:07:23 -0700 (PDT)
In-Reply-To: <20100407004353.GA11346@progeny.tock>
Received: by 10.140.83.40 with SMTP id g40mr6464541rvb.223.1270602443823; Tue, 
	06 Apr 2010 18:07:23 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144185>

On Wed, Apr 7, 2010 at 04:43, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Most git porcelain silently refreshes stat-dirty index entries. =A0Te=
ach
> gitk to, too; this will make the behavior easier to understand when a
> person makes a change to a file and then changes mind and restores th=
e
> old version in her editor of choice.

This patch fixes my problem, thank you!

Alexander.
