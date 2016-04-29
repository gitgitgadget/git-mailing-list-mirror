From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 16:22:05 +0200
Message-ID: <B5E5068F-7D69-41F8-BC33-E287567FD3AD@gmail.com>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com> <20160429121429.GB27952@sigill.intra.peff.net> <vpqeg9o7gh4.fsf@anie.imag.fr>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	stefan.naewe@atlas-elektronik.com, gitster@pobox.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 29 16:22:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9J9-0003Fm-Hz
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753269AbcD2OWK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:22:10 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:35043 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbcD2OWJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Apr 2016 10:22:09 -0400
Received: by mail-wm0-f46.google.com with SMTP id e201so29724765wme.0
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 07:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u1uHXOLg38DAw8DYRLgYCM5WkYaBYPYAEgKvRba4Afg=;
        b=sZtf24YaVzHiTzIKlPMm1rzlkOgM+jEJJoMhQrFnD9GUwgz9GHIyqtEEtKXZlkQSGm
         hM9hEjCVX18k4wpgXXOls12Qa1c4Tdp4jh9p/HMfx2LE7DlLLmFBSV3yDQ5iVKat0lUY
         8aFIzfb4Ro6VAKJegvuNQqt0UQuFpyJX/nXdY63qsqr8hh/RZ9IwW+ZS9750wxPEQD/I
         k+bWwnLlVjsi/m5svx6O1Y9/ua6kpJws2ooGigXZqNpUAnypj+4VCUhmIQ8Zil/8K76Z
         RpTIP6G8pkYQmbDm9ky0oRSpDNWvB+Vvzm6Lu9EX+5x1uQ0A+uTqKOoWahqI6OJ8dpiZ
         /DWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=u1uHXOLg38DAw8DYRLgYCM5WkYaBYPYAEgKvRba4Afg=;
        b=ZggRrdjhqQwfOT8zfTBYxmfNGAn74r5ZF918toWMVKa1i0jICKvp+tmqRInw7CS7Rn
         JtMvqWL1OSQTVcoeCcW1UkDY/FYPx25TJfgk6TtJAVrIiHmezAx+RJ6LaapEDxD3J9Gj
         eY9athacCKse8sViU1bSNZ0kxJ7wtLPFko38tn85FcSkRlajaTPuZ8EWw00yIzzY/mbn
         QWtqvoDBDd025kD13IJu+m60xDKKwVqxOvj+v9vOHRA2txTEqjD1lbYw9QFbAiVPnlHB
         EO7MbcHFhd8VeWfmB/HNkDecxSkkz2OQoAvkQnss006uuYYW6cb1spe7yU6dJU+ugHuS
         wMeA==
X-Gm-Message-State: AOPr4FVACIT6PqfmeRr0Zn57V5o+sNItxCmT+hC8PvpPMH/1CS88jQYW9YK8Xk8Qj9bYew==
X-Received: by 10.28.7.197 with SMTP id 188mr4597013wmh.101.1461939727434;
        Fri, 29 Apr 2016 07:22:07 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id s10sm15081079wjp.3.2016.04.29.07.22.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Apr 2016 07:22:06 -0700 (PDT)
In-Reply-To: <vpqeg9o7gh4.fsf@anie.imag.fr>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293002>


> On 29 Apr 2016, at 14:21, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
> 
> Jeff King <peff@peff.net> writes:
> 
>> On Fri, Apr 29, 2016 at 11:35:34AM +0200, larsxschneider@gmail.com wrote:
>> 
>>> +# The follow numbers need to be adjusted when new documentation is added.
>>> +test_file_count html 233
>>> +test_file_count xml 171
>>> +test_file_count 1 152
>> 
>> This seems like it will be really flaky and a pain in the future. I'm
>> not really sure what it's accomplishing, either. The earlier steps would
>> complain if something failed to render, wouldn't they? At some point we
>> have to have some faith in "make doc".
> 
> I agree. My proposal to check for a handful of generated files was just
> because this extra paranoia was almost free (just 3 lines of code that
> won't need particular maintenance).
> 
> In this case, I'm afraid the maintenance cost is much bigger than the
> expected benefits.

I agree, too. I wasn't sure about this check. That's why I added
the little comment above to point out the problem.

Should I reroll?

Thanks,
Lars