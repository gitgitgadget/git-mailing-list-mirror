From: Phil Susi <psusi@ubuntu.com>
Subject: Re: Compare two diffs on the command line?
Date: Fri, 4 Sep 2015 15:23:40 -0400
Message-ID: <55E9EFBC.3000800@ubuntu.com>
References: <55E9DC44.90303@ubuntu.com>
 <CAPc5daVvXNWdAwiNKnQT45p03msTBEyBUq7y+ggRq0e95=_bAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 21:24:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXwae-0003cB-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 21:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933069AbbIDTX5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 15:23:57 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33706 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758222AbbIDTX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 15:23:56 -0400
Received: by ykei199 with SMTP id i199so30625149yke.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2015 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=xCE7hchWkd3gtgLDzWmLYnTRIv0GpuhzIFRzqpGhCK8=;
        b=j4BEvklk42EjzCTzqZzNFMZyhuqw7mosMEtxHYER785HGrsqUONHdlFr7rJ9iJPd2N
         ebf+HlIB3hkJaq1p8gK8GevPUsh6bHrOqfu88cIStcZ9CEAfHjbFwrjlCdpsGLvZdjXS
         2/MAn6DTqpvi48dnYLxMLk2W8IrqgoVy9CCoT5ggy5tf/E9wBPJfkCRJomMBrAx24CzD
         h0tiqw+XDYM05RDBbttWX5Kdu6UESx47TmkTw6UvLglicksnHI5dLgrjXsEKR97EIKDU
         SsaJrsyPtQ+A4K1s7EL/plP6EUrAyLcdHnKrm8GyhAVwBEFY7e2TYVLR+f8zczbXoCeS
         JNag==
X-Received: by 10.170.149.132 with SMTP id q126mr6252503ykc.18.1441394635657;
        Fri, 04 Sep 2015 12:23:55 -0700 (PDT)
Received: from [10.1.1.200] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by smtp.googlemail.com with ESMTPSA id s66sm3064413ywe.49.2015.09.04.12.23.54
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2015 12:23:54 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
In-Reply-To: <CAPc5daVvXNWdAwiNKnQT45p03msTBEyBUq7y+ggRq0e95=_bAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277331>

On 9/4/2015 2:10 PM, Junio C Hamano wrote:
> On Fri, Sep 4, 2015 at 11:00 AM, Phil Susi <psusi@ubuntu.com> wrote:
>> If you have a commit that exists on two branches, in gitk you can mark one,
>> then select the other and choose to compare the two.  This results in a diff
>> of the two diffs, rather than a diff between the two trees, which include
>> many other changes that have nothing to do with either commit.
>
> I think you are looking for the interdiff(1) tool.

Yes, that is how I would do it before git... I was thinking there would 
be a git way of doing it, especially since it is there in gitk.
