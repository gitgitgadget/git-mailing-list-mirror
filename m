Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 027D61F461
	for <e@80x24.org>; Thu,  4 Jul 2019 10:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfGDKDA (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jul 2019 06:03:00 -0400
Received: from mout.gmx.net ([212.227.17.22]:37295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727385AbfGDKC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jul 2019 06:02:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562234573;
        bh=VFxrxH6NdhvXNQrxpAUQXhIc/5JxZ6dTrYVSsUDO4/E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=WA2PZe2JqfhvYSycSbD+xsAWQats5BJ9vxs69vY8XpVU5zUfVPLQmQ+LnlwGVh4FZ
         +JHGxDZs83QSGfANMIGPJEYXvYslAAgZoPzLaZ0/azBgFZ8XG4F3htMto5DkjxOnRS
         GcdfGs8XqUP+UT8H8vPq4+90KzctHwdJj/KBINAw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M9Fnj-1hdlNq2dAV-006PZq; Thu, 04
 Jul 2019 12:02:53 +0200
Date:   Thu, 4 Jul 2019 12:03:22 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
cc:     git@vger.kernel.org
Subject: mt/dir-iterator-updates, was Re: What's cooking in git.git (Jul
 2019, #01; Wed, 3)
In-Reply-To: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907041136530.44@tvgsbejvaqbjf.bet>
References: <xmqqpnmqzrbg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ucDfjp/oHX5fAI2ANrLSF8l7hDkbokqaw71piQ/rSxGd3kloBhb
 1kcTivbuB2ioEhT+rYqhB6knAoID10/qZuqe6O6LX+VBaIuuozk4J49kywjJNwZkFG3Klp+
 tZGqLRZh4ObPHvZnYFxuP31o/HWPWBX8QtuwJQhFo+qKLbszNt32CpwXSwjz9ToS/h6RduY
 +WXRdpsPUHnlC6V+ba6oQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uU9It7lbKeU=:hGnaxoby+BrJlOFFuCWfr3
 1YV6jHhmYhreTtCjzy3xPdV4UqkCoyKXpXp/PdPXwuqylRSdFaDDgYfWCX72wAKRRRkNY5AIP
 mOMlf7XYBxBnMWNVGPXet8tiGMZeKJ0XhxxrjWATQlJ5Nv+nWQ7e4JAwFyp3qyBJggPm8JjlP
 iGoqqc00+HjStGpOzK28ZPGdF5qDcRFkKkpUVi9ZP9kgj1uS1O77ARJAB6Ng19lexf2FhK2oo
 NuNFtckZtzoq2kTRKpq2RimiUA0Q464BcdpEF8XhXQxe58J31VRqhOVUXevvz1fDR9xXD6OGO
 580/uoViI/Q0EY+qiFZEjpqBPh+BE09bnWKdyaWR6pa/lcElf01X44/aFor3ZYO0cO9irOoKl
 Z3ZCQQb+v24UM53ZfhwRQgcG4jtPaugaB6FkLD97u9E3gkk7wHc0SiMf8BZ2giGPBufTOJOwy
 1facKaMNgCX5i6enb667ByZw+MA3/uB0OyuAVMbe2hCl3PeNSTMsDLwtNbmX+RTJ6uTKlJf67
 fCXB7wN/Pn6uKcwDaOtqk82EeQUjZ8TrWLxC0xyIrp04EqIS2wOvl2AktLJ8pSx81jBRWw9mf
 Oz9S4106yhexHYEoGzKsqV1rlgNlP784/XotK9C4H/BA7gAx/oQRYoSywR26qbUxrgZGgP9nU
 IseKGzwo2xPOdpcRIq27OUlSVCCaW+baBTa/lk26zy7UeKxyi3fyjfGLjfCR2geAR0yXObZTn
 mzkzXdfjRm1Hg/y3g4GGGdryxbCr/20skdYJEQjjME25VlqB82c8C52xjiwp+JG89p/uGCHpb
 wNk2iEHCjXO/xvff9WFd6tkHgYcecw7Ue9j/8fqCuhS0l4KqOEhpgkqJLZ4flTDPbD7qacLsw
 2ZDCCTfwrB2y2aut4Bjq0lp65+H3vrt0GyakhDYH6VGY4gI53SePOeE/q8GtNIxQFTfNEoHW0
 L7mT+2p3ORvmbaU51gV7+d5RoY0Zg+BEeSwhwOsra5fURGEqbr0KPHkq5EY86Od/enZH6k+Yb
 PZiXNI0j9phLTbd2CNsivQ44nfpJDEZdzEgNk0uCQeA/JXZ9YlufXLTfxxOlTQr9ovUi9VnLM
 CPczc+btddsx9u0vrNLPMmIa1S64XsOXJNa
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 3 Jul 2019, Junio C Hamano wrote:

> * mt/dir-iterator-updates (2019-06-25) 10 commits
>  - clone: replace strcmp by fspathcmp
>  - clone: use dir-iterator to avoid explicit dir traversal
>  - clone: extract function from copy_or_link_directory
>  - clone: copy hidden paths at local clone
>  - dir-iterator: add flags parameter to dir_iterator_begin
>  - dir-iterator: refactor state machine model
>  - dir-iterator: use warning_errno when possible
>  - dir-iterator: add tests for dir-iterator API
>  - clone: better handle symlinked files at .git/objects/
>  - clone: test for our behavior on odd objects/* content
>
>  Adjust the dir-iterator API and apply it to the local clone
>  optimization codepath.
>
>  Is this ready for 'next'?

No. It still breaks many dozens of test cases on Windows (if not more)
because it thinks that it can rely on `st_ino` to detect circular
symlinks.

In
https://public-inbox.org/git/nycvar.QRO.7.76.6.1906272046180.44@tvgsbejvaq=
bjf.bet/
I had suggested to do something like this:

=2D- snip --
diff --git a/dir-iterator.c b/dir-iterator.c
index 52db87bdc99f..85cd04b7b571 100644
=2D-- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -8,6 +8,7 @@ struct dir_iterator_level {

 	/* The inode number of this level's directory. */
 	ino_t ino;
+	dev_t dev;

 	/*
 	 * The length of the directory part of path at this level
@@ -63,6 +64,7 @@ static int push_level(struct dir_iterator_int *iter)
 		strbuf_addch(&iter->base.path, '/');
 	level->prefix_len =3D iter->base.path.len;
 	level->ino =3D iter->base.st.st_ino;
+	level->dev =3D iter->base.st.st_dev;

 	level->dir =3D opendir(iter->base.path.buf);
 	if (!level->dir) {
@@ -138,11 +140,14 @@ static int find_recursive_symlinks(struct dir_iterat=
or_int *iter)
 	int i;

 	if (!(iter->flags & DIR_ITERATOR_FOLLOW_SYMLINKS) ||
-	    !S_ISDIR(iter->base.st.st_mode))
+	    !S_ISDIR(iter->base.st.st_mode) ||
+	    /* On Windows, st_ino is always set to 0 */
+	    !iter->base.st.st_ino)
 		return 0;

 	for (i =3D 0; i < iter->levels_nr; ++i)
-		if (iter->base.st.st_ino =3D=3D iter->levels[i].ino)
+		if (iter->base.st.st_ino =3D=3D iter->levels[i].ino &&
+		    iter->base.st.st_dev =3D=3D iter->levels[i].dev)
 			return 1;
 	return 0;
 }
=2D- snap --

Duy had also suggested to guard part of this using `USE_STDEV`, but as
Matheus figured out that would not make sense, as the `USE_STDEV` flag
really is meant to work around issues with network filesystems where
`st_dev` can be unreliable.

However, in the meantime I thought about this a bit more and I remembered
how this is done elsewhere: I saw many recursive symlink resolvers that
just have an arbitrary cut-off after following, say, 32 links.

In fact, Git itself already has this in abspath.c:

	/* We allow "recursive" symbolic links. Only within reason, though. */
	#ifndef MAXSYMLINKS
	#define MAXSYMLINKS 32
	#endif

But then, the patch in question uses `stat()` instead of `lstat()`, so we
would not have any way to count the number of symbolic links we followed.

Do we _have_ to, though? At some stage the path we come up with is beyond
`PATH_MAX` and we can stop right then and there.

Besides, the way `find_recursive_symlinks()` is implemented adds quadratic
behavior.

So I would like to submit the idea of simplifying the code drastically,
by skipping the `find_recursive_symlinks()` function altogether.

This would solve another issue I have with that function, anyway: The name
suggests, to me at least, that we follow symlinks recursively. It does
not. I think that could have been addressed by using the adjective
"circular" instead of "recursive". But I also think there are enough
reasons to do away with this function in the first place.

Ciao,
Dscho
