From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/5] submodule-config: keep labels around
Date: Sun, 24 Jan 2016 19:06:10 +0100
Message-ID: <CAHGBnuMM5KWMUZd_ZNkEvP_homqy4kg3z356V3fhsLveZhjtBA@mail.gmail.com>
References: <1453509103-16470-1-git-send-email-sbeller@google.com>
	<1453509103-16470-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jens.Lehmann@web.de,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Jan 24 19:06:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNP3J-0000eI-Km
	for gcvg-git-2@plane.gmane.org; Sun, 24 Jan 2016 19:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068AbcAXSGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Jan 2016 13:06:13 -0500
Received: from mail-ig0-f193.google.com ([209.85.213.193]:32967 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753791AbcAXSGM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jan 2016 13:06:12 -0500
Received: by mail-ig0-f193.google.com with SMTP id h5so2984376igh.0
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 10:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hkNLKPAjKcbMdUs5dC2GZ9p8z3rzvw//+4sdylpuR9o=;
        b=Z8jII+0VYt4tH7d8LybdTg6vPVOgsgq59jACW0QQAl0mlGCosT/+RHTyEgwzURWdBG
         5jEQ66pW+NPZB/8FnkPrQU8iSxjl88fru2krrLNP8E+zy5bc+YSB2amMCnJJkZAFkrTz
         kzIOu/DA8dn80D+/R761GzDl2TLxrbAKX6o9G7HmQqkRZ8JTD75YdBU2iqsvdHsHSg0D
         Nn4Bo7UHA03oQCBT/9Ri+3o6AVgwxoEKbf37rR43xfVJb6BcxMuhU/v2OQRiIxbpuBru
         j2pxVA3LX1UIHLB+F599Tt4lQ/FASNwFSLlouXJ9q1G5fKcFVRmdW64hczp2WJfiZ+Ud
         rr4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=hkNLKPAjKcbMdUs5dC2GZ9p8z3rzvw//+4sdylpuR9o=;
        b=ielWCgTAeU6LdM0kwh9t6eLb5m1VoGU6BMRQD3N5h+38CCOx4gh7gfGnpR8voJcFK8
         9+ATuLNuf5ZreWijAqsID+t74FCHnnbEKivlF3GWJ8V4ezokF07vi5FwiPwIo7DyCASc
         +ndAMNa3D6f/wO79SxGBOb74qSus+DFwoJyaibib/JsYBSqBNJ/M4qlqBF7zjFIrCCUG
         8bM1hJPdcnfslfE6vFM29/CycdWnfuWofjsd/wizcDmKzRNaCGh7cZApOuPNZeA+sh8+
         YNUa8fJm6wAwiFmzDOjO2aJt/ar1colyuHAoXl8yhmlqI1gtTpSp7xXTcoVjK/DZcz4g
         gVVw==
X-Gm-Message-State: AG10YOSK7GXv/vyRyWaGV6qTuotXkkNfV4FVM+diU4esoTd+g2Q/lvsN6kMsz0en3s0XCmL81mIaPEQ4BKPb4w==
X-Received: by 10.50.112.137 with SMTP id iq9mr13746200igb.66.1453658770251;
 Sun, 24 Jan 2016 10:06:10 -0800 (PST)
Received: by 10.107.180.66 with HTTP; Sun, 24 Jan 2016 10:06:10 -0800 (PST)
In-Reply-To: <1453509103-16470-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284688>

On Sat, Jan 23, 2016 at 1:31 AM, Stefan Beller <sbeller@google.com> wrote:

> We need the submodule groups in a later patch.

The commit message should now say "labels", too, I guess.

-- 
Sebastian Schuberth
