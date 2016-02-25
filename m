From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Some strange behavior of git
Date: Thu, 25 Feb 2016 10:57:55 +0100
Message-ID: <20160225095755.GJ1831@hank>
References: <56CE31F8.7090706@ip-5.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Olga Pshenichnikova <olga@ip-5.ru>
X-From: git-owner@vger.kernel.org Thu Feb 25 10:57:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYsg1-0001ee-Vz
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 10:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760513AbcBYJ5f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 04:57:35 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:33102 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760480AbcBYJ5d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 04:57:33 -0500
Received: by mail-wm0-f42.google.com with SMTP id g62so24446751wme.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 01:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=yFIKZQiXSFrNi/KykGtj70X+TTvj36Il7LU3GR3+PT4=;
        b=Jx8mxRPIH1edG33e72a4FykysT3qbcvLKpwecTFTryiU46mtKIFr6oGaVC3US3QyvO
         a4Th8ZfzEMP0KSaj/8iUTbZ/JkXyGflyECoDJ9oLO9ZdUXnUfW20zWPcB5MFop5XLfWs
         WPWXk6+wbI+Fz7SFAJwOcNRQYmgNObivuteA2ZoYUKNbpBbTEOkqh1axPI6jtx/zWruQ
         /kOg4JeTFWExl5/I27FhNY8DutuDFmUhqvJ1ssUHmVbJIETjLnSIn0uZUmbhxjqsNycK
         MJ73igbSZfiznMLDBNWT/zZu2i3bevlTZ+aCVnHVUY6+oQYVnK2ko6aJ7eRM/erWPbH+
         aN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=yFIKZQiXSFrNi/KykGtj70X+TTvj36Il7LU3GR3+PT4=;
        b=K2qnb1Fj6imCoJyKS1FIso4v8Bg5eYfDA17BpZvatBcJ6Frx3BtTcwNJ/wFM5vSuOh
         skLIoZNpTxCk8fyg5EmKpE/K92updQfrbZOtHo3feeqP7HYJ7lvpVkjkigAjB6nlhYf5
         2wiNBhnjo2vRsqX2zWnoUqEaMwcWt7j+z/asNk+2f5d89ywepZ/RtRWSk2EZWzEDaSh8
         39FF/Gf+davO9AOTZayGpSK5V2xq7POIV0Y06o6tsIJXXG1XumHzuPMMS5I2jDU/xFB4
         Acnpodql/WVhmEPtMxnKXIZql7Shg3J/+PioYOikNb04g0FDAYXlGMudfcUhc2vo1SuW
         69zQ==
X-Gm-Message-State: AG10YOToWap6e+jBD0P6xdqIONTRuonsPZVgSGeMIlbGSP08FUt2ybjzMFMkMcPVQyiyLA==
X-Received: by 10.194.78.199 with SMTP id d7mr43975841wjx.106.1456394252305;
        Thu, 25 Feb 2016 01:57:32 -0800 (PST)
Received: from localhost (host130-107-dynamic.40-79-r.retail.telecomitalia.it. [79.40.107.130])
        by smtp.gmail.com with ESMTPSA id m67sm2378540wma.10.2016.02.25.01.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Feb 2016 01:57:31 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56CE31F8.7090706@ip-5.ru>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287358>

On 02/25, Olga Pshenichnikova wrote:
> Hello,
> we use git in our project.
> What can be cause for further confusing behavior?
>
>     git@ip5server:~$ git status
>     On branch master
>     Untracked files:
>       (use "git add <file>..." to include in what will be committed)
>
>         app/addons/arliteks/
>
>     nothing added to commit but untracked files present (use "git add" to
> track)
>     git@ip5server:~$ git clean -dn
>     Would remove app/addons/arliteks/
>     Would remove design/
>     Would remove js/
>     Would remove var/langs/en/
>
> Why I don't see all 4 directories in first command?

Are the design/, js/ and var/langs/en/ directories empty?  Git doesn't
track empty directories, so they won't show up in git status, but with
git clean -d you specify that Git should also remove untracked
directories, which is why you see them here.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
Thomas
