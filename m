From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v6 0/11] create ref-filter from for-each-ref
Date: Mon, 08 Jun 2015 22:48:43 +0530
Message-ID: <5575CE73.5010605@gmail.com>
References: <5572F904.1080608@gmail.com> <vpqoakqunnn.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 19:18:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z20hI-00087A-KJ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 19:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbFHRSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 13:18:49 -0400
Received: from mail-pd0-f179.google.com ([209.85.192.179]:35130 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751082AbbFHRSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 13:18:47 -0400
Received: by pdbnf5 with SMTP id nf5so109287400pdb.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 10:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=L5UdPjd39igoKEJGWzRp3+3H7cz9jtXp6Chc7y70q54=;
        b=i2Rk2wdrAmJDaZ3IlzfTvoxMizouJKFoinSi3jA1gmRC4pqqaWZ90I2wgW2RDuk8gl
         EL/bWKmeMsI3/jMXJL6/A/lh2W10kqx/xnp634JpGwkBkwHhumPpuia38ll2GW/e45G8
         mXKWAJysiohJoAOuYlfhUMqYRn3sXK/IM0hrBEw6Wlv73Dw7sf+coIEz4tATZ79Q4MAC
         DvajprlEFo086iQI0HTwy24CzylEXt9EEsphFri7P8NrXDlZtQkudd4zbBz9FKTvtGwo
         I9jETwYXSk5pl2yHuYkjq3+JOVMmU7qh9VCknHnbuT6tTGuAijIr/ONy37nvCu7sAevk
         m92w==
X-Received: by 10.68.205.33 with SMTP id ld1mr31938125pbc.22.1433783927132;
        Mon, 08 Jun 2015 10:18:47 -0700 (PDT)
Received: from [192.168.0.100] ([106.51.130.23])
        by mx.google.com with ESMTPSA id ae9sm3164173pac.25.2015.06.08.10.18.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2015 10:18:46 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <vpqoakqunnn.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271088>

On 06/08/2015 10:45 PM, Matthieu Moy wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
> > Version four of this patch can be found here :
> > http://www.mail-archive.com/git@vger.kernel.org/msg70280.html
> >
> > v5 : http://www.mail-archive.com/git@vger.kernel.org/msg70888.html
> >
> > Changes in v5:
> > *    Rename functions to better suit the code.
> > *    implement filter_refs()
> > *    use FLEX_ARRAY for refname
> > *    other small changes
> >
> > Changes in v6:
> > *    based on latest master branch (github.com/git/git)
> > *    rename variables named sort to sorting.
>
> Other than the hunk in PATCH 9 that belongs to PATCH 10, and the
> misleading commit message in PATCH 2, the series looks good to me.
>
> (BTW, an easy way to check that each patch is compilable is to run
> "git rebase -i --exec make". It would have noticed the issue with
> filter_refs() automatically)
>
Thats brilliant, just what I needed! Thanks a lot :D

-- 
Regards,
Karthik
