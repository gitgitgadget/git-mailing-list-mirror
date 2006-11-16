X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] StGIT bash completion
Date: Thu, 16 Nov 2006 16:40:02 +0100
Message-ID: <20061116154002.GA20729@diana.vm.bytemark.co.uk>
References: <20061112211813.19959.73406.stgit@localhost> <b0943d9e0611160621g60a0cac2r5205e37ed7d9fe9f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 15:40:21 +0000 (UTC)
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0611160621g60a0cac2r5205e37ed7d9fe9f@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31590>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkjLY-0007QT-JZ for gcvg-git@gmane.org; Thu, 16 Nov
 2006 16:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424174AbWKPPkH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006 10:40:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424182AbWKPPkH
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 10:40:07 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:24072 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1424174AbWKPPkF
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 10:40:05 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GkjLP-0005R5-00; Thu, 16 Nov 2006 15:40:03 +0000
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

On 2006-11-16 14:21:27 +0000, Catalin Marinas wrote:

> On 12/11/06, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > A minimal bash completion script for StGIT. It completes the
> > subcommand names, and options and patch names for some
> > subcommands.
>
> Thanks for the patch. I modified it slightly to automatically
> generate the options for other commands as well (by invoking "stg
> help <command>" and it doesn't seem to be slow). I'll try to push it
> tonight.

Hmm. I'll have to try it, but I was half planning to hard-code the
list of subcommands instead of calling "stg help" since it causes a
tangible delay. On the machines I've tried, it easily takes 0.2
seconds to run "stg help" (with hot caches; with cold caches, it's
_really_ bad), and that's bad for interactive behavior.

There's also the point that some switches need (or can benefit from)
the tab completion machinery, and thus can't just be automatically
extracted and used. But autocompleting the switch names shouldn't
interfere with that, and hard-coding stuff that changes every now and
then is both morally wrong and a lot of work.

> Thanks for the other patches as well. I included some

Ah, thanks!

>  but haven't finished them yet.

No problem. Thanks to the power of modern version control systems, I'm
able to use my own branch of StGIT in the meantime, on all the various
computers that I use. :-)

--=20
Karl Hasselstr=F6m, kha@treskal.com
