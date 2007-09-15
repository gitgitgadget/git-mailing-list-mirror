From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: STG, problem with pop/push of alternative versions of a patch
Date: Sat, 15 Sep 2007 09:07:05 +0100
Message-ID: <b0943d9e0709150107o27571446v9bef8e31517777e1@mail.gmail.com>
References: <9e4733910709142049k6dcec6acuf851c21ed6704287@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Jon Smirl" <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 10:07:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWSgN-0003VX-Ts
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 10:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbXIOIHK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 04:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752200AbXIOIHJ
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 04:07:09 -0400
Received: from rv-out-0910.google.com ([209.85.198.191]:47170 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836AbXIOIHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 04:07:06 -0400
Received: by rv-out-0910.google.com with SMTP id k20so870918rvb
        for <git@vger.kernel.org>; Sat, 15 Sep 2007 01:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4Dwojydx4fLSKe1cPhgso26k0//NIM7rIZXI1qft3jU=;
        b=ShyXN8+lwNLv//OfFF4UEuJbzL/S8t7PxUP6eujQuAQ3kz+xaYpgOrj0w3+Pu+0Fu0waDmCoLJj4T4S2N7blYn4U6o64jD/3fvVd1UvMinWwVpGv/bz2BQQ7HmHOCJGkrvc73NQSJZWtw50uvyUuOYSROJAR0XNTreO3oFBFdZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=You9Ujn2F33xUfrDEbEWn+84Vk8HNOkX1/gbB4KcLADzSM5eC7tcV2g13qNK1TxsNGNZVIIobB3h8+TrPNmx9CmL/mxEF0PEevzB3rLAKawOAIZ9MK4XOM3Ob63Cp0Ms94nNqa4BPZJp8nb+a8e4c6mm21d+eHHTRYNsb64QwYY=
Received: by 10.141.196.13 with SMTP id y13mr171520rvp.1189843625438;
        Sat, 15 Sep 2007 01:07:05 -0700 (PDT)
Received: by 10.140.158.1 with HTTP; Sat, 15 Sep 2007 01:07:05 -0700 (PDT)
In-Reply-To: <9e4733910709142049k6dcec6acuf851c21ed6704287@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58231>

On 15/09/2007, Jon Smirl <jonsmirl@gmail.com> wrote:
> I trying to test two different versions of a patch that add files.
> These patches create a new directory and add several files. When I pop
> a version of the patch the directory and files and not getting
> removed. This causes an error when I push the alternative version of
> the patch.

This shouldn't happen AFAICT (at least for the files, as GIT doesn't
care much about directories). What GIT/StGIT version are you using?
StGIT simply calls GIT to do the HEAD switch.

Could you run 'stg patches drivers/net/fec_mpc52xx/Kconfig' with the
initial series pushed? It should show which patches touch this file.
If it doesn't show any, maybe the files weren't added to any patch and
hence the error.

Thanks.

-- 
Catalin
