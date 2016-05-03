From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] shell helpers usage: always send help to stderr
Date: Mon, 2 May 2016 18:17:33 -0700
Message-ID: <CAPc5daXuMmuCx8q5pbo2RWcTYazCo+agLB6tspMdNZCh-n2HpQ@mail.gmail.com>
References: <1461976845-18228-1-git-send-email-sbeller@google.com>
 <1461976845-18228-5-git-send-email-sbeller@google.com> <xmqqtwigox9x.fsf@gitster.mtv.corp.google.com>
 <CAGZ79ka7uPxLKVU7Dn-4yHyN1BMgeG33_7LJDShF3UVjrT2fgQ@mail.gmail.com> <xmqqlh3sotoh.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 03 03:18:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axOzI-0006Ej-LV
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 03:18:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933499AbcECBSw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 21:18:52 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35156 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964847AbcECBRx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 21:17:53 -0400
Received: by mail-yw0-f194.google.com with SMTP id v81so425959ywa.2
        for <git@vger.kernel.org>; Mon, 02 May 2016 18:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=h0ZWVrc/joHU7ULs/eKHNsaCPI7TXbo2Y4UAZRqYASY=;
        b=CVKHl9ErA2zJAd2DBorCBwEMg8CWVUXPfzZDFRw3dZYrJx297rWKT1G3c1s7zSFvf8
         amz+/4CQmG10OwnAtp5wyjAApSMtBa2ma5TKLQCGSFmftU+HgAs4ruQgeiz+lmANfZdu
         UvP2VDayfDxCmHKQkzmtZDs+IQo6lBrNDH5nBrgJpulH2pVOb/2eoFcTN/6pUtuYAgW7
         wpMtuq+c9RERTawfWQ/pi7uGIAFkTCZCZ7tU0QVFSrAw7bcEXa50q+PFqMCQuUfU9oTP
         inTmnwlCXLpYRl6TFFbKZPI48Xw8u+Fa/2euAKopaS9SZp2SgNxEP3N9qw1oaeoQGsEl
         vs+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=h0ZWVrc/joHU7ULs/eKHNsaCPI7TXbo2Y4UAZRqYASY=;
        b=fcIUkFt2xQIFlNrnytLrQ18a3CjLxZmrvwFAh4K1L/XXuD9FHaz07I9oGoONtPBOMc
         QYK4xJkk71QJ8q1onvBEfu+ymSGSSeFh6mnDgBaJGuXTIRqkmhTIvOx1lr4zZgqpZTfb
         LfNv5ij/NPh2s9XSW2YhSfb+8F4ueML6o/cjPxgHwQ1NxFQp9bohTUFb+Nl6wOONK4Bd
         vYxUEnc4hGmET6vvRYNKeNI5TLQwBLNZSgYErf4wW9fPWfLqJdUzgZoyhWoRqtVbG1Up
         skdQOlAjlsyibZahxsnITqtoWb584tavHXfBQaafSvCy9vyLWic4QZFyb/HjPkVDJgQz
         KfRA==
X-Gm-Message-State: AOPr4FUJL0OHki5vwLIbV4DGsIbp459yNDRPerBkMt+DlBzvnOl7TiHvbyavLec+6CEO4yE77EdiYCuOcxNtFA==
X-Received: by 10.129.161.72 with SMTP id y69mr19693083ywg.191.1462238272369;
 Mon, 02 May 2016 18:17:52 -0700 (PDT)
Received: by 10.13.251.71 with HTTP; Mon, 2 May 2016 18:17:33 -0700 (PDT)
In-Reply-To: <xmqqlh3sotoh.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: xCZWZLpYSF1CE2E5xPp9vn8Z9oo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293315>

It also is somewhat sad that you needed to refer to a random blog you
found on the Internet whose punch line was essentially what I already
said before you finally decide to listen to me X-<. I somehow expected
that over the years you worked with me you learned I had a reasonable
taste in designing these things...

On Mon, May 2, 2016 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>     git --help |grep pull
>>
>> instead of
>>
>>     git --help 2>&1 |grep pull
>
> Not just that.  It makes me sad that it is unpredictable which
> stream a project happens to have chosen to send its help text and I
> end up almost always doing
>
>     random-command --help 2>&1 | less
>
