From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] check-ignore: correct documentation about output
Date: Mon, 16 Nov 2015 15:13:04 +0100
Message-ID: <1447683184.2733.0.camel@kaarsemaker.net>
References: <20151108201036.GA28434@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 16 15:13:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyKWw-0000TN-PH
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 15:13:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbbKPONK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 09:13:10 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35971 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbbKPONH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 09:13:07 -0500
Received: by wmww144 with SMTP id w144so111952752wmw.1
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 06:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker_net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:content-type
         :mime-version:content-transfer-encoding;
        bh=50k4yTgjKWzSlcPsbkwOe5PiXQN6tauDZslfoa68TK8=;
        b=qo+I3lLkLS4m4iJSobnIDYz9Wbi/l6fG7DHrVSXKWcnUN0r6jkkIijQCc//n17KXju
         fVJMIVui/pHOCkqmdHe/hzvOhrfkMxO4SfZxobpUQJ+2/Qo2Ad3aC+9mClAjwixMAIfn
         dARngCWwR7gIe9IyvhP6O1Ba3wNif4w1/SLPrLGISQu7i3WjzzkYRCRSnLJgW+lVAWa3
         aPzGEPB44a4xxKz2Y+QmTDIJ1chgFIlN1xTmtNO9+ys1qvixOg3UaZiejN4SI2eRuCf0
         KOMnyidToExjelmLL3554TnWwskX1iHYrow9y28iIUoohiN0+TbFjoyUO2UOMHuoz6hU
         4T/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=50k4yTgjKWzSlcPsbkwOe5PiXQN6tauDZslfoa68TK8=;
        b=Y+tOW3IJqV2FNgueCBRzf6Cc6Gtbr5E19/PPW24oedUiidEsDr1mm3kchGxpzgzP+/
         oJ2X1o+xOtFLW/vvLkDXwGparm2ws6SzKSeWrC0DnHo7v4Y7yo8ynF3xQuInJ10NEkMJ
         8TWuL41zdZ9moKfiwMmGkelVcqII5Mf5ggOqVHBBUB5ROFI5LCqb8WWO7ZBSFgFzAwbR
         XDgT0RsBHEr44EhOhuBVO1XtGbpzBXGz5XXgG2TKKZ0wTRDxrPRnFrja2BewwbRngt5b
         ITI3p9Q2GmPGGcophtShgsqbnRIo5pCtT04d+ugYGvyUAPStGtcWlZT1Nk3t2uwOfaAP
         Q61w==
X-Gm-Message-State: ALoCoQmfpyI1Ih2nsLASnxd3Qk5rtOSkfXD1KsiRDhWWcsSACa1l9ZCTXvZmc6C5hoLnXkPYyyfp
X-Received: by 10.28.88.203 with SMTP id m194mr18756476wmb.68.1447683186079;
        Mon, 16 Nov 2015 06:13:06 -0800 (PST)
Received: from seahawk.local (proxy-gw-l.booking.com. [5.57.20.8])
        by smtp.gmail.com with ESMTPSA id uq3sm8209872wjc.10.2015.11.16.06.13.04
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Nov 2015 06:13:05 -0800 (PST)
In-Reply-To: <20151108201036.GA28434@spirit>
X-Mailer: Evolution 3.16.5-1ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281342>

Ping.

On zo, 2015-11-08 at 21:10 +0100, Dennis Kaarsemaker wrote:
> By default git check-ignore shows only the filenames that will be
> ignored, not the pattern that causes their exclusion.
> 
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  Documentation/git-check-ignore.txt | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git
> -check-ignore.txt
> index 59531ab..0a628ac 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -16,10 +16,9 @@ DESCRIPTION
>  -----------
>  
>  For each pathname given via the command-line or from a file via
> -`--stdin`, show the pattern from .gitignore (or other input files to
> -the exclude mechanism) that decides if the pathname is excluded or
> -included.  Later patterns within a file take precedence over earlier
> -ones.
> +`--stdin`, check whether the file is excluded by .gitignore (or
> other
> +input files to the exclude mechanism) and output the path if it is
> +excluded.
>  
>  By default, tracked files are not shown at all since they are not
>  subject to exclude rules; but see `--no-index'.
> -- 
> 2.6.3-495-gf0a7f49
> 
> 
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
