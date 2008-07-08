From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: stgit error on status command
Date: Tue, 8 Jul 2008 08:06:04 -0400
Message-ID: <9e4733910807080506k6d51bc98h96a7a7b2bd56d98b@mail.gmail.com>
References: <9e4733910807070810i14c8856vfbec24127e711285@mail.gmail.com>
	 <20080708070254.GA4129@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"Catalin Marinas" <catalin.marinas@gmail.com>
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 14:07:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGByN-0003pE-15
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 14:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbYGHMGJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 08:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752019AbYGHMGI
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 08:06:08 -0400
Received: from wx-out-0506.google.com ([66.249.82.229]:36075 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYGHMGH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jul 2008 08:06:07 -0400
Received: by wx-out-0506.google.com with SMTP id h29so973612wxd.4
        for <git@vger.kernel.org>; Tue, 08 Jul 2008 05:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=CMELSdwjQIuHI3cuU5aEFKlwCOpwVm1P1+D6ZsRZB0A=;
        b=wKe3zpooGsNuBnL3ofe77PcdmBShGiLWyRTwwH+DK+EDvJ6zoCWKb5J+VNvWZfCogk
         20fAleidj7yPXfxPvRfE9+r5yfWjpuwRET01VnMO5RbUyda+1OOb5Arxb6aokHW6c2PR
         rCka+rJjDmcsjoCfCt6Se5OAVD9CklQDDm5KY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=h8GROV0C5o0UDqnwJY/3toPztXxDWfqezcYgPHSdyEtWj0Qkrg8rngYnfuY/nI6T4w
         uG23HnInhmAXHdHLvqdBtsWx2QAPHrACp7I/urzo+PjgcU3rHjpkllpZBI5VlLJHAfqZ
         9D98wIKeumWackn0xZhi5iEgpi8Dvg/2yOF0s=
Received: by 10.151.42.18 with SMTP id u18mr10173314ybj.221.1215518764524;
        Tue, 08 Jul 2008 05:06:04 -0700 (PDT)
Received: by 10.151.78.17 with HTTP; Tue, 8 Jul 2008 05:06:04 -0700 (PDT)
In-Reply-To: <20080708070254.GA4129@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87755>

On 7/8/08, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> Thanks for the report.
>
>  The problem is that we mis-parse the output of git diff-index when
>  rename detection is on (and it prints more than one filename on one
>  line). This happens if you give stg status the --diff-opts=3D-M flag=
,
>  but you didn't -- but it could also happen if you have the
>  stgit.diff-opts config variable set.

I have -M in my config file. If I don't use people on lkml complain
about renames generating piles of output in the patches. I'm able to
work around the problem for the moment.

>
>  I'll try to get a patch out tonight. In the mean time, if you like y=
ou
>  should be able to work around the problem by unsetting
>  stgit.diff-opts.
>
>
>  --
>  Karl Hasselstr=F6m, kha@treskal.com
>       www.treskal.com/kalle
>


--=20
Jon Smirl
jonsmirl@gmail.com
