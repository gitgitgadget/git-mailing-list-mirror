From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: fixes for older versions of bzr
Date: Fri, 17 May 2013 13:20:17 -0500
Message-ID: <CAMP44s0WbkaWsU+VOCsd2THEQJkTU-67_z5Kb37j=gS9U1MV2Q@mail.gmail.com>
References: <1368810619-18419-1-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s1-RdmM9vs=XSvN1KNOh92Zr=nJWHGR0MZZV9BFXG_3JQ@mail.gmail.com>
	<7v7gixzdsj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 20:20:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdPGR-00036i-Dv
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 20:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754662Ab3EQSUT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 14:20:19 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:38213 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab3EQSUS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 14:20:18 -0400
Received: by mail-lb0-f179.google.com with SMTP id r11so663520lbv.38
        for <git@vger.kernel.org>; Fri, 17 May 2013 11:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=xHfDIl/KWxUVjaxGp28BG83NGdxyiE8nyMZx1qdrI+I=;
        b=ZiAQUpXDKikBwpEvJmXujzUCX5MztwluE+n1E0PQhoXUtrpzLJmf+2JYIwpDi8F4LO
         eZJ1d6n1d1/uCng+MB03jSvtlvk44Rd2Vfus4ThBzfYd/KbHUWPFW1J3bcvBbBt2ORkK
         js/Wj+2iDPxwfTfmMHLnoWVJ8htmJnqTwio/iqaXLacSSOFhV3yYcIFHWSQNvkr96U2r
         E+pJhRZmF23mZXD+rxXQdT6QoLeY137PFIi9pod0Qcgp7vL1ySq6EwJI2yF4oHD9SwGX
         f1EoAFcnP+05eGQN5lgmbS9DMPd5QYFtSdO2hjmx1HxG06uojj4dtpJnr9aLm7uzDmDw
         Puyg==
X-Received: by 10.112.163.71 with SMTP id yg7mr13433024lbb.8.1368814817129;
 Fri, 17 May 2013 11:20:17 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 11:20:17 -0700 (PDT)
In-Reply-To: <7v7gixzdsj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224727>

On Fri, May 17, 2013 at 1:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, May 17, 2013 at 12:10 PM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>>> Up to v2.0.
>
> Is that "down to v2.0"?
>
>>>
>>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>>> ---
>>>  contrib/remote-helpers/git-remote-bzr | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> We want this for v1.8.3, otherwise it wouldn't work in older versions of bzr.
>
> I take it that somebody tested this with both new and old versions
> so that the old way you rewrote the code with is still supported by
> the more recent ones.

Yeah. I wrote a script that tests in a bunch of versions.

Also, I'm fiddling with travis-ci:
https://travis-ci.org/felipec/git/builds/7258332

-- 
Felipe Contreras
