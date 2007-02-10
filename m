From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 15:51:39 +0100
Message-ID: <e5bfff550702100651j244e5a2flf02fb91dc71799b3@mail.gmail.com>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	 <Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	 <Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	 <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <junkio@cox.net>, "GIT list" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 10 15:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFtZn-0002fe-VO
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 15:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbXBJOvl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 09:51:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932581AbXBJOvl
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 09:51:41 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:21257 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932579AbXBJOvk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 09:51:40 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1204306wri
        for <git@vger.kernel.org>; Sat, 10 Feb 2007 06:51:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SEHNnl2itYXSbitNC4GFub+cHLCyAWWJ8TGudeukWyQjC4CI5YoNezfZVFetTsMQUpqH/Eek+m3yYhO8yO0FuFEQxABn4OETTnewtKiNu7FdcjZDcyWBN2OhZEOwVqtfcnBDkgZLk+NwG8VLnLDPuMAveu5teDKqL/nXIbK21nQ=
Received: by 10.114.177.1 with SMTP id z1mr5391724wae.1171119099299;
        Sat, 10 Feb 2007 06:51:39 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Sat, 10 Feb 2007 06:51:39 -0800 (PST)
In-Reply-To: <e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39227>

On 2/10/07, Marco Costalba <mcostalba@gmail.com> wrote:
> >
> > You need a new version of _Git_ if you use that option.
> >
>
> That's a true point. Altough if git 1.5 ships _without_ '--refresh'
> option in 'git runstatus' for a porcelain tool point of view it means
> *do forget* that option until next major release. There's no point in
> adding the feature one day after git 1.5 is out; qgit will not use
> that feature anyway for next months.
>

I could opt for shipping qgit 1.5.5 _without_ using '--refresh' and
then ship, as example in a month, qgit 1.5.6 that uses the feaure. But
I can do this _only_ if git 1.5 has it.
