From: "Aaron Gray" <aaronngray.lists@googlemail.com>
Subject: Re: git svn teething problems - initial clone okay - fetches not working
Date: Mon, 23 Mar 2009 21:31:22 -0000
Message-ID: <0381B9A616514FC2A05BACAB07EE3117@HPLAPTOP>
References: <2BACA6CC2F9647C19C0463120219E694@HPLAPTOP> <49C7F92A.5050809@obry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: <pascal@obry.net>
X-From: git-owner@vger.kernel.org Mon Mar 23 22:33:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlrlW-00070x-EZ
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 22:33:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756435AbZCWVbf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 17:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752982AbZCWVbe
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 17:31:34 -0400
Received: from mail-ew0-f165.google.com ([209.85.219.165]:60242 "EHLO
	mail-ew0-f165.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757803AbZCWVbd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 17:31:33 -0400
Received: by ewy9 with SMTP id 9so1832248ewy.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 14:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:cc
         :references:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        bh=OKrUdisDCo0rPVvH/JCC4y4WK6ZexctaJSoDqD1wcmM=;
        b=tgd331SaaC1/LRJS0depiKegXu8lo9P7TJ0jlqcN6IwVpKY47PFPlSRradbPsu63pd
         HTMzwEbPBJJuXH+6mYW+SwIBeJjGL/09w54l47wiOH3WMx7wPZYtZjp76PT3EO5Dm56T
         kr02c3JCCwZUHTsg2iMRhLmmD7dUiJp1dHn6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:from:to:cc:references:subject:date:mime-version
         :content-type:content-transfer-encoding:x-priority:x-msmail-priority
         :x-mailer:x-mimeole;
        b=cftxkrVJSxGAzmlWjq0D9vXU49Q5iTZbcjzwtZbtcjJwsbOCo3Dmoj/mIKamHP8Cqp
         5dd3k5DN1sHRZ2RZAUFoHv1BaFMHt2/uW/vJeVx3TTiRjM22CPdN5WbRntXqe3SOykPS
         LcgbwX15goIL+mTtC9c5IP3kVGggaO6Lk6vlo=
Received: by 10.216.10.82 with SMTP id 60mr2824774weu.180.1237843890224;
        Mon, 23 Mar 2009 14:31:30 -0700 (PDT)
Received: from HPLAPTOP (aarongray.demon.co.uk [80.177.163.94])
        by mx.google.com with ESMTPS id 6sm5640501nfv.24.2009.03.23.14.31.28
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 14:31:29 -0700 (PDT)
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114352>

> Aaron Gray a =E9crit :
>> Anyway I am having the problem that I can do a 'git svn fetch' and I=
 see
>> changes coming in. But the gitweb and another git clone from it do n=
ot
>> reflect those changes. The repository is still showing its two days =
old.
>
> You need a:
>
>   $ git svn rebase

I tried that.

> to fetch *and* merge the changes into the local tracking branch (mast=
er
> by default).

Pascal,

Could you give me a full set of instructions for importing :-

    http://llvm.org/svn/llvm-project/llvm

Thanks,

Aaron
