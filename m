From: "Rhodes, Kate" <masukomi@gmail.com>
Subject: Re: how to list all files that will be comitted
Date: Wed, 25 Jun 2008 12:16:28 -0400
Message-ID: <54450C0E-1AC8-4CE8-919C-8326ACC588EB@gmail.com>
References: <644094BE-2835-41EF-B1B4-615B8A4BD509@gmail.com> <alpine.LFD.1.10.0806251154180.5755@sys-0.hiltweb.site> <17C0F998-66C0-4DFC-90EB-B85FF6E07844@gmail.com> <20080625161439.GA1794@diana.vm.bytemark.co.uk>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ian Hilt <Ian.Hilt@gmx.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 18:17:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBXgX-0004mN-Mu
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 18:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYFYQQc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 12:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752286AbYFYQQc
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 12:16:32 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:32511 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbYFYQQb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Jun 2008 12:16:31 -0400
Received: by rv-out-0506.google.com with SMTP id k40so8266111rvb.1
        for <git@vger.kernel.org>; Wed, 25 Jun 2008 09:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:content-transfer-encoding:mime-version
         :subject:date:references:x-mailer;
        bh=S1YY7ZGracVU30r7ah/9jJfQOsrHwzltYDEW7RB+cqo=;
        b=jFkROy0a3impazE2p7003IhQwozLXHt/l8xFwfVcXDAXioQSe2sT0Ra4IWduKmtzRc
         pooTpfYypz4OPgzhlTy4DPdmXbSx9bTR5oeKpzPfMJwcyYMN4gg6gsrtGhgxJh9BhRNF
         WQWA/ucVhTyMq64GmRpoEzp/nbwHUp2rNKf0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:mime-version:subject:date:references
         :x-mailer;
        b=V2O1ZAOc1BF9IRKHG2p2EjcQPZoEQBIaX8k+beI1QEaHLFHDpftJn5Ejq6nTNlEZeG
         BiWBHifaXIp5WHjy7+RaHIS6wSu8Ygv6aJI4VFFYTtc7nC4UBLANjys5fzVVnRpUk7dA
         PLeBCs8ao738zFiZlQzx/LaPXqLf3NzalLO5Q=
Received: by 10.141.171.6 with SMTP id y6mr16574376rvo.84.1214410590750;
        Wed, 25 Jun 2008 09:16:30 -0700 (PDT)
Received: from ?172.30.0.244? ( [80.67.64.10])
        by mx.google.com with ESMTPS id 66sm11129667wra.39.2008.06.25.09.16.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Jun 2008 09:16:30 -0700 (PDT)
In-Reply-To: <20080625161439.GA1794@diana.vm.bytemark.co.uk>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86298>

Perfect, exactly what I wanted. Thanks.

-Kate


On Jun 25, 2008, at 12:14 PM, Karl Hasselstr=F6m wrote:

> On 2008-06-25 12:01:49 -0400, Rhodes, Kate wrote:
>
>> yeah, but i was hoping for plumbing, not porcelain, that showed just
>> what i wanted so that i didn't have to parse status' output.
>
> Unless you want a listing of all the files in the index, you probably
> want to call diff-index.
>
>  git diff-index --cached <tree-ish>
>
> gives you the diff between the index and a tree-ish. With the
> --name-only option, you get only the filenames and not all the modes,
> blob sha1s, etc.
>
> --=20
> Karl Hasselstr=F6m, kha@treskal.com
>      www.treskal.com/kalle
