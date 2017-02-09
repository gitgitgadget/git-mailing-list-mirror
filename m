Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA61F1FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 16:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752159AbdBIQLd (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 11:11:33 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:65225 "EHLO
        alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751030AbdBIQLc (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Feb 2017 11:11:32 -0500
X-AuditID: 12074414-773ff70000004a85-97-589c93efc96e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 80.8E.19077.FE39C985; Thu,  9 Feb 2017 11:08:15 -0500 (EST)
Received: from [192.168.69.190] (p4FEDF6A1.dip0.t-ipconnect.de [79.237.246.161])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id v19G8DXe031152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Thu, 9 Feb 2017 11:08:15 -0500
Subject: Re: What's cooking in git.git (Feb 2017, #02; Mon, 6)
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <2f67fc21-92f9-a03e-1b09-a237af6dbc46@alum.mit.edu>
Date:   Thu, 9 Feb 2017 17:08:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqzihzymn3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsUixO6iqPth8pwIg/sFFl1XupksGnqvMDsw
        eVy8pOzxeZNcAFMUl01Kak5mWWqRvl0CV8a93afZCm7wVzy+L9zA2M7bxcjJISFgIvHs4Hvm
        LkYuDiGBy4wS9470MEE455kk9p6axAxSJSxgJ9Hz7yw7iC0iYC3x++d3JhBbSMBK4vCRFWwg
        NpuArsSinmawOK+AvcT6322MIDaLgIrExN7VrCC2qECIxJyFDxghagQlTs58wgJicwLNvHln
        Jth8ZgE9iR3Xf7FC2PIS29/OYZ7AyDcLScssJGWzkJQtYGRexSiXmFOaq5ubmJlTnJqsW5yc
        mJeXWqRroZebWaKXmlK6iRESciI7GI+clDvEKMDBqMTDO6FqToQQa2JZcWXuIUZJDiYlUV7Z
        AqAQX1J+SmVGYnFGfFFpTmrxIUYJDmYlEd7L/UA53pTEyqrUonyYlDQHi5I477fF6n5CAumJ
        JanZqakFqUUwWRkODiUJ3sOTgBoFi1LTUyvSMnNKENJMHJwgw3mAhi8DqeEtLkjMLc5Mh8if
        YtTlWLb9zEsmIZa8/LxUKXHeCpAiAZCijNI8uDmwVPGKURzoLWHeJpAqHmCagZv0CmgJE9CS
        66dngSwpSURISTUwzn73ssVpL9/E/9lhio9fOq1t7vyvae84caoRj3//CXGzmXG5E1aa6P17
        JX6kSjkjv6o776X6RYlKVXGxMy6ST/mmfG8oN9zxwe8sZ3nJ0tyoG5c/aR09ZPMtKWBbifF0
        94kNhvvk5i87EVAgtn/Od+fQbj7nz/0he89K8wvOezWn6W2MpjmfEktxRqKhFnNRcSIAWL6H
        2fACAAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/06/2017 11:34 PM, Junio C Hamano wrote:
> [...]
> --------------------------------------------------
> [Stalled]
> [...]
> * mh/ref-remove-empty-directory (2017-01-07) 23 commits
>  - files_transaction_commit(): clean up empty directories
>  - try_remove_empty_parents(): teach to remove parents of reflogs, too
>  - try_remove_empty_parents(): don't trash argument contents
>  - try_remove_empty_parents(): rename parameter "name" -> "refname"
>  - delete_ref_loose(): inline function
>  - delete_ref_loose(): derive loose reference path from lock
>  - log_ref_write_1(): inline function
>  - log_ref_setup(): manage the name of the reflog file internally
>  - log_ref_write_1(): don't depend on logfile argument
>  - log_ref_setup(): pass the open file descriptor back to the caller
>  - log_ref_setup(): improve robustness against races
>  - log_ref_setup(): separate code for create vs non-create
>  - log_ref_write(): inline function
>  - rename_tmp_log(): improve error reporting
>  - rename_tmp_log(): use raceproof_create_file()
>  - lock_ref_sha1_basic(): use raceproof_create_file()
>  - lock_ref_sha1_basic(): inline constant
>  - raceproof_create_file(): new function
>  - safe_create_leading_directories(): set errno on SCLD_EXISTS
>  - safe_create_leading_directories_const(): preserve errno
>  - t5505: use "for-each-ref" to test for the non-existence of references
>  - refname_is_safe(): correct docstring
>  - files_rename_ref(): tidy up whitespace
> 
>  Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
>  once there no longer is any other branch whose name begins with
>  "foo/", but we didn't do so so far.  Now we do.
> 
>  Expecting a reroll.
>  cf. <5051c78e-51f9-becd-e1a6-9c0b781d6912@alum.mit.edu>

I think you missed v4 of this patch series [1], which is the re-roll
that you were waiting for. And I missed that you missed it...

Michael

[1] http://public-inbox.org/git/cover.1483719289.git.mhagger@alum.mit.edu/

