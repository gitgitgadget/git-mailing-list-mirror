From: Arun Raghavan <ford_prefect@gentoo.org>
Subject: Re: Removal of post-upload-hook
Date: Fri, 15 Jan 2010 17:44:58 +0530
Message-ID: <6f8b45101001150414r2661001ep10819b601953c05b@mail.gmail.com>
References: <6f8b45101001141001q40d8b746v8385bc6ae37a6af4@mail.gmail.com> 
	<20100114193607.GB25863@coredump.intra.peff.net> <20100114194107.GA20033@spearce.org> 
	<20100114204305.GC26883@coredump.intra.peff.net> <6f8b45101001142212i4151c625k54b450cd5978f158@mail.gmail.com> 
	<20100115115212.GA9221@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Jan 15 13:15:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVl5L-00057S-EN
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 13:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757433Ab0AOMPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 07:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757429Ab0AOMPV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 07:15:21 -0500
Received: from qw-out-2122.google.com ([74.125.92.24]:44347 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757306Ab0AOMPT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 07:15:19 -0500
Received: by qw-out-2122.google.com with SMTP id 3so131037qwe.37
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 04:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type;
        bh=ZNmdh1Vdoht+3UIyfgS2oGpLFlRL+//nuEt63C1P+OQ=;
        b=AM8G3tZHIoZqRIL+j3TnyEP4+VSSvTv1enm4OmpS2OcvieXVeWm4yTekmatqvuXJdg
         P4G+kc7DfAf1IKtR6BrCk48Q6FR2OgQmrdw7hw/o5/9hxjdKPyGk5qignzawTahfpGAD
         NUMwVudCoT27lcqmTWCg6G9O66/UmnG/oIKaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=XwIvPp3JPEsh1LbbMggCpZ+4isGYdJrLsiqOdFDlpM4A1nv0Vvt5UG0a34Lj14hq+Y
         vC3vHplfMeBjxjl+LMVPArCUR55Lw5RxCpd7dvHqWUmkWbCjjlSzeHpNLFUEnN+G4gM6
         I2X7f4FFPoTag+RkWdz0w1ezwR0u/8Mz4k0nQ=
Received: by 10.229.40.200 with SMTP id l8mr1908727qce.104.1263557718090; Fri, 
	15 Jan 2010 04:15:18 -0800 (PST)
In-Reply-To: <20100115115212.GA9221@Knoppix>
X-Google-Sender-Auth: 74699128d3a16b55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137065>

2010/1/15 Ilari Liusvaara <ilari.liusvaara@elisanet.fi>:
> On Fri, Jan 15, 2010 at 11:42:19AM +0530, Arun Raghavan wrote:
>>
>> Another thought - would it be acceptable to have a config option to
>> enable/disable these types of hooks, so that people who are not
>> affected by the problem or explicitly don't care can use them? Perhaps
>> a core.allowInsecureHooks ?
>
> That enable/disable would have to ignore per-repo configuration, which
> would make it behave differently from other options. Otherwise attacker
> could just flip the setting...

Alternatively, this could just be a build-time switch.

-- 
Arun Raghavan
http://arunraghavan.net/
(Ford_Prefect | Gentoo) & (arunsr | GNOME)
