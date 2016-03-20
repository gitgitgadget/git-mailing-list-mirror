From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: GSoC Project | Improvise git bisect
Date: Sun, 20 Mar 2016 21:56:54 +0530
Message-ID: <CAFZEwPMEDnzv3mLpULOY=7CQZgULx5QsAb_4Pz40iJWzt9HRGg@mail.gmail.com>
References: <CAFZEwPN-oUDNnc_PBeP2Q4msJAHenkiLtE+Oo75R+uTTwUKpYQ@mail.gmail.com>
	<vpqoaaahbvi.fsf@anie.imag.fr>
	<CAP8UFD2fudNtGpUHTYjZKXCErocuRS65E=5tH_+_tsNFbmHCBA@mail.gmail.com>
	<CAFZEwPMeejJEMjYbx1sJsH0UNygDEdtNazceOePo81Abi0dHHQ@mail.gmail.com>
	<CAFZEwPP2OLOQanazPXxK1u5GVHzFWqx8GuRad7tLUyHrWR_+Tw@mail.gmail.com>
	<alpine.DEB.2.20.1603201628590.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jeff King <peff@peff.net>, Troy Moure <troy.moure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Kevin Daudt <me@ikke.info>,
	Philip Oakley <philipoakley@iee.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Mar 20 17:27:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahgBw-0003Fz-Gf
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 17:27:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751458AbcCTQ04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 12:26:56 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35010 "EHLO
	mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750839AbcCTQ0z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 12:26:55 -0400
Received: by mail-yw0-f195.google.com with SMTP id d21so4721700ywe.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=qoCtZs4JT0ReYv/PBFK3IgDSaoe1yxkHPkzbpxwkJsc=;
        b=DsxNCJiieqJUC9U/zepsALTJv8YRtAbm0VnRLtP3sxg+PIZQTLyjKjbY4EEjJzpWzR
         EVBDucTHDsThIN21eAvyfNW7uBI+dhQDR0DnY7WM2F97wmI/avLFJEGwK54NABIHnOBq
         buboXNkbVqBjUkCvgIE3AjDsPw3X53JirEezePvrFydUzgs1450/cJlNmayBUgsRsseo
         p27JHcxKfaMsK6jb40YMwgARHSYvyGIOXkZ3w2OgzcduoBL0AqrmMr9g0aNS95HddHWz
         nAVaB1Ym/xHA2Z2YXuwGIuc1JzoCQf2IpvyAZGjiENXH9p8fnAHH+Sh0ZSry0X7y4lmj
         do7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=qoCtZs4JT0ReYv/PBFK3IgDSaoe1yxkHPkzbpxwkJsc=;
        b=h7zlrdnR0NOLfjVfFBY1U7s4ZXXI3dVOocrBQM94fuJSXjbn3rFiavCSJkHaMq61tx
         k1B8PEnCcua+Z05W4QdybY3YYVR/SKf6LUpnwycOgdgHwOBKYs3YK3cGQe2W+JcQOcRV
         JQGH2JiBk9Cb40dZwQ7oiTxerrbEpqnJVNUeZQCuT+E74ELvNw4xEAlqkwvK6Shh3IF3
         LYqDdcsb0GZrNPk9cD62t+tZUdorV7Yer7n0g5NoF1l9HrmLLy5XfrOj6F9PQ57zu1eI
         8/UuMnkkPV5e0RYDFojNSwHP8n82sr4giBK6gtQ6WY4RhG/UF7zDelyS2Tp5iUpwH2Cq
         8oLg==
X-Gm-Message-State: AD7BkJJBdEKxZcSTDGxSApHhbWMH55gkhC5KPo4xidrRLp2UY5oMbBIgWywa1Q0NyRiqvKS7fZtPdMYXPD5BQA==
X-Received: by 10.37.100.196 with SMTP id y187mr6961471ybb.80.1458491214114;
 Sun, 20 Mar 2016 09:26:54 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Sun, 20 Mar 2016 09:26:54 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603201628590.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289364>

I didn't mention it before, I was thinking to move directly everything
from git-bisect.sh to bisect.c . But then I would have to redirect to
a shell script. And ultimately remove bisect--helper.c

Your suggestions is a lot better. I could first move individual
functions to bisect--helper.c. This would not affect the current
status of the project. When I complete this, I can shift all the
methods to bisect.c and place it in the directory builtin/. Then I
would remove linking of the git-bisect.sh and introduce
builtin/bisect.c thus completing the process. When I am writing
functions, I am thinking to make some tests which will be copied
contents of t/t6030-bisect-porcelain.sh with s/bisect/bisect--helper/g
uncommenting tests as I implement more functions. Should I keep these
tests restricted to myself or I send it as a patch along with the
corresponding function?
