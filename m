From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: man git-config inconsistency (*.fsckObjects)
Date: Mon, 8 Feb 2016 13:00:50 -0500
Message-ID: <CAPig+cQZ2LWsy1VC7Aqm+V3cWG7Y3rb0dGfyS_c3BCVM3Dekgw@mail.gmail.com>
References: <56B8A928.4000802@cl.cam.ac.uk>
	<20160208150856.GB13664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Markus Kuhn <Markus.Kuhn@cl.cam.ac.uk>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 08 19:01:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSq7N-0002gA-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 19:00:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932394AbcBHSAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Feb 2016 13:00:53 -0500
Received: from mail-vk0-f42.google.com ([209.85.213.42]:36724 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932177AbcBHSAv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Feb 2016 13:00:51 -0500
Received: by mail-vk0-f42.google.com with SMTP id c3so54153746vkb.3
        for <git@vger.kernel.org>; Mon, 08 Feb 2016 10:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fYdnOlkXUuVV9BZSTMVqayjSmLTEnGfHBOFwMatWJUE=;
        b=YgYOXEPtuczCOJm5tdwfL/JbCr2gJhxRVPjyDhSgJ145IgAd8hJMYPzoBwOd85w4MR
         iLA4axi0RiXSXkL/Q+8Mx4XtYBssyXULe0fM6XICGxpUJ6V+iplH8K2lxrk1xiTj3Bp1
         fpjJDeHgpzeKkLKEnSNPwr2bgUcVlTn2VQOuxuCtoFJDpk+YwUzCBhlolX5sw0BkL+Sp
         UuKNevkRceWmmvG0zdltJJZIdFRwax/kDOW6g0B+D37ZBFIOppr0NgehhH1tysdvduIX
         3BcI79fNIxlD+qNJXIJaGvg0Hkjl9KSZigu2Rq1Rum/ZZ0zV/urBe4gtKZurk+sXeBAg
         +LEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=fYdnOlkXUuVV9BZSTMVqayjSmLTEnGfHBOFwMatWJUE=;
        b=glaIXMbJuB3kBHlV8gxpudsJvFg5SGmAZh/Krc2Rm8nIYE7w70qMHFGn9BoByrQ1pX
         48B26I7BdE6DbcuuqmiN8XLu17dHSvKJhUhupUaj2tcu9I2am2rWPDg04kXL2uF2rSad
         UB/bYiH6BzTqKFkKakTMshgNFQ0oeNacIh1U6OjhcC/47TjqBdvuH6PTQD37/Q2vtty/
         5sceIko99o06naxSSpVHeB+hTMj4ydSQpV7BKejduQPWU5jcpf/dGEjIcMP/U/vHc/yg
         aHj+rrPH2W9utWupPMcCc0yR+vuj42JVRRYZZzablTvhaJHYB8taLgvfuE2fVAcDpSXp
         Eeaw==
X-Gm-Message-State: AG10YORirF9d6SwLrrJNmVJ16NWLaPtkrtFDZ/O1N5mJiXR4e3xGLZ8hrPQej7QXhd/3PU9G5lkA4MxFlgo1GA==
X-Received: by 10.31.41.14 with SMTP id p14mr21122867vkp.151.1454954450415;
 Mon, 08 Feb 2016 10:00:50 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 8 Feb 2016 10:00:50 -0800 (PST)
In-Reply-To: <20160208150856.GB13664@sigill.intra.peff.net>
X-Google-Sender-Auth: gbOqvtMMoMproo8PizOAxHcE4HE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285785>

On Mon, Feb 8, 2016 at 10:08 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 08, 2016 at 02:41:44PM +0000, Markus Kuhn wrote:
>> Suggested rephrasing:
>>
>>            If not set, the value of transfer.fsckObjects is used
>>            instead, which defaults to false.
>
> Yeah, I agree your phrasing is much clearer.

Should we worry about this becoming outdated if the default of
transfer.fsckObjects ever changes, or is that being overcautious? If
it is a legitimate concern, then perhaps drop "which defaults to
false" from the end of the sentence.
