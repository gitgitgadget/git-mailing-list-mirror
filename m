From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v9 2/3] t7507-commit-verbose: make test suite use write_script
Date: Fri, 25 Mar 2016 23:45:28 +0530
Message-ID: <CAFZEwPPRYBjdDabLJHsXTtzD2y=vqSZM4OiY4G=BtEF485JP_A@mail.gmail.com>
References: <01020153a7ba4eae-9b88e119-0505-418f-a137-595250edaa9d-000000@eu-west-1.amazonses.com>
	<1458817259-11675-1-git-send-email-szeder@ira.uka.de>
	<CAPig+cQJ1yK8WhXE0sxSmDenMt1DMZCoJypTu_wkDsDyuBsAWg@mail.gmail.com>
	<20160325154638.Horde.LzlsD6cZcQfmt894cll_0Tl@webmail.informatik.kit.edu>
	<CAPig+cQLOwAimmHeUmi5+KScgOP0hr9-MiX8gyGcEk6Zj0U_jQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 19:15:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajWGk-0000nf-1I
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 19:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753207AbcCYSPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 14:15:30 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34970 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752190AbcCYSP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 14:15:29 -0400
Received: by mail-qk0-f195.google.com with SMTP id s5so3715933qkd.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 11:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=iTPAcRY/Xx2hBOPQITseMG1Ar1mr/6rct6/QpQlW0f4=;
        b=F1B5c3klIDnEJpuKgaqkuSA26BRNJpSoXR3knMTYp8wEgFF/BmCIRbFwoDhTefZUXN
         FE61KG4B6TzS3vm32nPMFuH6p3knSpAVufu0VQg/5Zj5f2Jc86PBinrOsHQumlpSUqB2
         cG2r+chbOVFKiiRyh5oCjkEgCLDEB0uw8fxiXWG0osMvpJHLnXet2cGhci4iT6oKlwLE
         Ob4CxOH5DUFiTxeuHyx/WOVsdbc21pNYZsOTEwNWBTW49TYfQbqLvjysqML3hWYJ9i2s
         J0g2od+WP6TkeGaoeWJVcYmGib8lSL7VPAazrBf6hyI3Ak8uCzX8E5FEIVVEPJthi/3R
         b1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=iTPAcRY/Xx2hBOPQITseMG1Ar1mr/6rct6/QpQlW0f4=;
        b=VjF1LCdOy60sM+vvpy+vj68YMvL9dgQLmw3RdYklfRiNMR9G2UHIDKYqejC1Y8AeOy
         rRbKF3Gjutj/AWuawohyFvmo2+FGwcnwiMeRj1z+aHAGcPMs9x4PhVvrIOlGgr78FeFu
         ttz9fzVSN2WZXVPtJMRprj6kZW2AinaUG8cjRFJ/Ro2WXs2Tf+OlaZmeGzIs1arwQtVe
         nr+JL1wyBegrK7Iv4igcCy+1huZkZykDG5Uxae8KqOXYEfmxz2Qe3XQQra1zt3xVSP3p
         I1cilU5ADh8gUVFQ5KF3oa1uyuHLIpEWfyvarZDsoAL56oBzCeR56xAET7g5THJvaiKF
         roOw==
X-Gm-Message-State: AD7BkJKSQo6KPEo8wFup2BLw+d21NzKhskJYxmP5BTtFrJr9CXNvNLjDhyn1Oq9Dh8WLVpQnqGvpqr1NO2tSkA==
X-Received: by 10.129.77.135 with SMTP id a129mr7805653ywb.243.1458929728551;
 Fri, 25 Mar 2016 11:15:28 -0700 (PDT)
Received: by 10.13.203.137 with HTTP; Fri, 25 Mar 2016 11:15:28 -0700 (PDT)
In-Reply-To: <CAPig+cQLOwAimmHeUmi5+KScgOP0hr9-MiX8gyGcEk6Zj0U_jQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289927>

On Fri, Mar 25, 2016 at 10:34 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:

> That works too, simplifying the overall implementation, and
> eliminating the need for the introductory patch which moves
> 'test_set_editor' into each test.

Wouldn't it be cleaner if the introductory patch contain:
1. using write_script()
2. grep the output to a file
3. test for no of lines=1 in required tests
?

Then the patch 3/3
>> And if you insist on doing the line counting in the editor script, then
>> why redirecting grep's output and 'wc -l' separately, why not 'grep -c'?
>
> Ugh, I utterly forgot about -c.
