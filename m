Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BAFF1FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 22:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbcFQWF5 (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 18:05:57 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37877 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750986AbcFQWF4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2016 18:05:56 -0400
Received: by mail-wm0-f53.google.com with SMTP id a66so5367131wme.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2016 15:05:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nhdQfv9B5st45L2dSo9BrCM9PAiI77SSisGzSDJpoQg=;
        b=SRMlL60R3wrPfseteFP10KRhCOo52rg89olARvWnBkhjJkygLhZ0Z2I/GRlC17QnHq
         PF+wzOKuZ5tLA1f3geY4W464qRMR45d4euYv27di4JEcI9WNbldb+s4AX23n+F8HYJAI
         IfWXp7yB135l7szam/G9D5IiSdA6esLCEFBCZWFSxNOEwArcruCk/aSTgPx6FC+klFjC
         remrsGusNbNVhjOWap5leRWVLPejqUniMH7f+0O1ZNxydMVG7dL85v+GPyQjTBVnYATQ
         Cf/obMraBZ1S2LJe/R9L4xBGIomRNHLfCk/5V/JNAHkcDmsJeABsQAbW6A7DNd5ekWJX
         DYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=nhdQfv9B5st45L2dSo9BrCM9PAiI77SSisGzSDJpoQg=;
        b=DhLD+J2XFiYuooY+PL6ZlQVl33+ZgPxJMjxCuADsTE6ZNE1V/HrvxSGHLID7iWKk1I
         7vZvkJpKEpFPLeB6fyxpgcHkUm4izsxabwyg6oZrZy0PJ7Ur+nMWPKXYuN2Pl/cpro66
         6aLtje7exfBusckDgsh7FNnxZtyaDi08tl63VDBhJ5HajEGDRV1/3j5vSI2Qbmr45OWO
         aspYHdeRYmUzSffp9/elsSNLk38xp4hdFnlu8OANPy9Qfh6w3LZL6gy0CxP6i0ZYcYM8
         qB6kIVLvPp/9f0Tbc1w8XQk1olU05lnl06J3LucPsLFyds/IsrMduyGtM7et2wGrtdLq
         pvCw==
X-Gm-Message-State: ALyK8tKwr/WkqhriBNvQYtqi6eFOsrZ+GfvXjlyW3I0Tm7DprzNz/fSe3PA381VJIu6a/g==
X-Received: by 10.28.138.13 with SMTP id m13mr558331wmd.3.1466201154884;
        Fri, 17 Jun 2016 15:05:54 -0700 (PDT)
Received: from far-cnu3239jwk.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id ue1sm29870304wjc.44.2016.06.17.15.05.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 17 Jun 2016 15:05:53 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: What's cooking in git.git (Jun 2016, #05; Thu, 16)
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
Date:	Sat, 18 Jun 2016 00:05:52 +0200
Cc:	Git Mailing List <git@vger.kernel.org>,
	Luke Diamand <luke@diamand.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
Content-Transfer-Encoding: 8BIT
Message-Id: <1634E84E-5260-4F7B-A74F-AF5D3A7C0181@gmail.com>
References: <xmqqk2ho33ig.fsf@gitster.mtv.corp.google.com>
To:	Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 17 Jun 2016, at 05:20, Junio C Hamano <gitster@pobox.com> wrote:
> 
> ...
> 
> * mh/split-under-lock (2016-05-13) 33 commits
>  (merged to 'next' on 2016-06-03 at 2e71330)
> + lock_ref_sha1_basic(): only handle REF_NODEREF mode
> + commit_ref_update(): remove the flags parameter
> + lock_ref_for_update(): don't resolve symrefs
> + lock_ref_for_update(): don't re-read non-symbolic references
> + refs: resolve symbolic refs first
> + ref_transaction_update(): check refname_is_safe() at a minimum
> + unlock_ref(): move definition higher in the file
> + lock_ref_for_update(): new function
> + add_update(): initialize the whole ref_update
> + verify_refname_available(): adjust constness in declaration
> + refs: don't dereference on rename
> + refs: allow log-only updates
> + delete_branches(): use resolve_refdup()
> + ref_transaction_commit(): correctly report close_ref() failure
> + ref_transaction_create(): disallow recursive pruning
> + refs: make error messages more consistent
> + lock_ref_sha1_basic(): remove unneeded local variable
> + read_raw_ref(): move docstring to header file
> + read_raw_ref(): improve docstring
> + read_raw_ref(): rename symref argument to referent
> + read_raw_ref(): clear *type at start of function
> + read_raw_ref(): rename flags argument to type
> + ref_transaction_commit(): remove local variable n
> + rename_ref(): remove unneeded local variable
> + commit_ref_update(): write error message to *err, not stderr
> + refname_is_safe(): insist that the refname already be normalized
> + refname_is_safe(): don't allow the empty string
> + refname_is_safe(): use skip_prefix()
> + remove_dir_recursively(): add docstring
> + safe_create_leading_directories(): improve docstring
> + read_raw_ref(): don't get confused by an empty directory
> + commit_ref(): if there is an empty dir in the way, delete it
> + t1404: demonstrate a bug resolving references
> (this branch is used by mh/ref-iterators, mh/ref-store and mh/update-ref-errors.)
> 
> Further preparatory work on the refs API before the pluggable
> backend series can land.
> 
> Will merge to 'master'.

This topic seems break two git-p4 tests (t9801 and t9803) on next:
https://travis-ci.org/git/git/jobs/137333785

According to git bisect the commit "ref_transaction_update(): 
check refname_is_safe() at a minimum" (3da1f3) introduces the problem: 
https://s3.amazonaws.com/archive.travis-ci.org/jobs/138457628/log.txt
(scroll all the way down to see the bisecting)

- Lars