From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: Recording merges after repo conversion
Date: Tue, 30 Oct 2007 15:29:44 +0100
Message-ID: <8c5c35580710300729t4a7b375dud01253d9b4ef7196@mail.gmail.com>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se>
	 <13D1D3DD-9652-4097-8364-DEF4F26540D3@lrde.epita.fr>
	 <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Benoit SIGOURE" <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: "Peter Karlsson" <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 30 15:30:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ims6T-000748-W0
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 15:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbXJ3O3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 10:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbXJ3O3s
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 10:29:48 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:2056 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbXJ3O3s (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 10:29:48 -0400
Received: by nz-out-0506.google.com with SMTP id s18so1459270nze
        for <git@vger.kernel.org>; Tue, 30 Oct 2007 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=h/7OI+n5kdwEZtRU3NZWPlMwZIlis2lIU6EXYJeEmLE=;
        b=IM2QQ8Sd+Mr4hC1MBY8jvvlEgvAFmlrAwlnSKMIkV6hFYyO4HD+Dl5wsIUKlhW+S7z4yn5G7E3nWnXGKlLQOtQDjy5EHpehAxfFu6DK9cr9pz8YcUt6i10HptxRaDnYcOWFpGAMPK3eDil01K/pggCWbxXNiKVThmxq7UVy455c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QdAHWTTNAtUZE7h5sKt2NTeEIVDTBaWntU3aVRVhm1523ICK+CxTg88rT1MaXyshvF8T2ng8MPT1On7v8ZQqeSGnL/th2jgKPXEImUh9Kmjp5GoFLhWJFXhk3dgLwbs++nVh7H9XXkjd20lv0AJMnaUKimtawAzJNyFaH5PmPmg=
Received: by 10.114.103.1 with SMTP id a1mr4143567wac.1193754584421;
        Tue, 30 Oct 2007 07:29:44 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Tue, 30 Oct 2007 07:29:44 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.62.0710301433150.652@perkele.intern.softwolves.pp.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 10/30/07, Peter Karlsson <peter@softwolves.pp.se> wrote:
> Benoit SIGOURE:
>
> > I think you can use grafts do achieve this.
>
> That seems to work, but the grafts list doesn't seem to propagate when I
> push/pull/clone. Is it possible to get that to work?
>

No, the grafts file is purely local. To achieve your goal, you'd have
to 'git filter-branch' before pushing/cloning. But beware: this _will_
rewrite your current branch(es).

--
larsh
