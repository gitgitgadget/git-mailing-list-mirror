From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Wed, 16 Jan 2008 11:10:43 -0700
Message-ID: <a5eb9c330801161010h41e55486y5e8a4335dd939b73@mail.gmail.com>
References: <20080114202932.GA25130@steel.home>
	 <20080115200437.GB3213@steel.home>
	 <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
	 <200801160002.51048.robin.rosenberg.lists@dewire.com>
	 <20080116071832.GA2896@steel.home>
	 <a5eb9c330801160742j645ee50p72ee0a93adf8f94f@mail.gmail.com>
	 <7v1w8hslhw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_3790_16530194.1200507043546"
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 19:11:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFCjl-00040o-CG
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 19:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509AbYAPSKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 13:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbYAPSKs
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 13:10:48 -0500
Received: from nz-out-0506.google.com ([64.233.162.229]:31116 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbYAPSKr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 13:10:47 -0500
Received: by nz-out-0506.google.com with SMTP id s18so285329nze.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2008 10:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        bh=3AR5q2EUjUNE23M+hQfmKnM6RWC1pla6pJWU/N/emU8=;
        b=pSSuOxb7BRlc+p7P2vYlP+s7uuuqrgzrALa1kCKVvMh+Iks4kjV39oO173PGXLZNjK4PHD6TOpaY0T56PJD6RGrSfpDHxjYBoro0OR5E0nLd34PGH7qLGfoRgh+7mO8MeKa59UkNH3SxevQUMIbDJT6RGBR8wtulCM7gtez6WNc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=FrYXMHzWKRNNZnMb5MB03VkNxDna3iUi7cS9svE+8O3v4U4T64TvUXhTtre8ngCbh9j1hgvyWXwbs42GaNZqTDBOzwnlScruIMKNucT0jyoQuwvz8rV6rz4xMoPGdu9bddMlJEQP4nh12Ws3Q21SXj+KaBvgRnQRJto5f3WI5nE=
Received: by 10.114.92.2 with SMTP id p2mr1238180wab.90.1200507043559;
        Wed, 16 Jan 2008 10:10:43 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Wed, 16 Jan 2008 10:10:43 -0800 (PST)
In-Reply-To: <7v1w8hslhw.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70713>

------=_Part_3790_16530194.1200507043546
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Tried Junio's latest suggestion. The resulting output and contents of
the trash are attached as a tar.gz. Thanks for all your help guys, I'm
sorry I can't contribute more but as I mentioned, I'm nowhere near
proficient in c/c++ or the internals of Git.

Paul

On Jan 16, 2008 10:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Paul Umbers" <paul.umbers@gmail.com> writes:
>
> > OK, I think this worked (I'm a Java man, not C/C++). I downloaded the
> > latest 1.5.3 source from the git repository and ran "make" with
> > GIT_TEST_OPTS="--verbose --debug". Here's the output:
> >
> > paulumbers@Devteam29 ~/workspace/git/git-1.5.3/t
> > $ make
> > *** t0000-basic.sh ***
> > *   ok 1: .git/objects should be empty after git init in an empty repo.
> > *   ok 2: .git/objects should have 3 subdirectories.
> > *   ok 3: git update-index without --add should fail adding.
> > *   ok 4: git update-index with --add should succeed.
> > * FAIL 5: writing tree out with git write-tree
> >         tree=$(git write-tree)
>
> Often the first error is the most interesting, as your build is
> failing the most basic operation (like creating a tree), and
> later parts of the test uses the tree to validate other aspects
> of your build.
>
> After seeing the above error, running the test with -i (stop
> immediately on failure):
>
>         $ cd t
>         $ sh -x ./t0000-basic.sh -i -v
>
> and looking at the exact command that fails is the usual
> approach for debugging something like this.  During that
> debugging session, the contents of the directory t/trash (which
> is where the test script runs) left by the failed test is what
> we often do.
>
>



-- 
Computer Science is no more about computers than astronomy is about telescopes.
--- Edsger W. Dijkstra

Paul Umbers MSc MBCS MIAP
paul.umbers@gmail.com

------=_Part_3790_16530194.1200507043546
Content-Type: application/x-gzip; name=full_test_results.tar.gz
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fbi6uxbt1
Content-Disposition: attachment; filename=full_test_results.tar.gz

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
------=_Part_3790_16530194.1200507043546--
