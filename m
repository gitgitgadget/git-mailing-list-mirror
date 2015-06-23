From: Stefan Beller <sbeller@google.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 10:16:26 -0700
Message-ID: <CAGZ79kap++fZx3X0D95d35XioRURU468xATDZpWHDOAPapAh+Q@mail.gmail.com>
References: <1435020656.28466.8.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git mailing list <git@vger.kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 19:16:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7RoH-0007qc-4W
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 19:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754702AbbFWRQ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 13:16:29 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:35345 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754470AbbFWRQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 13:16:27 -0400
Received: by yhak3 with SMTP id k3so6448084yha.2
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 10:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TzZBitCBgA3WqULnL3BoNBLBW/H/FICTsTTX5DYKq7o=;
        b=Os9ChlZcLPsH47NrOKGWDUWyaeeMoWC3IS2Z84MIzcYb/TvLwUzLHGxYK3pSJ8/M7V
         nGV2EgnLY7/J3J/5GsaCouUYlisatzSYEqBF4VJ2pagaiT8YEWQKXW7zGrLkBdGzVCM/
         JWbdBsyB5oMGCvyRy9Cymjg5rk3XNOdiC+OMG7pO8oCp286IcwEw4ovGhiTVd/1+fT7w
         PN3c0CepqBfJwmO9qDic3YawJkThqf9wrDo6+Mat2idvbGPSZ4J3vKhVAa6rI6E2/vHn
         6PH/B6ZW+v9Qnf3jZCHvchtLEGmrRZWYZc+t8Elqu9uL4btX9HMa9cSO2kpyWSC/Y9np
         9yvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TzZBitCBgA3WqULnL3BoNBLBW/H/FICTsTTX5DYKq7o=;
        b=iB6jeqoLt95YxLR29edd19AmDPcHRnZc0X/5LSO1IY5sOXIzmtPGok9sRNJI4hA5zb
         8Q0fxSrDk3dTGArwtKwGo+XPpBfwrsOjzrLh4JZ9lzzyaKwoSq0fAMlsFF7gWN7elES0
         ryHVruaf1B7ac5Eshn4PMwHtG7RuAU9N48ODB65E+gapv7hWF0SCVbzFuLzKx2wFXiHV
         5Gt598DJAkBDGUmbgWnkii7NajqTsgM6iMwI6KanFP8CiFh7fra7/931NbCiyVHBpAUz
         UGFgboUWuo7TIxAVIvmBKiIJRzWa+G+Ovt/Gvm96ssIiXR8ZWCuIgDj3/UibHZ8qLGSq
         M3AA==
X-Gm-Message-State: ALoCoQkFsC6DpDVkH6dR4P58Lu/HoYg4HqFfsrtijadoiJj1aVdfYLTDjt3PSKRRWAC9S7bDfnFM
X-Received: by 10.13.238.71 with SMTP id x68mr45074631ywe.129.1435079786765;
 Tue, 23 Jun 2015 10:16:26 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Tue, 23 Jun 2015 10:16:26 -0700 (PDT)
In-Reply-To: <1435020656.28466.8.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272461>

[+<ronniesahlberg@gmail.com>, FYI]

On Mon, Jun 22, 2015 at 5:50 PM, David Turner <dturner@twopensource.com> wrote:
> I've revived and modified Ronnie Sahlberg's work on the refs db
> backend.

Awesome!

>
> The work is on top of be3c13e5564, Junio's "First batch for 2.5 cycle".
> I recognize that there have been changes to the refs code since then,
> and that there are some further changes in-flight from e.g. Michael
> Haggerty.  If there is interest in this, I can rebase once Michael's
> changes land.

Originally I wanted to continue on Ronnies work, but because of the churn
in refs I stopped it for a while and took care of other projects (and wanted
to come back eventually). Thanks for reviving this topic!

> The changes can be found here:
> https://github.com/dturner-tw/git.git on the dturner/pluggable-backends
> branch
>
> The db backend code was added in the penultimate commit; the rest is
> just code rearrangement and minor changes to make alternate backends
> possible.  There ended up being a fair amount of this rearrangement, but
> the end result is that almost the entire git test suite runs under the
> db backend without error (see below for details).

Looking at the end result in refs-be-db.c it feels like there are more
functions in the refs_be_db struct, did this originate from other design
choices? IIRC Ronnie wanted to have as least functions in there as
possible, and share as much of the code between the databases, such
that the glue between the db and the refs code is minimal.

Some random comments from looking over the branch briefly:

In the latest commit, (refs: tests for db backend), I am unsure about the
copyright annotations. At least a sole "Copyright (c) 2007 Junio C Hamano"
doesn't make sense to me. ;)

Typo in commit message "bisect: use refs insfrastructure for BISECT_START"

Some commits contain a ChangeId, which is a Gerrit leftover. :(

Thanks,
Stefan

>
> The db backend runs git for-each-ref about 30% faster than the files
> backend with fully-packed refs on a repo with ~120k refs.  It's also
> about 4x faster than using fully-unpacked refs.  In addition, and
> perhaps more importantly, it avoids case-conflict issues on OS X.
>
> I chose to use LMDB for the database.  LMDB has a few features that make
> it suitable for usage in git:
>
> 1. It is relatively lightweight; it requires only one header file, and
> the library itself is under 300k (as opposed to 700k for
> e.g. sqlite).
>
> 2. It is well-tested: it's been used in OpenLDAP for years.
>
> 3. It's very fast.  LMDB's benchmarks show that it is among
> the fastest key-value stores.
>
> 4. It has a relatively simple concurrency story; readers don't
> block writers and writers don't block readers.
>
> Ronnie Sahlberg's original version of this patchset used tdb.  The
> advantage of tdb is that it's smaller (~125k).  The disadvantages are
> that tdb is hard to build on OS X.  It's also not in homebrew.  So lmdb
> seemed simpler.
>
> To test this backend's correctness, I hacked test-lib.sh and
> test-lib-functions.sh to run all tests under the refs backend. Dozens
> of tests use manual ref/reflog reading/writing, or create submodules
> without passing --refs-backend-type to git init.  If those tests are
> changed to use the update-ref machinery or test-refs-be-db (or, in the
> case of packed-refs, corrupt refs, and dumb fetch tests, are skipped),
> the only remaining failing tests are the git-new-workdir tests and the
> gitweb tests.
>
> Please let me know how it would be best to proceed.
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
