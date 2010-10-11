From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Undocumented git-diff syntax
Date: Mon, 11 Oct 2010 16:52:46 +0200
Message-ID: <AANLkTikBxBMm-Pv_8M7SxEugQ5pdksm_k=ihAa4toVap@mail.gmail.com>
References: <20101011150342.292ad725@chalon.bertin.fr> <AANLkTinqPiGf1nbo0oOvDD5edgLBdO8xZfjGeFC4q0MU@mail.gmail.com>
 <20101011161721.35940919@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Oct 11 16:53:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P5Jkc-0003rE-WC
	for gcvg-git-2@lo.gmane.org; Mon, 11 Oct 2010 16:53:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754299Ab0JKOxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Oct 2010 10:53:13 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:44092 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754014Ab0JKOxM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Oct 2010 10:53:12 -0400
Received: by qwf7 with SMTP id 7so1861735qwf.19
        for <git@vger.kernel.org>; Mon, 11 Oct 2010 07:53:12 -0700 (PDT)
Received: by 10.224.47.66 with SMTP id m2mr163676qaf.83.1286808792080; Mon, 11
 Oct 2010 07:53:12 -0700 (PDT)
Received: by 10.229.20.78 with HTTP; Mon, 11 Oct 2010 07:52:46 -0700 (PDT)
In-Reply-To: <20101011161721.35940919@chalon.bertin.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158763>

On Mon, Oct 11, 2010 at 4:17 PM, Yann Dirson <dirson@bertin.fr> wrote:
> On Mon, 11 Oct 2010 15:59:18 +0200
> Santi B=E9jar <santi@agolina.net> wrote:
>
>> On Mon, Oct 11, 2010 at 3:03 PM, Yann Dirson <dirson@bertin.fr> wrot=
e:
>> [...]
>> >
>> > Another thought: if we can already compare arbitrary blobs, maybe
>> > it would not be so hard to extend it to take arbitrary contents
>> > that are not stored as blobs yet ? =A0(a quick hack would be to
>> > insert an object for them, but that does not look too clean...).
>> > =A0As a use-case, I'm often found generating diffs from within cus=
tom
>> > scripts, from contents derived from a git repo, but can't use all
>> > the bells and whistles (--color, --color-words, etc), just because
>> > I have to use plain diff; that makes the output of those scripts
>> > very inconsistent with native git commands.
>>
>> Are you talking about "git diff --no-index"?
>
> Oh, right. =A0That's what it takes to read only the 1st paragraph for
> each synopsis:
>
> |If exactly two paths are given, and at least one is untracked,
> |compare the two files / directories. This behavior can be
> |forced by --no-index.
>
> OTOH, that appears not to be 100% accurate (my tests would have
> shown me): although --no-index does give me the expected results when
> one or two of the files are untracked, I have to explicitely add it,
> which seem to contradict this part of the doc.

You are right.

Additionally these two are not equivalent:

$ git diff Makefile ../Makefile
fatal: '../Makefile' is outside repository

$ git diff Makefile $HOME/Makefile
diff --git ...

(with --no-index both work)

>
> That said, this two-path construct would surely deserve its own
> synopsis.

+1

Santi
