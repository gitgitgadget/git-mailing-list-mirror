Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EDB51F97E
	for <e@80x24.org>; Fri, 16 Nov 2018 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeKQBT1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 20:19:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:53619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeKQBT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 20:19:27 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MTCDO-1fvaQC2DHa-00S8KH; Fri, 16
 Nov 2018 16:06:30 +0100
Date:   Fri, 16 Nov 2018 16:06:14 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Stefan Beller <sbeller@google.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ga=C3=ABl_Lhez?= <gael.lhez@gmail.com>
Subject: Re: [PATCH] bundle: dup() output descriptor closer to point-of-use
In-Reply-To: <20181116094358.GA6054@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1811161557070.41@tvgsbejvaqbjf.bet>
References: <pull.79.v2.git.gitgitgadget@gmail.com> <c88887f05a145709be9e86d56f4c1e620eb5ea89.1542209112.git.gitgitgadget@gmail.com> <CAN0heSqsjKksKnBHjffVMDEyX4A2DAY6Naw4tbBXEm+AdhOLtA@mail.gmail.com> <CAGZ79kZ_wrQ=OdJ6xWbL+F5RDb38YAmzc87o8A=Zb8zBywMJBQ@mail.gmail.com>
 <20181115043409.GA3419@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811151354150.41@tvgsbejvaqbjf.bet> <20181115133749.GA26164@sigill.intra.peff.net> <nycvar.QRO.7.76.6.1811151725310.41@tvgsbejvaqbjf.bet> <20181115164300.GA29290@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1811152059060.41@tvgsbejvaqbjf.bet> <20181116094358.GA6054@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1837126620-1542380790=:41"
X-Provags-ID: V03:K1:lSHOeHSIezMgBkwBuQpAssdSw5ojzvaUak+MqF/jvzy5BWdTe6n
 DiI16IqppLASmwQL6bhUr2Oh6JNQ/djwmVnKSeRY3Mjs3hr0LZrx+vAlCnl8SSypXt4lGmN
 fX3wJ1mvNlU26kHWo/kfvrPfSPzyLIrN/X/0QzAtkA0P+maUMQ6IqPWzBixPLfmkfBgxIl/
 e7jKg6aMJrrRed0ffE72A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SkR7ewgMXZE=:TDVFiKAH4n9U5nkTtsw1hv
 bhx9fSTYErw5RzU79bO68ttemNzXUi8A7YfoBxK8XtvUAcF3dRgBTdaw2m1Vok6/9GwVQO3Lv
 Reb22+TGlPay969mSClVCMiEhKV8xyyP10IypV9I+FIFsfRC8bK6dTeOQlN3SwX9H1pgfmQgz
 gYzOfHbLRPS54CJD7V5j3DIEZj45ELLpP3xvQUaHpfpLYzn1yuUGkzdNrY6blx4rZJ7cSJGhh
 bL7TYh2lIkmPIT07HIn4GST14JjkNLnjKO71Vys/jEON7TsYbGXq2TkgYMM0GS2HGxBTQMRn4
 nSzEJeJcPLun91WoWjdsa2N142bjER4eCWVxX2YN+flxrumYag7eoIhuKMb7dN62Ah82tJ6pr
 1mNrt0ksmZA2vrov23iclHucTlngpmnfxo7gH2r7M/xs/qOsga/llzgWMg++GhmSVyFdald5u
 LUE+7ouBmByN1QW+DUiVd0nJkXVNbRB1OLXllgVQ20dvSI9HL2RecrsxCXhhZFbfzNSUvhKDS
 k45q03tL6xS1qO0YDkstmOTVE72Le4pel/M01XWyaHl0hkIkMFck/2R0d9sFwNwTZQedKLpsd
 H4zp57+dGMZAcC4CHNxg4+qvaQMtL6lJYAwLcI2gdub+lW3ImOpHoi7py+W/OX9N9z30qkhmF
 qI+mRzgSmNAmyC9qNtESjGX6vzKNeROwCO0GNPHM5+ULy9fE28Jlc1UTNlvtC64slY4m0rj6B
 G/sGdQ5jdlfLHpOPE8Mr/CPwdjccCiey+LGv/w8PBH2KWA6L2/8LQ1eFboslM1295wQjaKSb4
 ACl5Y2UgMDBvT7VHWkaxfCUHF5TF8O+mZmwnuLHylu7nVJ2t/xoAK6TcJlH60Jv/BIk6TadAL
 Sea74uKQN8oKo0ShpHTbRUt+39KH69Z756zUCb+KhvpdcVFJeWhwq+rxG1HCHaB5ty1rPXusA
 fYuTdV00ivQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1837126620-1542380790=:41
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Peff,

On Fri, 16 Nov 2018, Jeff King wrote:

> On Thu, Nov 15, 2018 at 09:01:07PM +0100, Johannes Schindelin wrote:
> 
> > > It seems like we should be checking that the stale lockfile isn't left,
> > > which is the real problem (the warning is annoying, but is a symptom of
> > > the same thing). I.e., something like:
> > > 
> > >   test_must_fail git bundle create foobar.bundle master..master &&
> > >   test_path_is_missing foobar.bundle.lock
> > > 
> > > That would already pass on non-Windows platforms, but that's OK. It will
> > > never give a false failure.
> > > 
> > > If you don't mind, can you confirm that the test above fails without
> > > either of the two patches under discussion?
> > 
> > This test succeeds with your patch as well as with Gaël's, and fails when
> > neither patch is applied. So you're right, it is the much better test.
> 
> Thanks for checking!
> 
> > > > Do you want to integrate this test into your patch and run with it, or
> > > > do you want me to shepherd your patch?
> > > 
> > > I'll wrap it up with a commit message and a test.
> 
> Actually, I realized there's an even simpler way to do this. Here it is.
> 
> -- >8 --
> Subject: [PATCH] bundle: dup() output descriptor closer to point-of-use
> 
> When writing a bundle to a file, the bundle code actually creates
> "your.bundle.lock" using our lockfile interface. We feed that output
> descriptor to a child git-pack-objects via run-command, which has the
> quirk that it closes the output descriptor in the parent.
> 
> To avoid confusing the lockfile code (which still thinks the descriptor
> is valid), we dup() it, and operate on the duplicate.
> 
> However, this has a confusing side effect: after the dup() but before we
> call pack-objects, we have _two_ descriptors open to the lockfile. If we
> call die() during that time, the lockfile code will try to clean up the
> partially-written file. It knows to close() the file before unlinking,
> since on some platforms (i.e., Windows) the open file would block the
> deletion. But it doesn't know about the duplicate descriptor. On
> Windows, triggering an error at the right part of the code will result
> in the cleanup failing and the lockfile being left in the filesystem.
> 
> We can solve this by moving the dup() much closer to start_command(),
> shrinking the window in which we have the second descriptor open. It's
> easy to place this in such a way that no die() is possible. We could
> still die due to a signal in the exact wrong moment, but we already
> tolerate races there (e.g., a signal could come before we manage to put
> the file on the cleanup list in the first place).
> 
> As a bonus, this shields create_bundle() itself from the duplicate-fd
> trick, and we can simplify its error handling (note that the lock
> rollback now happens unconditionally, but that's OK; it's a noop if we
> didn't open the lock in the first place).
> 
> The included test uses an empty bundle to cause a failure at the right
> spot in the code, because that's easy to trigger (the other likely
> errors are write() problems like ENOSPC).  Note that it would already
> pass on non-Windows systems (because they are happy to unlink an
> already-open file).

Thanks, this is a very nice explanation (and now that I do not feel so
stressed as I did yesterday, I can easily wrap my head around it).

I can confirm that the test fails without the changes to bundle.c, and
succeeds with the changes.

Thank you so much!
Dscho

> Based-on-a-patch-by: Gaël Lhez <gael.lhez@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  bundle.c                | 39 ++++++++++++++++++---------------------
>  t/t5607-clone-bundle.sh |  6 ++++++
>  2 files changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/bundle.c b/bundle.c
> index 1ef584b93b..6b0f6d8f10 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -243,7 +243,7 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
>  }
>  
>  
> -/* Write the pack data to bundle_fd, then close it if it is > 1. */
> +/* Write the pack data to bundle_fd */
>  static int write_pack_data(int bundle_fd, struct rev_info *revs)
>  {
>  	struct child_process pack_objects = CHILD_PROCESS_INIT;
> @@ -256,6 +256,20 @@ static int write_pack_data(int bundle_fd, struct rev_info *revs)
>  	pack_objects.in = -1;
>  	pack_objects.out = bundle_fd;
>  	pack_objects.git_cmd = 1;
> +
> +	/*
> +	 * start_command() will close our descriptor if it's >1. Duplicate it
> +	 * to avoid surprising the caller.
> +	 */
> +	if (pack_objects.out > 1) {
> +		pack_objects.out = dup(pack_objects.out);
> +		if (pack_objects.out < 0) {
> +			error_errno(_("unable to dup bundle descriptor"));
> +			child_process_clear(&pack_objects);
> +			return -1;
> +		}
> +	}
> +
>  	if (start_command(&pack_objects))
>  		return error(_("Could not spawn pack-objects"));
>  
> @@ -421,21 +435,10 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	bundle_to_stdout = !strcmp(path, "-");
>  	if (bundle_to_stdout)
>  		bundle_fd = 1;
> -	else {
> +	else
>  		bundle_fd = hold_lock_file_for_update(&lock, path,
>  						      LOCK_DIE_ON_ERROR);
>  
> -		/*
> -		 * write_pack_data() will close the fd passed to it,
> -		 * but commit_lock_file() will also try to close the
> -		 * lockfile's fd. So make a copy of the file
> -		 * descriptor to avoid trying to close it twice.
> -		 */
> -		bundle_fd = dup(bundle_fd);
> -		if (bundle_fd < 0)
> -			die_errno("unable to dup file descriptor");
> -	}
> -
>  	/* write signature */
>  	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
>  
> @@ -463,10 +466,8 @@ int create_bundle(struct bundle_header *header, const char *path,
>  		goto err;
>  
>  	/* write pack */
> -	if (write_pack_data(bundle_fd, &revs)) {
> -		bundle_fd = -1; /* already closed by the above call */
> +	if (write_pack_data(bundle_fd, &revs))
>  		goto err;
> -	}
>  
>  	if (!bundle_to_stdout) {
>  		if (commit_lock_file(&lock))
> @@ -474,11 +475,7 @@ int create_bundle(struct bundle_header *header, const char *path,
>  	}
>  	return 0;
>  err:
> -	if (!bundle_to_stdout) {
> -		if (0 <= bundle_fd)
> -			close(bundle_fd);
> -		rollback_lock_file(&lock);
> -	}
> +	rollback_lock_file(&lock);
>  	return -1;
>  }
>  
> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index 348d9b3bc7..cf39e9e243 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -71,4 +71,10 @@ test_expect_success 'prerequisites with an empty commit message' '
>  	git bundle verify bundle
>  '
>  
> +test_expect_success 'failed bundle creation does not leave cruft' '
> +	# This fails because the bundle would be empty.
> +	test_must_fail git bundle create fail.bundle master..master &&
> +	test_path_is_missing fail.bundle.lock
> +'
> +
>  test_done
> -- 
> 2.19.1.1636.gc7a073d580
> 
> 
--8323328-1837126620-1542380790=:41--
