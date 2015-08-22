From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Which branch(es) contain certain commits? (was Re: (unknown))
Date: Sat, 22 Aug 2015 16:29:55 +0530
Message-ID: <CAOLa=ZRdYKqSjT90VRW0qOeQ9YG6xN0QojrhUwrar2V1DyHe5w@mail.gmail.com>
References: <349031438778845@web22j.yandex.ru> <CACsJy8Be-kY49CxAJTx2R2XG-c_WeuU=yLFT8-XSoaDkTScPGg@mail.gmail.com>
 <xmqqh9nxerfv.fsf@gitster.dls.corp.google.com> <5570041440192599@web21j.yandex.ru>
 <xmqqio88466l.fsf@gitster.dls.corp.google.com> <2689531440235153@web22m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Ivan Chernyavsky <camposer@yandex.ru>
X-From: git-owner@vger.kernel.org Sat Aug 22 13:00:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZT6XG-00008b-Dk
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 13:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbbHVLA0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2015 07:00:26 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:35868 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562AbbHVLAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2015 07:00:25 -0400
Received: by obkg7 with SMTP id g7so77667850obk.3
        for <git@vger.kernel.org>; Sat, 22 Aug 2015 04:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=04lvZ1lZBzSqnRpUW81+s7lEbnPTjZdh2IvczIeGDys=;
        b=BwWq3k5ZVovrjZntYOOq8pRpTTOC5lNb3rzJ87ysY8F/3sUUtm/kYsHah4u/CRvIi1
         ui3jHo5i2vw1ojzaKgSU6nq4B4sdV/xESToebgCN80dcQiErX1JLXpOABups+VeaaDl9
         UVYJc8e78/2espiFcOSRzqiyBcvB4lGpVJt3iKBmHCkBas/513eTCnxQNhVA4njfB/vE
         WgG8Ag5hyZN6UDaMfKCoKNEXSQXD7GP3eVLMKQMgVWQu/D7dL68gEnf7Ls0BO5+BirDu
         L1rLuUJwjw0O5VDSjF31PaYvlOeowgO8129PFiBDDpSfIYJaY3LLX3zu4gqchLbIL+Vx
         tAgg==
X-Received: by 10.60.70.104 with SMTP id l8mr12245337oeu.37.1440241224724;
 Sat, 22 Aug 2015 04:00:24 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Sat, 22 Aug 2015 03:59:55 -0700 (PDT)
In-Reply-To: <2689531440235153@web22m.yandex.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276388>

On Sat, Aug 22, 2015 at 2:49 PM, Ivan Chernyavsky <camposer@yandex.ru> wrote
>
>>  Note that "branch --list", "tag --list" and "for-each-ref" are being
>>  revamped to share more internal code. If you want to pursue this,
>>  you probably would want to build on top of that effort once it is
>>  done. That way, you may get "tag --grep=FIX123" for free.
>>
>
> This is interesting. So can I have a look on some repo/branch or just wait until it'll be merged?
>

This should be what you're looking for:
http://thread.gmane.org/gmane.comp.version-control.git/276363
http://thread.gmane.org/gmane.comp.version-control.git/276377

This is the current progress, the rest is in git/next.

There is still a series of porting the printing part of branch.c to be done.

-- 
Regards,
Karthik Nayak
