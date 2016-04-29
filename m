From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 22:44:38 +0200
Message-ID: <D3ACDA07-DBD4-44B5-8D0A-531F2EC3BD65@gmail.com>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com> <20160429121429.GB27952@sigill.intra.peff.net> <vpqeg9o7gh4.fsf@anie.imag.fr> <CAGZ79kbBCM0CdBoeWTx9kWBBN1f-kuibpUNh9FacOb2xxCDPcw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	stefan.naewe@atlas-elektronik.com,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 22:44:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awFHK-0003eE-VF
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 22:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbcD2Uon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 16:44:43 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38043 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752656AbcD2Uom convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 16:44:42 -0400
Received: by mail-wm0-f47.google.com with SMTP id g17so54369557wme.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 13:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rnO5MWpoBbD5BJHxVt7XSvD4Zq9XVNCfE8TSW6su6uY=;
        b=QSVCJbufHr2ptrbGguQ/CX31+UdPUVuDLA4MiGkmWAp5103RVyChe0YIuMdkQr+rHz
         N15IfeNesxQSNmzT00BCAwxrVtGaqf5lkPMVPNS8I+oZjK3myhQQYDTbN4P7OWXkPvCb
         nHP+scGN0ZxLlpooyfvIMDDTBlv9p75V9joyZlNjbL94o0qgMOuKudCs/uR4BtKeODiW
         96NeDNinNllYO3gASy+Akxd3OS2Kh/5l9qun+GgbHODKzfnBQ1QcKUYBjhQHZBduNdAG
         FoVJs8vZs1j/e02DlSPcvj/ZXRrtCRJh5PAOeHV2iPyANKylfHpOhg666q8JoC5MyDiq
         Litg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rnO5MWpoBbD5BJHxVt7XSvD4Zq9XVNCfE8TSW6su6uY=;
        b=UpLcQe3FZF4quHyalRzNU9zmimQazHedNC3Rzs+1+1fGKjMI5aG7eetwJjQlXan/vt
         5XArL9ZSvrMFX2kx+7UCj+B8BhzQ83lCw8/QWBhi2qOEiv/a1ExHb8NPAO17eidw1a29
         jihOfTFyuHBWJn9qAlse+PYJHU18h51svXPWOcXxHv/AUFWpefO2N1iO9Jff8OTdcG2B
         J2o7vtpebhID1mkFR8BW3LtzVGgh8Gus1nbQEldLNEpw7IFSaNLJzpjY27swfHdQMzoX
         VBu6v4+lqriHAV1Enmt2jxnnXbrgxRBEOG9JvqbFU58UGF4ihuKYyDJwYCPwq4b4HlqN
         mhlg==
X-Gm-Message-State: AOPr4FV4NHtnl6Alq3XfcE9bZmVeEOFOCaFdUKb54s+taL6Ooais6OGq1lPrzJcj6RKAiw==
X-Received: by 10.28.212.71 with SMTP id l68mr6386016wmg.22.1461962680912;
        Fri, 29 Apr 2016 13:44:40 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB43DC.dip0.t-ipconnect.de. [93.219.67.220])
        by smtp.gmail.com with ESMTPSA id u4sm16522776wjz.4.2016.04.29.13.44.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 13:44:40 -0700 (PDT)
In-Reply-To: <CAGZ79kbBCM0CdBoeWTx9kWBBN1f-kuibpUNh9FacOb2xxCDPcw@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293052>


On 29 Apr 2016, at 19:27, Stefan Beller <sbeller@google.com> wrote:

> On Fri, Apr 29, 2016 at 5:21 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>>> On Fri, Apr 29, 2016 at 11:35:34AM +0200, larsxschneider@gmail.com wrote:
>>> 
>>>> +# The follow numbers need to be adjusted when new documentation is added.
>>>> +test_file_count html 233
>>>> +test_file_count xml 171
>>>> +test_file_count 1 152
>>> 
>>> This seems like it will be really flaky and a pain in the future. I'm
>>> not really sure what it's accomplishing, either. The earlier steps would
>>> complain if something failed to render, wouldn't they? At some point we
>>> have to have some faith in "make doc".
>> 
>> I agree. My proposal to check for a handful of generated files was just
>> because this extra paranoia was almost free (just 3 lines of code that
>> won't need particular maintenance).
>> 
>> In this case, I'm afraid the maintenance cost is much bigger than the
>> expected benefits.
> 
> So you proposed to check a handful files for its exact content?
> 
> This could be less of maintenance if we'd check with a "larger as" operator
> such as
> 
>    test_file_count_more_than html 200
> 
> using an arbitrary slightly smaller number.

Well, I was thinking about testing against something like 
$(find . -type f -name "git*.txt" | wc -l) but it the end
all of this is not really meaningful I think...

- Lars


> 
> 
>> 
>> --
>> Matthieu Moy
>> http://www-verimag.imag.fr/~moy/
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
