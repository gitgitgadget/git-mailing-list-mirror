From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v1 3/3] travis-ci: run Git bisect on failed tests
Date: Sun, 22 May 2016 18:35:37 +0200
Message-ID: <DEFC086F-6206-4598-8355-0394C6070F59@gmail.com>
References: <1463914856-64745-1-git-send-email-larsxschneider@gmail.com> <1463914856-64745-4-git-send-email-larsxschneider@gmail.com> <CAP8UFD3TJ7mJEu2xCXhrspHY1v02uTonUGdszZbcQGf9ne9_Cg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 22 18:35:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4WM2-0007nl-V8
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 18:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbcEVQfn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 12:35:43 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34291 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214AbcEVQfl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 May 2016 12:35:41 -0400
Received: by mail-wm0-f67.google.com with SMTP id n129so8985511wmn.1
        for <git@vger.kernel.org>; Sun, 22 May 2016 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m25CnbQ7fc7TDslbDaQgruqVgAajGbzVCRcr4OqpsTo=;
        b=hdrO6tjKNBgWizYqtS/36wZmUojZuADXYSVfKXYk8hBZ21QuHt76nmQZE99yCVvNkZ
         tcvKPXolZ3q/H7dY/YI6u/dPBVlkWGDGj/zMYx1SRc+I8979+Y/gQkw/7LPu8W3+YtZO
         736vnn3Lm7+ySUpJLKA99urBC1yGjSXT9L+HLNeyjTaYLp6hkx4FNMzN7FSdJ0ai+Qt9
         6+XwrQTG152MqOAA/Ux6WemCLAmMd3L6iGTBhMj1OpWXQzuAujLHWOgreKTvZ/EcgZJ3
         d4jy121gvQM8zwx/5iXXl4QBbHItyPeCk1sBKWkXUVci1bQy47c2SeofqTtooRhh7G7F
         1rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m25CnbQ7fc7TDslbDaQgruqVgAajGbzVCRcr4OqpsTo=;
        b=bjOQ/kjl54/XrmjiUaYAdHwnQu7wNtFgpKZmaAiKP9caRon+oD3Dad50BKa1JwfRF0
         oSL3b8EvA+d3XoQiKxSpLaOcuE9PURlXUtITZDF7mUbOnLkMzvvicGMLGzt1DM6pOHT5
         bAfy0vBPaKwShTdDtdUKD+Zal0OltGkyCtMbaNka93jRprPGZiETdmBi6WaF6TLbFijr
         K3INLjgx9Ov0tD7fMU9GHSd4z2N2Idv+BpG6d4bkh/x3owH3BiopqidWZhXwybD9QcEd
         leUgfVsPcm9VpjoNa6HGWGBXn4Ey570RxSi/BzjhsjT663oNYo19ox5wzuLOx11cbClc
         VVVA==
X-Gm-Message-State: AOPr4FXRl+fm3RvMuaovFuvVSsPjTLrVjTxpRk2sGYIg63m+lL+2BCaXDuJ2jR+rM7f56g==
X-Received: by 10.28.216.208 with SMTP id p199mr12518780wmg.57.1463934940278;
        Sun, 22 May 2016 09:35:40 -0700 (PDT)
Received: from remc1rbk32.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id s125sm9017952wms.14.2016.05.22.09.35.39
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 May 2016 09:35:39 -0700 (PDT)
In-Reply-To: <CAP8UFD3TJ7mJEu2xCXhrspHY1v02uTonUGdszZbcQGf9ne9_Cg@mail.gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295286>


> On 22 May 2016, at 17:35, Christian Couder <christian.couder@gmail.com> wrote:
> 
> On Sun, May 22, 2016 at 1:00 PM,  <larsxschneider@gmail.com> wrote:
> 
> [...]
> 
>> +#
>> +# Run Git bisect
>> +#
>> +run_bisect () {
>> +       TEST_SCRIPT=$1
>> +       BAD_REV=$2
>> +       GOOD_RV=$3
>> +       TMPDIR=$(mktemp -d -t "ci-report-bisect-XXXXXX" 2>/dev/null)
>> +       cat > "$TMPDIR/bisect-run.sh" <<EOF
>> +
>> +EOF
>> +       chmod +x "$TMPDIR/bisect-run.sh"
>> +       git bisect start $BAD_REV $GOOD_RV
>> +       git bisect run "$TMPDIR/bisect-run.sh"
>> +       if test -e ./t/$TEST_SCRIPT.sh && make --jobs=2 >/dev/null 2>&1
>> +       then
>> +               cd t && ./$TEST_SCRIPT.sh >/dev/null 2>&1
>> +       else
>> +               # If the test file does not exist or the build fails then tell
>> +               # Git bisect to skip the commit.
>> +               exit 125
>> +       fi
> 
> Shouldn't all the above "if ... fi" be in the here document creating
> "$TMPDIR/bisect-run.sh"?
Ohh. Absolutely... I wonder what happened. I'll post a v2.

Thank you,
Lars


> 
>> +       git bisect reset >/dev/null 2>&1
>> +}
