From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [StGIT RFC PATCH] Don't use refs/bases/<branchname>
Date: Wed, 2 May 2007 13:17:01 +0200
Message-ID: <e5bfff550705020417h14f6297fu957eb64e58119770@mail.gmail.com>
References: <20070429220832.5832.251.stgit@yoghurt>
	 <b0943d9e0705010137q4a35f818m7dbbc9d2e77e2fcf@mail.gmail.com>
	 <e5bfff550705010210i352ac9eej6ff7a78aae6535c9@mail.gmail.com>
	 <20070501185615.GA32727@diana.vm.bytemark.co.uk>
	 <e5bfff550705011259w567a98dj6d0a68b0fbe90994@mail.gmail.com>
	 <20070502065054.GA9919@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Catalin Marinas" <catalin.marinas@gmail.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed May 02 13:17:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HjCpp-00067s-F5
	for gcvg-git@gmane.org; Wed, 02 May 2007 13:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbXEBLRG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 2 May 2007 07:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2993048AbXEBLRG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 May 2007 07:17:06 -0400
Received: from wr-out-0506.google.com ([64.233.184.236]:60141 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbXEBLRD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 May 2007 07:17:03 -0400
Received: by wr-out-0506.google.com with SMTP id 76so96138wra
        for <git@vger.kernel.org>; Wed, 02 May 2007 04:17:02 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YjUEaAnAvwv+/iFR2psjmUwLFIRFK5smbAR4CT2kH6I6scbLGioOpqwgEYDGFJZP9wDyGf4TZoLPlSKEBgItFiPKu9Y/JpiKhnSyZDz8cqH0It/9T4FkbTEhUGte8LHy19VO37AgUzwzLXytt/+acnd9Bk2fEguBcqq4WK7bI0s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QZMD39lfZqXYLY4YlBEpPd/NEyi/OjUYK+uoYEvtvUWiP1VglVslQ4WGY3pD5ynHuBE2BLxc5nbYXej3QMsaLRiDseIi7FDXZ2qVOGOkVSiAeeVur/9klxNlFl6sio3a3VpFwTEiiuSivqsAggFIz9cEHGUlfNKfchWe/sCn5Fw=
Received: by 10.115.60.1 with SMTP id n1mr185210wak.1178104621871;
        Wed, 02 May 2007 04:17:01 -0700 (PDT)
Received: by 10.114.61.6 with HTTP; Wed, 2 May 2007 04:17:01 -0700 (PDT)
In-Reply-To: <20070502065054.GA9919@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46013>

On 5/2/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> It's not near the top of my kill list by any stretch of the
> imagination, so no need to worry. And even if it were, Catalin would
> certainly stand as a wall of sanity between qgit and my chain saw. :-=
)
>

Currently I check for the existence of <git dir>/patches directory as
a quick exit in case a repository does NOT have a StGIT repo on it
(the common case).

This avoids a costly and 99% of cases not needed 'stg <something>' call=
=2E

I ask if it will be still a safe check in the long period or it is
better to change the check to something else (as existence of <git
dir>/refs/patches) instead ?

Thanks
Marco
