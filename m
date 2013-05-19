From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/9] for-each-ref: add %(tracking[:upstream]) for tracking info
Date: Sun, 19 May 2013 07:03:26 -0500
Message-ID: <CAMP44s0_o6xgkbo3rT1rXSRS6kmasiooVohZcO3W+PcspbSz0w@mail.gmail.com>
References: <1368959235-27777-1-git-send-email-pclouds@gmail.com>
	<1368959235-27777-6-git-send-email-pclouds@gmail.com>
	<CALkWK0k5qM3CZoivC1GJaBfwxWwvpDVtU7mHmm3feiLKr4kxXw@mail.gmail.com>
	<CAMP44s1a5JH1T-ckvmFomoKKhFCE61CQ79YFxi4RiQLqeqhgTw@mail.gmail.com>
	<CACsJy8DSH2Uq9-KhLVS=6Gu5L2q_gbHtrqmaQWE4_DJ6J2zQmQ@mail.gmail.com>
	<CALkWK0m8HbYRAJdPgN7CnX_VMTX36GG-=BcqM+NTKwxX_0xqzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 19 14:03:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ue2Kq-0005lg-75
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 14:03:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754512Ab3ESMD2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 08:03:28 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:40564 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754191Ab3ESMD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 May 2013 08:03:27 -0400
Received: by mail-lb0-f178.google.com with SMTP id w10so4221638lbi.37
        for <git@vger.kernel.org>; Sun, 19 May 2013 05:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=WYdDB7F11WwaX2AxWV40hwQ7IEDTmHpB8hmoy7Gz/wA=;
        b=gGDQfcPAmiP/DJATNbfh7SqeCUSMDND7ZqMixencO03lHIJFOJVbITGRQhXfOybYhP
         mGcYbDpQCskNEMzxUggJKfiV5gvvceQPWL5T0Jz8cxmD3EvdgEnMvbcpulAoW/4z5e7v
         4BhZlfO9BC5NLVPaCVnFjhkzrdXHH6g//t4u2Il/+7z2TBOjNEkerUI/bNJYIZPxLEw4
         KTEVHIsOzWnao++MfvoMULKU1tU6jLci0CPEuB/mLb0iGVWIMNKxi1IHnCcS3x/Iw/XA
         f4783M/qttBFr6GpeAgkaT09h38BvRsE7iILTBzntDX1BkqVVWRTPnX31+RSdamxdOP9
         93bw==
X-Received: by 10.112.163.71 with SMTP id yg7mr16299338lbb.8.1368965006385;
 Sun, 19 May 2013 05:03:26 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Sun, 19 May 2013 05:03:26 -0700 (PDT)
In-Reply-To: <CALkWK0m8HbYRAJdPgN7CnX_VMTX36GG-=BcqM+NTKwxX_0xqzg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224877>

On Sun, May 19, 2013 at 6:48 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> Exactly. I already explained why %(upstream) can't be used in 00/09.
>> "tracking" may not be perfect. Somebody might want
>> "tracking:upstream:short". It does not look quite nice.
>
> Which is why I suggested keeping upstream, upstream:short, and
> introducing upstream:diff and upstream:shortdiff (or :tracking if you
> prefer that) in [0/9].

Yeah, but there won't be any upstream in %(tracking). Besides, if we
manage to get downstream, we could do %(tracking:downstream). I think
%(tracking) and %(short:tracking) make sense.

-- 
Felipe Contreras
