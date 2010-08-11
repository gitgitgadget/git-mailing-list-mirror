From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 9/9] commit: suppress status summary when no changes
 staged
Date: Wed, 11 Aug 2010 18:57:42 -0500
Message-ID: <20100811235742.GA18499@burratino>
References: <20100725005443.GA18370@burratino>
 <20100725010230.GI18420@burratino>
 <201008110911.40133.trast@student.ethz.ch>
 <20100811073028.GA5450@burratino>
 <AANLkTi=DPu+roNsuWZARkK=cmKhcqMx=CDyiv6cf7tof@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 12 02:30:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjLgP-00081a-Mf
	for gcvg-git-2@lo.gmane.org; Thu, 12 Aug 2010 02:30:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759030Ab0HKX7U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 19:59:20 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42193 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759294Ab0HKX7S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Aug 2010 19:59:18 -0400
Received: by mail-qw0-f46.google.com with SMTP id 6so706470qwh.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 16:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wOE8ktZD0RD7nCx6U05yRPtgSTWJWNP4/Eb1CwwCVII=;
        b=sjPodsIEemhHKde1d74NovSfsyxsOFBHUraK8n8r2e7uRQXyfIAjsWxzSOzFgQtBvH
         o6cgYRAYrsleFi3JaBeZsBby3dkRiHpzFI5RUNGG90rgzXY32zuPv9EhN6Py8pWUCooV
         Optx8fFtbrKMBOOm6VdSdyhTKzzsasPCpJfMw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=L6FWwFlKZW9pNqbTA7+UJ8UnSBbwGeP3wmTD75dRs0W+cmG+mucUYtO5mdGlMZKnXf
         pl7EGiXm7pyXAFjY+86/woehi6zNBshYvVRLBwEeTTFEeE93NpxrQVv6de+yQV43B/zx
         Rb31k+d4THVOGPsW8hugKr62zPc5w+OPYurOY=
Received: by 10.220.87.69 with SMTP id v5mr11962677vcl.273.1281571156891;
        Wed, 11 Aug 2010 16:59:16 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id b8sm399392vci.21.2010.08.11.16.59.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 16:59:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=DPu+roNsuWZARkK=cmKhcqMx=CDyiv6cf7tof@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153318>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Wed, Aug 11, 2010 at 07:30, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> -test_expect_success 'status' '
>> +test_expect_failure 'status' '

Oops.  Did you see the follow-up patch?

> Better to test_expect_success like my patch does and explicitly check
> the output, otherwise that test will pass if any part of it fails,
> e.g. if the checkout fails.
>
> Not likely, but it's more likely that the output will change again, i=
n
> which case the grep tests I did would start failing again.

The wt-status output series ought have included a separate test for
the new =E2=80=9Cgit commit --dry-run=E2=80=9D output.  But this is not=
 what that test
script is about, and I think including it there would have been
confusing.

Sorry for the breakage, and thanks for reporting it.
