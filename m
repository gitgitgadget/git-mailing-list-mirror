From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 10:43:04 +0200
Message-ID: <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com> <1462351116-19308-1-git-send-email-larsxschneider@gmail.com> <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: peff@peff.net, Matthieu.Moy@grenoble-inp.fr, sbeller@google.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 10:43:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsOn-0000GR-9z
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757857AbcEDInL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:43:11 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38583 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757853AbcEDInJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2016 04:43:09 -0400
Received: by mail-wm0-f53.google.com with SMTP id g17so80446681wme.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O+ank8TSJBSMw2Hxuifj9LmqHRt80LoRCC0eloDw7FQ=;
        b=dqJ0GR1HPwKxBYe0xuOz6GrA4aPldg7m5ABcjf4/wIjhr0Y5hEkG5DCezxlIUVfw+u
         Pxe7iyF3xN7glCbcWQMyMs8Mo6ptmNP9bc5zBxvmZyvDNP6FfDdWjaIRhLJGEUagnF4o
         jTPNUYpbjTzXBF9a9X5sc/Pt0fMHK6H3uMi8Wz4MIDKDH/1VTgngoSk4gke4ufeJHSlt
         aUGt3iUzxRwdvODUDAhzMVvqujNFD9yQhnHq0vZyTLKPEJ5F4t47OykLqRiIPOU785pV
         cPTin+F0cDOE4yuyZvqXNkzfoO8ef83pbVocjJFHXW/pmI9gY/JKRovHllvGmqTq0WDm
         9d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=O+ank8TSJBSMw2Hxuifj9LmqHRt80LoRCC0eloDw7FQ=;
        b=SLEENZ8IXNPsTHolGRIRbwRmIqBgNy78+UIsGXwXDlNLxCDmml9rPVUTXfBHq4i6NC
         QUizNgf+nliz4Xey5bn7OlavMci3CyResGrovP8zbDpV3GYXMoN0a8X0+vOYTaHwDlux
         5yaEoVzgjix5iqva/C0dTkSQ3fVJhqdY6vSO4gZ5ilaeD9x9x8PHAi3GLYIKOWR9nXdN
         P2+UCIPIt6tQkS7xraj4nveFW1EcFED1PmyU5SuZqzPwl1KCJ5ZMfN9M5rtcZFJcIr5F
         TzZZyoKBclv+m9kFqTo5Exj2/E17MNzDK2BbS9DWZwKiBGFJ9NONNxQDvF2bKiVOqrSB
         TUWA==
X-Gm-Message-State: AOPr4FX+rdaqN3c6RHaRlKShD+jqEMCYQcUrlQ2DcnRCWejBp0NVHwzAS/vScFGbVLscFA==
X-Received: by 10.28.72.132 with SMTP id v126mr7918181wma.49.1462351387433;
        Wed, 04 May 2016 01:43:07 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB740E.dip0.t-ipconnect.de. [93.219.116.14])
        by smtp.gmail.com with ESMTPSA id jh2sm2859684wjb.39.2016.05.04.01.43.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 04 May 2016 01:43:06 -0700 (PDT)
In-Reply-To: <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293524>


On 04 May 2016, at 10:38, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
> Documentation/config.txt            | 4 ++--
> Documentation/git-check-ignore.txt  | 2 +-
> Documentation/git-filter-branch.txt | 4 ++--
> Documentation/git-for-each-ref.txt  | 2 +-
> 4 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c7bbe98..5683400 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1494,7 +1494,7 @@ gui.diffContext::
> 	made by the linkgit:git-gui[1]. The default is "5".
> 
> gui.displayUntracked::
> -	Determines if linkgit::git-gui[1] shows untracked files
> +	Determines if linkgit:git-gui[1] shows untracked files
> 	in the file list. The default is "true".
> 
> gui.encoding::
> @@ -1665,7 +1665,7 @@ http.cookieFile::
> 	File containing previously stored cookie lines which should be used
> 	in the Git http session, if they match the server. The file format
> 	of the file to read cookies from should be plain HTTP headers or
> -	the Netscape/Mozilla cookie file format (see linkgit:curl[1]).
> +	the Netscape/Mozilla cookie file format (see `curl(1)`).
> 	NOTE that the file specified with http.cookieFile is only used as
> 	input unless http.saveCookies is set.
> 
> diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
> index e94367a..9a85998 100644
> --- a/Documentation/git-check-ignore.txt
> +++ b/Documentation/git-check-ignore.txt
> @@ -112,7 +112,7 @@ EXIT STATUS
> SEE ALSO
> --------
> linkgit:gitignore[5]
> -linkgit:gitconfig[5]
> +linkgit:git-config[5]
> linkgit:git-ls-files[1]
> 
> GIT
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index 73fd9e8..6538cb1 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -205,8 +205,8 @@ to other tags will be rewritten to point to the underlying commit.
> Remap to ancestor
> ~~~~~~~~~~~~~~~~~
> 
> -By using linkgit:rev-list[1] arguments, e.g., path limiters, you can limit the
> -set of revisions which get rewritten. However, positive refs on the command
> +By using linkgit:git-rev-list[1] arguments, e.g., path limiters, you can limit
> +the set of revisions which get rewritten. However, positive refs on the command

All other linkgit fixes seem legimiate to me although I am not sure of this case

-linkgit:rev-list[1] 
+linkgit:git-rev-list[1]
  
"rev-list" works but I think "git-rev-list" would be the canonical form?
See: https://git-scm.com/docs/git-filter-branch


> line are distinguished: we don't let them be excluded by such limiters. For
> this purpose, they are instead rewritten to point at the nearest ancestor that
> was not excluded.
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index c52578b..d9d406d 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -179,7 +179,7 @@ returns an empty string instead.
> 
> As a special case for the date-type fields, you may specify a format for
> the date by adding `:` followed by date format name (see the
> -values the `--date` option to linkgit::git-rev-list[1] takes).
> +values the `--date` option to linkgit:git-rev-list[1] takes).
> 
> 
> EXAMPLES
> -- 
> 2.5.1
> 
