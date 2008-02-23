From: "J.C. Pizarro" <jcpiza@gmail.com>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 03:47:07 +0100
Message-ID: <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com>
References: <200802221837.37680.chase.venters@clientec.com>
	 <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr>
	 <20080223014445.GK27894@ZenIV.linux.org.uk>
	 <7vfxvk4f07.fsf@gitster.siamese.dyndns.org>
	 <20080223020913.GL27894@ZenIV.linux.org.uk>
	 <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 23 03:47:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSkQU-0006TD-PS
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 03:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755744AbYBWCrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 21:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755743AbYBWCrK
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 21:47:10 -0500
Received: from wx-out-0506.google.com ([66.249.82.236]:29004 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707AbYBWCrI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 21:47:08 -0500
Received: by wx-out-0506.google.com with SMTP id h31so572989wxd.4
        for <git@vger.kernel.org>; Fri, 22 Feb 2008 18:47:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YI1gxVOhIiC46hWaUQDgh07mdvLsIdB3e8Td/XKZkeY=;
        b=SjfrELrMSeI0lM+HYIYhxxnn3VWYBipMSf1XfNxGsjTlhssiONCdqhcsxmzCaZQVroJ2dubM2d1K96y2IthsUr4a6YuZg5g0/ZLYWcd3fKPBti309uxmawTsHjFgGUWJ/RUVM+G5HwTuZ1k2nZPaO2gjM6FVwRi+uqHxdLRQm7U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OgCwEFRqggOVB8+1JA0dm2sHcoJPmYX87RhIxaHlJLV72SUlxEVvATxjELVufmVj/AmHEjVF8t1bGSqoY8AGJRrGH5YkB418GILq5SVr1SK5Oqmm3WDyIk19n+gvxFYgwOew1yGJcl76XGRviBA2asEKRG9Aj5F8LyvWcz2ikfE=
Received: by 10.70.32.10 with SMTP id f10mr516132wxf.20.1203734827656;
        Fri, 22 Feb 2008 18:47:07 -0800 (PST)
Received: by 10.70.40.12 with HTTP; Fri, 22 Feb 2008 18:47:07 -0800 (PST)
In-Reply-To: <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74791>

On 2008/2/23, Al Viro <viro@zeniv.linux.org.uk> wrote:
 > On Fri, Feb 22, 2008 at 05:51:04PM -0800, Junio C Hamano wrote:
 >  > Al Viro <viro@ZenIV.linux.org.uk> writes:
 >  >
 >  > > On Sat, Feb 23, 2008 at 02:37:00AM +0100, Jan Engelhardt wrote:
 >  > >
 >  > >> >do you tend to clone the entire repository repeatedly into a series
 >  > >> >of separate working directories
 >  > >>
 >  > >> Too time consuming on consumer drives with projects the size of Linux.
 >  > >
 >  > > git clone -l -s
 >  > >
 >  > > is not particulary slow...
 >  >
 >  > How big is a checkout of a single revision of kernel these days,
 >  > compared to a well-packed history since v2.6.12-rc2?
 >  >
 >  > The cost of writing out the work tree files isn't ignorable and
 >  > probably more than writing out the repository data (which -s
 >  > saves for you).
 >
 >
 > Depends...  I'm using ext2 for that and noatime everywhere, so that might
 >  change the picture, but IME it's fast enough...  As for the size, it gets
 >  to ~320Mb on disk, which is comparable to the pack size (~240-odd Mb).


Yesterday, i had git cloned git://foo.com/bar.git   ( 777 MiB )
 Today, i've git cloned git://foo.com/bar.git   ( 779 MiB )

 Both repos are different binaries , and i used 777 MiB + 779 MiB = 1556 MiB
 of bandwidth in two days. It's much!

 Why don't we implement "binary delta between old git repo and recent git repo"
 with "SHA1 built git repo verifier"?

 Suppose the size cost of this binary delta is e.g. around 52 MiB instead of
 2 MiB due to numerous mismatching of binary parts, then the bandwidth
 in two days will be 777 MiB + 52 MiB = 829 MiB instead of 1556 MiB.

 Unfortunately, this "binary delta of repos" is not implemented yet :|
