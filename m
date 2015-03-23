From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Draft of Git Rev News edition 1
Date: Mon, 23 Mar 2015 06:00:13 +0100
Message-ID: <CAP8UFD21PHJqv2z=00TXDFse0_LwbGi_Qjk9y0WJ45VHcLdnMA@mail.gmail.com>
References: <CAP8UFD1WtwKri8cWABnzeRvxKhdNmUfVw5xm=F4oLrevuOGyUA@mail.gmail.com>
	<CAPc5daVU77hpsWeJb9BhvHW9YwoSVb8Jgc38zZ9xEnx0cB2QDw@mail.gmail.com>
	<CAEcj5uV0adYn_F6D1mmueR5F8N459dgP1TTWmPiEH9NFeDqFeQ@mail.gmail.com>
	<xmqq619sb9ne.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Ferris Nicolaisen <tfnico@gmail.com>,
	git <git@vger.kernel.org>, David Kastrup <dak@gnu.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Paul Tan <pyokagan@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Dongcan Jiang <dongcan.jiang@gmail.com>,
	Jeff King <peff@peff.net>, Doug Kelly <dougk.ff7@gmail.com>,
	Bharat Suvarna <bharat.bs84@icloud.com>,
	Kevin D <me@ikke.info>,
	"Randall S. Becker" <rsbecker@nexbridge.com>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 06:00:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZuTQ-0007nn-7x
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 06:00:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833AbbCWFAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 01:00:18 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:34880 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbbCWFAO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 01:00:14 -0400
Received: by ieclw3 with SMTP id lw3so27741688iec.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 22:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=9UHUzX5gvD8AH9RgmoSkikfh2uyf/BBRkj4UuxDlcHI=;
        b=tNmcR8GmDBEfSfI2u+FY4Z9f6UU3gOKT6xL3q55X1MjcEyxUc8oJ4DTiiHKkfizzTe
         U0xvhALnjk5GHerecLMkNbi1Ra5xVxf82vInMmwvn2+RHQ+OEuImQbCmHDfeAym/wWGR
         oEa8NaDmr9Nl4tJPh3jiTLlTWBWHTL57uBf2mdr8SMX77Y2ppkdkka6qNOT0tHztLjyd
         RUqtyUndTtKmKwvgxWgynfi6pYUjQXOTMxdey0BLgy/vb5nkoG0X8jY4ym+vZQL5DMfD
         u9VMzCtV7GY54DX3Mg015lwSPX6i4RqtfbK5fqVB3mada7NEgaPoVgEaRaiwEizzUTAN
         O1CA==
X-Received: by 10.50.43.130 with SMTP id w2mr11984075igl.30.1427086813572;
 Sun, 22 Mar 2015 22:00:13 -0700 (PDT)
Received: by 10.50.245.168 with HTTP; Sun, 22 Mar 2015 22:00:13 -0700 (PDT)
In-Reply-To: <xmqq619sb9ne.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266125>

On Mon, Mar 23, 2015 at 5:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Thomas Ferris Nicolaisen <tfnico@gmail.com> writes:
>
>> Good point. There hasn't been a decision on frequency. Weekly is a
>> good rhythm for publications seeking readership, but that's a lot of
>> work. My vote is we should first aim for a monthly consistent release.
>> I'll try working this into the draft, and Christian may change as he
>> sees fit.
>
> I agree weekly would be too much for any hobbist, given how
> high-volume our list has, but I probably shouldn't have said
> "periodical".  Surely, aiming for consistent update is a very good
> thing to gain reader trust if anything else, but it is OK if it were
> "we will see a new release when enough interesting things happen",
> too.

Yeah, I prefer not to commit to a specific frequency...

> The primary reason I suggested to explicitly state the beginning of
> coverage is to set and manage the expectation of the readers.  I
> think the current draft roughly covers 1/4 - 1/3 of discussions that
> happened in the month of March 2015 and nothing earlier than that,
> so "This issue covers what happened in March" or something would be
> appropriate.  I'll throw a pull-request.

... but I agree that we should say what we cover.

>>>  - As an inaugural edition, we may want to have a word on
>>>    how it came in existence by covering the discussion that
>>>    led to its birth. Perhaps the discussion that led to the
>>>    publication should be made into as an item on its own,
>>>    next to "make git-pull a builtin", "Forbid log --graph..." etc.
>>>    Because it is neither a review nor a support discussion,
>>>    "Reviews & Support" heading may want to become
>>>    "Discussions". I think that is a better title for the section
>>>    anyway, if its purpose is "what happened on the list that
>>>    are not visible from "git log", as I expect future editions
>>>    to cover design discussions that advanced the shared
>>>    understanding of a problem but not quite solidified to
>>>    become a patch series.
>>>
>>
>> I hope it's OK that I leave this bit to Christian.
>
> I took a stab at this myself, and threw another pull-request.
>
> Thanks.

Thank you for your pull requests.
They are all merged and your name is in the Credits section at the end.

Thanks,
Christian.
