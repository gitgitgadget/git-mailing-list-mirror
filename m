From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 14:08:35 +0100
Message-ID: <998d0e4a0802230508w12f236baiaf2d9ab5f364670a@mail.gmail.com>
References: <200802221837.37680.chase.venters@clientec.com>
	 <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr>
	 <20080223014445.GK27894@ZenIV.linux.org.uk>
	 <7vfxvk4f07.fsf@gitster.siamese.dyndns.org>
	 <20080223020913.GL27894@ZenIV.linux.org.uk>
	 <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com>
	 <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
	 <20080223113952.GA4936@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Charles Bailey" <charles@hashpling.org>,
	LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 14:09:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSu7w-0006Ny-Lo
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 14:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756693AbYBWNIj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 08:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbYBWNIi
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 08:08:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:30578 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756541AbYBWNIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 08:08:36 -0500
Received: by wx-out-0506.google.com with SMTP id h31so712795wxd.4
        for <git@vger.kernel.org>; Sat, 23 Feb 2008 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vFupO5zcJCOX1+SHx387bHEYUbpbdbsyxEmhv/LcSx0=;
        b=oTZHEnGh8En7LHdS7TuEeXAxp5M86zfgkyjHZ24ybTEPPdTkzcIcyMtH2eQ8ocE+v3BJ71Em6zI+7nvq0cOfleDVhpHBJiJJBwmq0Nms8LDwfyZzZ0RDsA4USi2NxqtCm3cnKxG0JHeAbphzzzB1iwp0IrRRa8qa9Gbut2f8cmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uzy3m/+NzmbZ/mpKT2SIWVhAsvAQ6U/13J1eAdiUXshNMaUvor/3NRt2LuHE0yx1iS+OwMbRH+j1d7QzHNbfdamr7RXPzUWVjsQs2TpgAejkCXcND6G71t3TsvTUAFoevrcb13fDjf0PCT+HKsqUTCG7CzFHjHo+UyC7V1TxBCk=
Received: by 10.70.80.6 with SMTP id d6mr273836wxb.15.1203772115418;
        Sat, 23 Feb 2008 05:08:35 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Sat, 23 Feb 2008 05:08:35 -0800 (PST)
In-Reply-To: <20080223113952.GA4936@hashpling.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74820>

On 2008/2/23, Charles Bailey <charles@hashpling.org> wrote:
> On Sat, Feb 23, 2008 at 03:47:07AM +0100, J.C. Pizarro wrote:
>  >
>  > Yesterday, i had git cloned git://foo.com/bar.git   ( 777 MiB )
>  >  Today, i've git cloned git://foo.com/bar.git   ( 779 MiB )
>  >
>  >  Both repos are different binaries , and i used 777 MiB + 779 MiB = 1556 MiB
>  >  of bandwidth in two days. It's much!
>  >
>  >  Why don't we implement "binary delta between old git repo and recent git repo"
>  >  with "SHA1 built git repo verifier"?
>  >
>  >  Suppose the size cost of this binary delta is e.g. around 52 MiB instead of
>  >  2 MiB due to numerous mismatching of binary parts, then the bandwidth
>  >  in two days will be 777 MiB + 52 MiB = 829 MiB instead of 1556 MiB.
>  >
>  >  Unfortunately, this "binary delta of repos" is not implemented yet :|
>
>
> It sounds like what concerns you is the bandwith to git://foo.bar. If
>  you are cloning the first repository to somewhere were the first
>  clone is accessible and bandwidth between the clones is not an issue,
>  then you should be able to use the --reference parameter to git clone
>  to just fetch the missing ~2 MiB from foo.bar.
>
>  A "binary delta of repos" should just be an 'incremental' pack file
>  and the git protocol should support generating an appropriate one. I'm
>  not quite sure what "not implemented yet" feature you are looking for.

But if the repos are aggressively repacked then the bit to bit differences
are not ~2 MiB.
