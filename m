From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-daemon serving repos with repo.git/git-daemon-export-ok
Date: Mon, 3 Jan 2011 20:11:42 -0600
Message-ID: <20110104021142.GB19053@burratino>
References: <S1751603Ab1ACU6e/20110103205834Z+1762@vger.kernel.org>
 <4D224475.1090805@ecosensory.com>
 <20110103231153.GA10733@burratino>
 <4D225DFA.50805@ecosensory.com>
 <20110103235501.GA32262@burratino>
 <4D227ED7.9010407@ecosensory.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Griessen <john@ecosensory.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 03:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZwPh-0004k5-OA
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 03:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037Ab1ADCLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 21:11:54 -0500
Received: from mail-yi0-f66.google.com ([209.85.218.66]:38475 "EHLO
	mail-yi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864Ab1ADCLx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 21:11:53 -0500
Received: by yic24 with SMTP id 24so1866314yic.1
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 18:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=g/QDVw+KOJBOfd68xvu22PFvhruSFtc2cli/BbGTjqQ=;
        b=X1n5l5WLmbSkaK2gdLNB34UaynwqPHDEPtsA8gxEB/9uEb6B3wMHNT+HIVLeI7oEdW
         wsXb8dGbvp3LvhuCToQ2NaJs080mHXpW5XsLPUA1R7PTEbrF9sIgCpoC7Mntc1nhU3ft
         Ta1NxSnRVn/RoseIEntu85QKq4lWRkvOEqpaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dTs56MA2urfuOS1ioyPlfYrlBlA+cUWL7DfO/p+sWxRT2Ha5dhFNCocy4scbPpO8o/
         r9uKTE/ovnYWwhBv1dXRRcBXcPKFFx12FA8/5VNROq7kLw+3D96rDfle5beL2wJWzPHJ
         3D2tD0X+tlbAUNb1DoXslPJmj7vRXZa+tXb8s=
Received: by 10.91.35.24 with SMTP id n24mr3984960agj.68.1294107112899;
        Mon, 03 Jan 2011 18:11:52 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id 37sm28878343anr.24.2011.01.03.18.11.51
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 03 Jan 2011 18:11:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4D227ED7.9010407@ecosensory.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164469>

John Griessen wrote:

> sudo /usr/lib/git-core/git-daemon --verbose --strict-paths --user=git
> --group=gitosis /srv/gitosis/repositories  &>git-daemon-err.log
>
> vking@mail:~$ cat git-daemon-err.log
>
> and git-daemon-err.log was empty.

Thanks for clarifying.

> Should I reinstall debian's git-daemon-run to do some tests?

Seems redundant next to the tests you've already done.

> On 01/03/2011 05:55 PM, Jonathan Nieder wrote:

>> an issue here.  It looks like another git-daemon process is running at
>> the same time?  (One can check with "netstat -t -a".)
>
> Nope, not as far as I can see.

I left out the "-p", sorry.  I'll be more careful in the future.

> What suggests that?

bind(3, {sa_family=AF_INET, sin_port=htons(9418), sin_addr=inet_addr("0.0.0.0")}, 16) = -1 EADDRINUSE (Address already in use)
