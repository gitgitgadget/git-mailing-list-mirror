From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "./t0001-init.sh --valgrind" is broken
Date: Thu, 3 Mar 2016 08:04:54 +0700
Message-ID: <CACsJy8AL_RGEb2z44-yoL+3yF7n1+FMLqZkmWwUDFJnEPYS_nw@mail.gmail.com>
References: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 02:05:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abHhq-0006li-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 02:05:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751821AbcCCBF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Mar 2016 20:05:26 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:32907 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243AbcCCBFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Mar 2016 20:05:25 -0500
Received: by mail-lb0-f182.google.com with SMTP id k15so5513571lbg.0
        for <git@vger.kernel.org>; Wed, 02 Mar 2016 17:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/aCbhCtCbapOPHT7DBagmKm88fWXJ+PckP/96WZqoms=;
        b=BA8ne0Zz+NwKVj08NPToafIDNMIrZ0YR6femgpsaaqoqOp4waFLGffeI4orBL8uumd
         yBLommR7J9eLpg4yVGy8L7yohORzTcVaQxlrIxuQswQSbzoWNt0U9kbSB7kMEipzjLhb
         eOUDl/aan9tZqfvK0cl7Ji7ipRDRbpkUEwioJ5EDiI6T/8GwVkDckP5mW0TSf9pj4v+A
         8hicavpPECWdKCqGhVTj82R95sw5KL6fvZy75kpR2il3zyFXnVCt1QqinzxcC8752h3F
         TIrP64MGn6DPXS5Sv2n9/rAwnJoarnOBZzjNKDP9KrJVD3qh05gBJZYShknmXwhlN/TS
         qblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/aCbhCtCbapOPHT7DBagmKm88fWXJ+PckP/96WZqoms=;
        b=Rx+ISmfe2wu/c67nPJPBm37+sBFX26OUIANVWOuFct6gy4Mm/dlzV3tc8jyh1dssGt
         Bj0jI4GoquH1DCOAvpzyFX99o6KHFwvxMvZjVpSeiTSTF1cLCoPYhtJWUwMKzjHwfz+S
         8vs06FH9cdFEOMXZAf2MsQyWMCSjK9GQmotLtqCDmGgIrFaQJ2UC6COqZqmmff/3U81x
         lndi7mEOdQnuZDLgFHnqoE7In1xXBx08fHidnb77oSiJBVhEbWUJ8pxuza9C+G8QlN7g
         l2chPVeDD1jezjTDQ6ZrrxT7Z/4DdLn+Ks65GTvipy1ocUkru76RVk9y1B7oY1O8O3Uw
         6MWQ==
X-Gm-Message-State: AD7BkJKK6esKPwbGngdzTqsBEf8T73DmunN0M6y79pia8yXrHKcPb4MBwE/k3L7qqINJuXMq1CH7W16udnVleg==
X-Received: by 10.112.150.133 with SMTP id ui5mr11083188lbb.12.1456967123774;
 Wed, 02 Mar 2016 17:05:23 -0800 (PST)
Received: by 10.112.34.162 with HTTP; Wed, 2 Mar 2016 17:04:54 -0800 (PST)
In-Reply-To: <CAP8UFD0-FxoPe5-35NAKSkegFBoRPy1+BOsqN-y+QJUoXAqR3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288160>

On Thu, Mar 3, 2016 at 7:07 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> It looks like commit 57ea7123c86771f47f34e7d92d1822d8b429897a (git.c:
> make sure we do not leak GIT_* to alias scripts, Dec 20 14:50:19 2015)
> broke "./t0001-init.sh --valgrind".

Just wanted to confirm the problem. I will look at it later today.
-- 
Duy
