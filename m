From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: Re: GSoC 2016: Microproject
Date: Sun, 21 Feb 2016 21:32:37 +0530
Message-ID: <CA+DCAeSpN+OSJ85yyqq9ONzfubh=coMd7FTct5OkEnLvhMm2tw@mail.gmail.com>
References: <CA+DCAeTAmUAciCx33ZHLKReHSy4K-dEeaKSb19qBcQc_U80UJA@mail.gmail.com>
	<vpq37so26oz.fsf@anie.imag.fr>
	<CA+DCAeQLJnvNFdSobDNOGVaHbDRnRy4vm9_4SB+Bw+5N5QMKHA@mail.gmail.com>
	<CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Feb 21 18:52:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXYBW-0007X5-PM
	for gcvg-git-2@plane.gmane.org; Sun, 21 Feb 2016 18:52:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbcBURwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Feb 2016 12:52:37 -0500
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33580 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbcBURwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Feb 2016 12:52:35 -0500
Received: by mail-qk0-f169.google.com with SMTP id s5so48662823qkd.0
        for <git@vger.kernel.org>; Sun, 21 Feb 2016 09:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2l+/HQuK+fSDJwZ9APfPALrNkv26Nm6X/OzSd1H4Hag=;
        b=KeoG/WHJfftuEQcbslIFONhvko73YoVkiCntc0S4BAdO8MzrhjRdjCYFKCmisteeC4
         LfMrXBART1U2j18bcZsNXNPDwueZVqIT1fqXg2Xg8BEtgX9w+k5hEXN30KcYE5I45ypM
         BRYc8m3XKzbwAoxvWmlve5opreAE+H06EgyxcOcCyKa8MyYTTZbi3R3EGQAInrsigR5X
         NMYYrh/R3rMmFXonuOnbHrDdVqYHi7vuPxIOYpAPTOYuBoUkd3kjdVz6tb5M22zDUZlI
         cI3FuK82wpj8grtPJ1XPzPze6OGMTdIE1XvzlFxRl8FPmxZpS++7Hdwr+OevnYPeeCaf
         RNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=2l+/HQuK+fSDJwZ9APfPALrNkv26Nm6X/OzSd1H4Hag=;
        b=XJZLD08voYhdRV3StXtWzrJCJrMdmgwghBnIlOuaO6R8fzoW21k4/OP+/MObu3RYZT
         22mddwMryqJ/pLd1P1KqZZaQLRHqhZObW7OizbUDM6MxWQ6RwMMj+77gLgkkGc4TW5Jh
         aDMNuK/WOrHF99smWxCH/mMwy3mtFmpUy/PaOuSkoIsJd/QUSYEP70Wugt7c/GFZ1CeO
         iCHfNI7s4/ubkAZFQgRAwPPdkdzduLwg9fJb/y2H63lUnT7Ev30JzUQ5dvw8h67+364c
         f24h9c+r32XvTjQL8hTH0Drebko0s2BIKvQ2y+2i5HMl62U/kWY7HnvYZeGLLq6RzJKA
         2uMw==
X-Gm-Message-State: AG10YOT9gqyMkXb6Xy6ByP0nY0wTmJRi0b/UG+BLRzBkxcS6h2lh6ZD/XJICN9hislk7IUx0Qm88Ov1NmADbow==
X-Received: by 10.55.54.201 with SMTP id d192mr28855857qka.23.1456070557246;
 Sun, 21 Feb 2016 08:02:37 -0800 (PST)
Received: by 10.55.154.205 with HTTP; Sun, 21 Feb 2016 08:02:37 -0800 (PST)
In-Reply-To: <CAGZ79kbdTFui5Zxmt0+BrgOzxTFsN2n-XZiJBNj4QFD3HPRpBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286811>

On Fri, Feb 19, 2016 at 11:20 PM, Stefan Beller <sbeller@google.com> wrote:
> Yes, most likely t/t5521-pull-options.sh or t/t5520-pull.sh would be the right
> place as judging from the file name of the tests.

I checked out both of the files and made following observations -

1) As I'm going to add an option for "git pull --rebase"; tests should
be added for following commands in t/t5521-pull-options.sh
          a)  git pull --rebase --[no-]autostash
          b)  git pull -v --rebase --[no-]autostash
          c)  git pull -q --rebase --[no-]autostash

2) Also test for "pull --rebase --[no-]autostash fails with dirty
working tree and rebase.autostash set" should be added to
t/t5520-pull.sh.

Have I made the right observation?

Thanks,
Mehul Jain
