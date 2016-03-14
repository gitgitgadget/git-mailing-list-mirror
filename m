From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/GSoC] Introduction
Date: Sun, 13 Mar 2016 23:15:58 -0700
Message-ID: <CA+P7+xpCJKYLq_vzOm=sD=oNOV0fsVphRkem3JF4iMf1EWV1HQ@mail.gmail.com>
References: <56E3BE3E.9070105@gmail.com> <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com>
 <56E5B27D.7010808@gmail.com> <20160313211910.GA22052@ikke.info> <56E64B5C.7030405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Daudt <me@ikke.info>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sidhant Sharma <tigerkid001@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 07:16:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afLnj-0000Su-0q
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 07:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbcCNGQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 02:16:20 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33410 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752122AbcCNGQS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 02:16:18 -0400
Received: by mail-ig0-f180.google.com with SMTP id ig19so54741517igb.0
        for <git@vger.kernel.org>; Sun, 13 Mar 2016 23:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Tnn6gs+m4cq+8SpDLwTU2IUV3DQRYj7JAL9n3+MJzAY=;
        b=Z1AmpU8GvI+NyrM3ma+/XiomvoJDvPq6JpPYxtiLjnm4YPS3LjP4Mh86rFF/pKPtQB
         GdYrs5H83ojUONUywxVLZb6+ec3d6O8Jsj2qwLM/abi4iqncT1eJ/VMLvo47UCDZ9+GM
         INN0mGRYA0obX/D9d6wbaotO0l/5OP4iGYVIZ8zB4Zwoqf6BDF/PeJ3RRWmKnqiXkYjl
         9Cem2MWJ1lUWgnCcPKAeT5uRoAuXarjbUhhYaG8Qe6fAtAvZ3YQV4XRjW8lb21bqm1AC
         2DxDpRHsmQ3DwKpJ4//psWg4swNfjgFMhOrQ0de1TyTqi/8YTVO7U37ubsYl1cpER1NL
         Gxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Tnn6gs+m4cq+8SpDLwTU2IUV3DQRYj7JAL9n3+MJzAY=;
        b=bDzCSgTZj6eDtDvkE4IM0kCOvO/qw2JNxWb/cwqduBqzK1zhLHG1jSUCZfja1x3ACu
         fq7dBVUgyQUMbq3WCZFw2drYO5PgPdi9PEUANVVd+PxgE/Jv+mpnCmOZ9VXpY+cB1QX3
         XvVMp0YRLBqw5sy0+/4Dce1M9W4yjj//uxsjmKSo7WjagRvlcJikH66HzJydfWFMZVwD
         4cPBayPa4E7EUmc4VC41V+BcEMtnMWHsKo2NQDmEcDgwpgMP/wD7rBbUgxxmSPZcmsQH
         fOm2n42Jo9efZbjxi892zvkALuHFXraaOi0B1DcgV2t1AsdcPS1WARbd6tsCJ6cL82Vg
         50ag==
X-Gm-Message-State: AD7BkJKEU+dNWwUmYbiIykWU2XymZUkfEXH7/ret3695RfYkB36LmYLIiVlUqnqmXLEwKDQRwiPFK7YziDJ7cQ==
X-Received: by 10.50.142.103 with SMTP id rv7mr16110239igb.35.1457936177601;
 Sun, 13 Mar 2016 23:16:17 -0700 (PDT)
Received: by 10.107.10.202 with HTTP; Sun, 13 Mar 2016 23:15:58 -0700 (PDT)
In-Reply-To: <56E64B5C.7030405@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288769>

On Sun, Mar 13, 2016 at 10:25 PM, Sidhant Sharma <tigerkid001@gmail.com> wrote:
>
> On Monday 14 March 2016 02:49 AM, Kevin Daudt wrote:
>> On Mon, Mar 14, 2016 at 12:03:33AM +0530, Sidhant Sharma wrote:
>>> Other than this, I also tried to expand the list of potentially destructive
>>> commands and updated the list as follows (additions in brackets):
>>>
>>> * git rebase [ git pull --rebase ]

For rebase, it is tricky since many work flows and setups use it a lot
in ways that aren't a problem. Ideally we'd be able to warn about
cases where it is very bad, but not in cases where it isn't likely to
cause problems. It may be that it isn't possible to programatically
determine this though.

Regards,
Jake
