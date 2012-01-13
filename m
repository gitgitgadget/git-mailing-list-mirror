From: "Dmitry A. Ashkadov" <dmitry.ashkadov@gmail.com>
Subject: Re: fetch for bare repository
Date: Fri, 13 Jan 2012 17:54:31 +0400
Message-ID: <4F103797.7060906@gmail.com>
References: <4F100A7B.3030001@gmail.com> <20120113134058.GB2850@centaur.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 14:54:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rlhaa-0000UB-Pv
	for gcvg-git-2@lo.gmane.org; Fri, 13 Jan 2012 14:54:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180Ab2AMNyf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Jan 2012 08:54:35 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2AMNye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2012 08:54:34 -0500
Received: by werb13 with SMTP id b13so404122wer.19
        for <git@vger.kernel.org>; Fri, 13 Jan 2012 05:54:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=uFTx6Hm09jh82S9CuZdvdqHg7I/awmGgKenmWvVF9vs=;
        b=F6jTxQBT6pBRjymNIts9yq2T8qMwYzRrFnN4DqrCBuvRGcRL+acc4mr9p9jb3tfKoG
         ygHgQOUgyDJzktd+qJrl7PsFEANUpDyaUZA2Uk/wpltrwTXLwhdrEiGWVAB1sAayNKrB
         gPXJVratQlMWjxMk8VS6hlyrhh1vVky52du8A=
Received: by 10.216.139.77 with SMTP id b55mr518871wej.12.1326462873407;
        Fri, 13 Jan 2012 05:54:33 -0800 (PST)
Received: from work.galanthus.dyndns.info (95-28-45-120.broadband.corbina.ru. [95.28.45.120])
        by mx.google.com with ESMTPS id o17sm11149913wbh.19.2012.01.13.05.54.32
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Jan 2012 05:54:32 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:9.0) Gecko/20111220 Thunderbird/9.0
In-Reply-To: <20120113134058.GB2850@centaur.lab.cmartin.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188512>

13.01.2012 17:40, Carlos Mart=C3=ADn Nieto =D0=BF=D0=B8=D1=88=D0=B5=D1=82=
:
> On Fri, Jan 13, 2012 at 02:42:03PM +0400, Dmitry A. Ashkadov wrote:
>> Hello!
>>
>> I can't understand how to fetch branches from external repository
>> for bare repository.
> What you probably want is a mirror (git clone --mirror). Unless you
> tell git that you want a mirror, it's going to assume that you want a
> bare repo to push your own changes up to it. Such a repo has no need
> to be kept up to date, so clone doesn't set up any fetch refspecs.

I don't have access to an origin repository. So, I need bare repository=
=20
and push changes up to it. So, I think the word "mirror" isn't=20
applicable to private repository.

> Stepping back, do you need to fetch those branches into the private
> repo? If you still have access to the main repo and that's where the
> main project development is happening, why not use upstream's repo to
> get those changes to your local repo (as in the one you use to work)?
> It sounds like you're trying to replicate a centralised VCS'
> workflow. Git works like a network and you can merge a branch from
> upstream if you need to and then push to the private repo.

Yes, I can add one more remote to my local repository, then fetch=20
changes from it and push it to private repository. But I thought that=20
update private repository is the best way.

Thank you!
