From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v7 11/12] for-each-ref: introduce filter_refs()
Date: Thu, 11 Jun 2015 22:47:02 +0530
Message-ID: <5579C28E.10208@gmail.com>
References: <5579B253.4020804@gmail.com>	<1434039003-10928-1-git-send-email-karthik.188@gmail.com>	<1434039003-10928-11-git-send-email-karthik.188@gmail.com> <vpq1thixjs3.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, christian.couder@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jun 11 19:17:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z366M-0004FT-Dv
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 19:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712AbbFKRRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 13:17:10 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34841 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbbFKRRI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 13:17:08 -0400
Received: by pabli10 with SMTP id li10so2821362pab.2
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 10:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=XX3W78Va251TqtVoI7faA75tllybjArQtpHl2l7KCJU=;
        b=NX0kG6UlSOUVwpr07IYTEwdYYBz2t3cuEP8swOH4jjkHuIcMORf/SbdTprpdhcQnNH
         i2DFSgMR4OE5Eej6+fwAWT83EIhGFwZSq4Un+im5qVH54gL7QSEDFKKSd7H/3a0CfdX0
         VzvsmbtHDgeFdVImZdb9a2hZMRuOQ+ieLSls49wrP0TJtp5WB6bT3UOM7Ph0UxvXjXky
         onWsXPRE5PEyvHPE05lggn9Jan4+BSf4a5FStAH8Qrj5pRu8wdyL0QscBOIXmgDWq9F3
         lK41PwYidRGLNv7eSqQDOKyhpExFIUrh3rETgFdCbVAyM8ZAAWYZwh5X02olYRL3Nxui
         uoeg==
X-Received: by 10.70.36.10 with SMTP id m10mr9902605pdj.34.1434043028405;
        Thu, 11 Jun 2015 10:17:08 -0700 (PDT)
Received: from [192.168.0.101] ([106.51.130.23])
        by mx.google.com with ESMTPSA id l10sm1247435pbq.87.2015.06.11.10.17.05
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2015 10:17:06 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpq1thixjs3.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271440>

On 06/11/2015 10:30 PM, Matthieu Moy wrote:
>
> I think it is more common to have options at the end, so I'd write it as
>
> filter_refs(&array, &filter, FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN);
>
> (changing the declaration too, obviously)
>
> I really like the way cmd_for_each_ref looks like now.
>

Ok! will reply to this mail with a small changed patch!

>
> I thought you would make a helper function that would return a pointer
> to either for_each_rawref or for_each_ref (or another later), but that
> would probably be overkill.
>

Yea that does seem like an overkill!

-- 
Regards,
Karthik
