From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: [GSoC] Microproject :- Teaching git pull --rebase the
 --no-autostash flag
Date: Fri, 26 Feb 2016 17:35:54 +0530
Message-ID: <CA+DCAeSOfq22FyhPSdeYmWEL+_Bgx0et=jm786mdj-0b7R5OSg@mail.gmail.com>
References: <1456485825-21309-1-git-send-email-mehul.jain2029@gmail.com>
	<CACRoPnSoJvyvm4npw40AsgvPaviwb07akpiWtYWX3wTEME6wRA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 13:05:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZH9j-0003tM-IW
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 13:05:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbcBZMFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 07:05:55 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36310 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185AbcBZMFz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 07:05:55 -0500
Received: by mail-qg0-f44.google.com with SMTP id y9so63965324qgd.3
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 04:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=NDcHpJMrhXRELc5iwH4+WtI52biNBnQr1SC5O3XxvXo=;
        b=vaAWxzmbDV5iLzT/w75vjTFei/3mb8zg0f3VICY70Zcdc0Nz0dutTnWB5vHo4vnzDe
         8i6hF3PH7yaiBZzamF00TPJR4lYTiKOZp52890gV89kCXoFu1F0jfMm8KTMpQM68qg69
         a9qpTCs2zUN7RlP0vBtLF7Iy6KIlZAaqd1Rzw0dXm3/+cWvPmnLjdgfCQNFXYAI9p+HJ
         Xqg3Jqf8BUhxT8tWkFBD9SieridP6aKb/YySgidinPrzXodBrRcyCf1+QUuBEHDFPtCh
         gwF/kSC0pwN8AGH5U9NU9yDbwdISnBljFA7oZtJKu6T3QkDse8gU7/dXLQId2hwfmVGK
         PETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=NDcHpJMrhXRELc5iwH4+WtI52biNBnQr1SC5O3XxvXo=;
        b=jBbqu9Znz6wUwch3A5+ERqLBe83PinD6hq9KkW3EKLEJK9f9tGlUlhRsZlgKho6ybL
         +u0PaQ1EXGcy5T6omm51jQCSX/08Z2yvqy/XWl8J/a7IZ68YAO+49XLjovlKYALYLrHp
         +6bkC7NdA3EGqf3t+vWJag/cFv9M6LRgCLcxzcze/sIgxDIbMwb/9xJbH/VFRBS1ywGm
         2mQ0o9eXr/B7hfQ/lkGHtRkfQsbbFCIUdTH7m4silqbrFhkk12SorDVduLYKqV0Ne7k0
         XeH1eMRR01/Eovu5rKm1pWT1fK4CITlhhAkVM+nKoGPfZKJ9mdxDbd7UNg0max733BV1
         CyVw==
X-Gm-Message-State: AD7BkJI2/kFNVjLpHUK7j9Yz46RFc9dfSLwU1sRryNXCnQPA0FII5KEubk1LdQE3hkvCh4OdeLXKhTetTc/AUg==
X-Received: by 10.140.98.197 with SMTP id o63mr1339533qge.78.1456488354060;
 Fri, 26 Feb 2016 04:05:54 -0800 (PST)
Received: by 10.55.188.7 with HTTP; Fri, 26 Feb 2016 04:05:54 -0800 (PST)
In-Reply-To: <CACRoPnSoJvyvm4npw40AsgvPaviwb07akpiWtYWX3wTEME6wRA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287572>

On Fri, Feb 26, 2016 at 5:21 PM, Paul Tan <pyokagan@gmail.com> wrote:
> That was the point of the microproject ;-). --[no-]autostash means
> both --autostash and --no-autostash.

Oops, my bad. I will add the necessary changes :-).

Thanks,
Mehul
