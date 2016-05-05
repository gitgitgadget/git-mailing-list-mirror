From: David Turner <dturner@twopensource.com>
Subject: Re: t7900-*.sh tesr #5 failure
Date: Thu, 05 May 2016 17:34:18 -0400
Organization: Twitter
Message-ID: <1462484058.24478.10.camel@twopensource.com>
References: <57291982.2000904@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Thu May 05 23:34:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayQul-0006ze-OQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 23:34:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756309AbcEEVeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2016 17:34:21 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35744 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756114AbcEEVeV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2016 17:34:21 -0400
Received: by mail-qk0-f170.google.com with SMTP id j68so38742975qke.2
        for <git@vger.kernel.org>; Thu, 05 May 2016 14:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=tXJ6UoFGHz1nqArSoPAizABz5EYV4UTDMJqXNK2qGtY=;
        b=zsq+60nu5oYBdwhgD67+kHLbDTkUVDaVEpQJUmWiKWzvTlRJJ9BB4BD0q/wHeJuTyu
         7D0FO4+I2kAmxZdgroSJcTCFwyNYzV/WhHGZDBUUWcLoeMHjphnHMhJGlELgc2UEnCxI
         kNd88ZRxCNJxO2P7oBz+I2y1BsywhrBZsPY88/5V2owkwxmCk6RQEXjqlaDgnteF6xZG
         Kyy6OYlMOwTnQPxe5g2yuJdBzT83jgsPXWc6f69I4FdovztoIB3bbBwO2q/w1zCC2K6h
         HaEHUTyEI++7yfX02rzQfYjakL7Ow7oZQrtz3VedYdh98afZJ9JEpP4RCny3fo1jKrp9
         e76Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=tXJ6UoFGHz1nqArSoPAizABz5EYV4UTDMJqXNK2qGtY=;
        b=eb58tS0oiOWUObEz2Sb3A8T2G89tAv6Kvt4NyjZ76bGIced6agrZH0caaVAJ8qJSzH
         SnexFQcKzmCga19VOVS1CQ4KrtiFeiOc59tImg2e3vB8ZudQgHI6gsz/WmPTvYSRBlKb
         tIAFcsX9GgU6MI6aFWlWHtSd7FTDtDuFBJQj0DRQAlPE9ZeZyem/LhtRO3lXhDWocUE2
         zu5U+JmkVuuR6PkWWu8L30OxNfffdTqh1wnSFWvx7FL1c8Pdy8LFlPMrFwov7I1a76jZ
         EVXlv6P1Irdwq6o2/t758sp/O+fGmofzKhvVEyS9XABXIMCuJ28fboiPqaIE6hWCwsTq
         TRvQ==
X-Gm-Message-State: AOPr4FXs4f4JJ9h4In7tAiGc4ZvppEjZm5fS9a78p1GCgO69Bq7FeXn4liHQAnTBQVkIRQ==
X-Received: by 10.55.98.81 with SMTP id w78mr17457063qkb.113.1462484059919;
        Thu, 05 May 2016 14:34:19 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id w17sm4315402qha.23.2016.05.05.14.34.18
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 May 2016 14:34:19 -0700 (PDT)
In-Reply-To: <57291982.2000904@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293683>

On Tue, 2016-05-03 at 22:34 +0100, Ramsay Jones wrote:
> Hi David,
> 
> Test t7900.5 fails for me, thus:
> 
>   $ ./t7900-index-helper.sh -i -v -x -d
>   
>   ...
>   
>   + test -S .git/index-helper.sock
>   + git status
>   On branch master
>   Untracked files:
>     (use "git add <file>..." to include in what will be committed)
>   
>   	err
>   
>   nothing added to commit but untracked files present (use "git add"
> to track)
>   + test -S .git/index-helper.sock
>   + grep -q . err
>   error: last command exited with $?=1
>   not ok 5 - index-helper autorun works
>   #	
>   #		rm -f .git/index-helper.sock &&
>   #		git status &&
>   #		test_path_is_missing .git/index-helper.sock &&
>   #		test_config indexhelper.autorun true &&
>   #		git status &&
>   #		test -S .git/index-helper.sock &&
>   #		git status 2>err &&
>   #		test -S .git/index-helper.sock &&
>   #		! grep -q . err &&
>   #		git index-helper --kill &&
>   #		test_config indexhelper.autorun false &&
>   #		git status &&
>   #		test_path_is_missing .git/index-helper.sock
>   #	
>   $ cd trash\ directory.t7900-index-helper/
>   $ ls
>   err  x.t
>   $ cat err
>   warning: We requested watchman support from index-helper, but it
> doesn't support it. Please use a version of git index-helper with
> watchman support.
>   $ 
> 
> [Yes, that is one long line in err!]

OK, the failure here is due to a bad check in the code -- it's intended
that index-helper work without watchman.  Will re-roll with a fix.

> [At least, this is one of the failures, I have also seen git status
> failing
> with a SIGPIPE.]

I'll add in a sig_ign on that.

> Note that I do not have the watchman libraries etc., so USE_WATCHMAN
> is
> not defined. Note also, that I had an instance of git-index-helper
> still
> running after the test failure (which I kill-ed).

I missed a test_when_finished (note that in the case of test failures
in debug mode, test_when_finished statements are not executed on
failing tests, so you would still see an index-helper in that case;
since test failures are not expected, that shouldn't be a problem).

Will fix, thanks.

> I haven't spent any time debuging this, but some questions spring to
> mind:
> 
>     - can index-helper be used without watchman support?

Yes (once I re-roll with the bug fix).

>     - why is index-helper requesting watchman support, when it was
>       built without USE_WATCHMAN being defined?

It's not; the code that checks for that request is mistakenly detecting
that it is.

>     - why is read-cache.o exporting hte verify_index and
>       write_watchman_ext symbols?

verify_index should be used in index-helper but that somehow got lost
in v3.  Will fix on reroll.
write_watchman_ext is exported because index-helper currently uses it.

>     - is index-helper any use/help without watchman support?

Yes for large indexes -- see the measurements in patch v3 (which is
earlier in the series than watchman is introduced).

>     - is '! grep -q . err' meant to determine if the err file is
>       empty (ie git status did not issue an error message)?
>       [if yes, maybe 'test_must_be_empty err &&' would read better!]

Will fix, thanks.
