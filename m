From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 1/5] t5550: fix typo in $HTTPD_URL
Date: Thu, 28 Apr 2016 08:26:46 -0700
Message-ID: <CA+P7+xpR7wWso2yiaschPYbf7eDDvZ+RuS2aWdNPS2FeeGV1qg@mail.gmail.com>
References: <20160428133534.GA19056@sigill.intra.peff.net> <20160428133636.GA25319@sigill.intra.peff.net>
 <CA+P7+xqSYA5++pq0_0FYFg8TXhc7f0=X_4uNWtFRpebEDzqtHQ@mail.gmail.com> <20160428152549.GB31063@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Users <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 17:27:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avnqT-00051C-QO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 17:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752622AbcD1P1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 11:27:08 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:36698 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbcD1P1H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 11:27:07 -0400
Received: by mail-ob0-f173.google.com with SMTP id j9so40600012obd.3
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 08:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=76BK6hj4BK3GeLV1ngc87kxEJg/ts95FfKXh76Lsruw=;
        b=l35pjBpnkxktT5+QggyBVYqmZv5nu4NiLu06qb9j0DMpQHqh745WQC6K4B4dZqPprQ
         qcKkEnoLsFt1Wh5CEv5P//LS7FQSs7b9N3ZBoFx75kK2X8KB8htxvfKTAtKX89MTLG+f
         AypodYMCdrxeT2YrUU/JClQFltMbcmDFM5GpYoQvPuRSx/WXKiL3D4WhQrqaSwOVNM+Q
         fskNZaWzxsZrI2jI9ehPlczBsbTTx0av4MTs+R6ww6vT+hpkMOq8MZe+LKLA4xapRFCa
         xw1E4RBC+ieKs9ugop00eiohC7qFNvFrEYuKPgqW7CnZm2yt8W29ra42X5w/Qv5uQlEM
         IMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=76BK6hj4BK3GeLV1ngc87kxEJg/ts95FfKXh76Lsruw=;
        b=BAvskP4wBoaAKMZ8oS1OszKHAZn3Zn68mRZ64H9H0Saoa7zlyLaxjdYWpEa2LLzPW+
         0lR+Q8DBVhlSDfQv5Jn2tvYAy/zvcWT+Qa/mfiHFxH/KQ8hKxp8IAEl6sIksRZJesEjN
         T3HcIt9XGwKN46sj8lk5zakIANYWorz7lCNdXk0GR/ADYnlGskm6lgrtU4vt02OcTcv3
         EZKYZk+oj2zrKzVIsSb2JLdtVBmQYHb/u7eHfgjKqhXR4wNsWKSIQVnj8uniadRRMVdX
         yIC/NS6+ELiPdpQDRX82JatMoK8v36pxb9SuK32fcUrfDoy3P+PAl5SsNelEZGwyB4D4
         124A==
X-Gm-Message-State: AOPr4FUCOAtOQtlTBu0/i/4nwkX1LxIs5Ssb4EX7XQsb6z9wGb4Z/jmE/V2C7AwwPnxVp2khSaY3gPIa2pv6kQ==
X-Received: by 10.60.33.69 with SMTP id p5mr7189349oei.65.1461857226352; Thu,
 28 Apr 2016 08:27:06 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Thu, 28 Apr 2016 08:26:46 -0700 (PDT)
In-Reply-To: <20160428152549.GB31063@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292900>

On Thu, Apr 28, 2016 at 8:25 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Apr 28, 2016 at 08:24:05AM -0700, Jacob Keller wrote:
>
>> On Thu, Apr 28, 2016 at 6:36 AM, Jeff King <peff@peff.net> wrote:
>> > Commit 14111fc (git: submodule honor -c credential.* from
>> > command line, 2016-02-29) accidentally wrote $HTTP_URL. It
>> > happened to work because we ended up with "credential..helper",
>> > which we treat the same as "credential.helper", applying it
>> > to all URLs.
>>
>> You say "credential.helper" twice here? I think that's confusing. The
>> patch looks perfectly fine but I am having trouble parsing this
>> description. 'We end up with X which we treat the same as X"?
>
> Note the two dots in the first one. There is no variable $HTTP_URL, so:
>
>   credential.$HTTP_URL.helper
>
> becomes:
>
>   credential..helper
>
> -Peff

Ah yes, very tiny text and tired morning eyes you are right. Makes
more sense now.

Thanks,
Jake
