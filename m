From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [RFC/PATCH 0/9] add options to ref-filter
Date: Mon, 08 Jun 2015 20:30:22 +0530
Message-ID: <5575AE06.5020302@gmail.com>
References: <5573520A.90603@gmail.com> <CAP8UFD2FCKTbfzRtNWdwimR93-k3WWoQPOWEKsSPrVpdcEmkDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 08 17:00:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1yXT-00065o-Bp
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 17:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbbFHPAb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 11:00:31 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:32783 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347AbbFHPA1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 11:00:27 -0400
Received: by padev16 with SMTP id ev16so42032687pad.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 08:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=1B9q+YOklcgMhohxOcuk8PoImVhuYQ0pTwU7epXi9q4=;
        b=E03FxpPpz/wdOsQcJ/4vxrDDVXQ5ADdYGJqQ4QZhmSzUxayE5dGPWyUbMmtP2GK+pp
         L4SbEyYObt9CisE1/p0/hNiplvKYe+ILH6BN3mCTdeTXpA9jKY0iL0bnqQ0Diw8K+Nqv
         nIIzG3vdbk2hpYu/V2osYlc6zhzoM6agPmFylFB/y0vJbuVApbPE2UFuMW3ZQzOrF/8d
         8S8ovuIdbzsVJdvxn9J6g90N8/LtwtzOOWsJNkJA4tgucHcYlUkct09gcjne0RpyMh+/
         R6x3k5kZOFY31tVjrgCpBPbaOxk30mVG5YdJHlurhW+SlPkBdPVjB/pG4aSXEutSuF/Z
         +T9w==
X-Received: by 10.70.61.167 with SMTP id q7mr29896696pdr.41.1433775627367;
        Mon, 08 Jun 2015 08:00:27 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id q4sm2887517pdo.42.2015.06.08.08.00.24
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 08:00:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <CAP8UFD2FCKTbfzRtNWdwimR93-k3WWoQPOWEKsSPrVpdcEmkDg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271041>

On 06/07/2015 06:40 PM, Christian Couder wrote:
> On Sat, Jun 6, 2015 at 10:03 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> > This is a follow up series to the one posted here
> > http://thread.gmane.org/gmane.comp.version-control.git/270922
> >
> > This patch series adds '--ponints-at', '--merged', '--no-merged' and
>
> s/--ponints-at/--points-at/
>
> > '--contain' options to 'ref-filter' and uses these options in
> > 'for-each-ref'.

Thanks!

-- 
Regards,
Karthik
