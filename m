X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH] Print progress message to stderr, not stdout
Date: Mon, 4 Dec 2006 16:37:05 +0100
Message-ID: <20061204153705.GA8644@diana.vm.bytemark.co.uk>
References: <20061111121625.8988.45195.stgit@localhost> <e5bfff550612020520w3ad48a09xfdde63b9050a75cf@mail.gmail.com> <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Mon, 4 Dec 2006 15:37:58 +0000 (UTC)
Cc: Marco Costalba <mcostalba@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0612040117y6554b891yaf6eb59d0d52ebf0@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33197>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrFtB-0004SX-UH for gcvg-git@gmane.org; Mon, 04 Dec
 2006 16:37:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937024AbWLDPhR convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006 10:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937028AbWLDPhR
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 10:37:17 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4543 "EHLO
 diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937024AbWLDPhQ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec
 2006 10:37:16 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GrFsP-0002Gl-00; Mon, 04 Dec 2006 15:37:05 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-12-04 09:17:16 +0000, Catalin Marinas wrote:

> On 02/12/06, Marco Costalba <mcostalba@gmail.com> wrote:
>
> > On 11/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> >
> > > Printing progress messages to stdout causes them to get mixed up
> > > with the actual output of the program. Using stderr is much
> > > better, since the user can then redirect the two components
> > > separately.
> >
> > This patch breaks qgit.
>
> Since there are other tools relying on a clean stderr, I think I
> would revert it and add a verbose flag and/or config option. Karl,
> any thoughts on this (since you sent the patch)?

I introduced this since I wanted to divert the output to a file, and
the progress message had no business being written to that file. But a
command line option to suppress progress messages would work just as
well if that's what git does.

--=20
Karl Hasselstr=F6m, kha@treskal.com
