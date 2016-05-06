From: Stefan Beller <sbeller@google.com>
Subject: Re: /* compiler workaround */ - what was the issue?
Date: Fri, 6 May 2016 13:01:34 -0700
Message-ID: <CAGZ79kby0Z1FMUT-w8h=YfRxsmyXaiE2pA_VoJ0g9wn0Mzk2Wg@mail.gmail.com>
References: <AA5B2B1715BAF7438221293187A417A7BDE9D11D@desmdswms002.des.grplnk.net>
	<17E04501C9474282B87758C7998A1F5B@PhilipOakley>
	<xmqqtwic9o88.fsf@gitster.mtv.corp.google.com>
	<CACsJy8CBuU8H8r_f4KsnLkhLtfRv0nDo4hGS31LVn0e1Y_3OAQ@mail.gmail.com>
	<51C902B1F7464CF2B58EB0E495F86BB5@PhilipOakley>
	<572CDCFF.9050607@ramsayjones.plus.com>
	<xmqq60ur3tlu.fsf@gitster.mtv.corp.google.com>
	<572CF0D5.6010305@xiplink.com>
	<xmqqinyr2c3d.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Philip Oakley <philipoakley@iee.org>,
	Duy Nguyen <pclouds@gmail.com>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 06 22:01:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aylwS-0004kV-8T
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 22:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758696AbcEFUBg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 16:01:36 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36727 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758152AbcEFUBf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 16:01:35 -0400
Received: by mail-ig0-f176.google.com with SMTP id u10so55760613igr.1
        for <git@vger.kernel.org>; Fri, 06 May 2016 13:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=Dzx6/K1aVpOwSXMdoVFyDvZcjUC6/OcT6dDDccv+N0k=;
        b=jiFr5AwcUeuTy44Jd1N4+1QBDif052UTtmHVtvT9Il3njAiQVvZxw7b4+WxI5bCthV
         fY9prZUkpmgP0zA10h5bJ+VD+GtcEbw4HgB2K6pWRGTTBB4WaLNdhHP7oXggcOeL09xZ
         v6SK25uigW1LTnv1P4ClB4zZcCKSLQr8kjJbSf/feAl3NQKzQOPTGqqh8DRAUVA/pbdy
         nyfyVSad/+shQFOBG+JRD7+1bQV0+Y1GfGBazj2zODtgauWHRN44UqtZpm1aSwhXZfDK
         a0/qKYdhZ3k1d+fbirsN2Gk7c9rdvbUd99sk0Po9tMT/mIbF5JfrlkLRch5daiJyvjez
         EteQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=Dzx6/K1aVpOwSXMdoVFyDvZcjUC6/OcT6dDDccv+N0k=;
        b=KoSCbBulthpr7EngdTIbc3asrgS2vnHva37mX4X8aHuut7tQywTqL28zQ/RkUajH1G
         +sPfi/kLURbWuuB4AM3mPU1worultuGSHpKbG1KwOKzFP5IfoP1AvzyfKcEG+nheTzPP
         WAGp6+QJ2/guZabxgeJcNgiBbX19CTAm7idC8G7ktgip+Nxw3TfD4FPStze5kFURzRaB
         MdmJraKXhLtEa0VLgOcec+quqWAV5MWAixPB5UhF7JVQCShtNqwQRhMPODiEOpoQDqI7
         SWp2Q15oomL6K1BL9/61IU6TGW4udN4ATh/mOPrVsx5d9fW2tjTXsBh4Zof9bhRbLeTJ
         NRDg==
X-Gm-Message-State: AOPr4FXM2c4/OuCFBd0FrAv1gm+8qBnFOtCngDba7VWEEVuMfEhkStEF06N/FNuQony4S6uBustRGBgLG2tD1Amy
X-Received: by 10.50.29.45 with SMTP id g13mr12615745igh.93.1462564894525;
 Fri, 06 May 2016 13:01:34 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Fri, 6 May 2016 13:01:34 -0700 (PDT)
In-Reply-To: <xmqqinyr2c3d.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293855>

On Fri, May 6, 2016 at 12:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
>
>> On 2016-05-06 02:54 PM, Junio C Hamano wrote:
>>>
>>> I wonder if can we come up with a short and sweet notation to remind
>>> futhre readers that this "initialization" is not initializing but
>>> merely squelching warnings from stupid compilers, and agree to use
>>> it consistently?
>>
>> Perhaps
>>
>>       #define COMPILER_UNINITIALIZED_WARNING_INITIALIZER 0
>>
>> or, for short-and-sweet
>>

           /* Here could go a longer explanation than the 4 character
define :) */
>>       #define CUWI 0
>>
>> ?
>>
>> :)
>
> I get that smiley.
>
> I was hinting to keep the /* compiler workaround */ comment, but
> in a bit shorter form.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
