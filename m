From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Sat, 4 Sep 2010 14:14:36 +0100
Message-ID: <AANLkTik9awEd40s3r-O8t9DwZBh34Z0ozsxMm1QNjNoT@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<alpine.LFD.2.00.1009021249510.19366@xanadu.home>
	<AANLkTinFPxsY6frVnga8u15aovQarfWreBYJfri6ywoK@mail.gmail.com>
	<alpine.LFD.2.00.1009021624170.19366@xanadu.home>
	<B757A854-C7BF-4CBF-9132-91D205344606@mit.edu>
	<7voccezr7m.fsf@alter.siamese.dyndns.org>
	<20100903183120.GA4887@thunk.org>
	<alpine.LFD.2.00.1009031522590.19366@xanadu.home>
	<AANLkTi=sC3NMNzPRQM5RKwnZQyRq-gq6+7wdiT5LGDrc@mail.gmail.com>
	<AANLkTinoyehduhdHSEm5yGTLvU6C-ViE885yLd63iQU0@mail.gmail.com>
	<4C81A67B.2060400@gmail.com>
	<alpine.LFD.2.00.1009032304560.19366@xanadu.home>
	<4C81DC34.2090800@gmail.com>
	<alpine.LFD.2.00.1009040153280.19366@xanadu.home>
	<AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Artur Skawina <art.08.09@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Ted Ts'o" <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Sep 04 15:14:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrsZv-0004hE-La
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 15:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881Ab0IDNOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Sep 2010 09:14:38 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54653 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752751Ab0IDNOh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Sep 2010 09:14:37 -0400
Received: by vws3 with SMTP id 3so2095576vws.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 06:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=eVI3TSnRF/WwPNz5yFvZhvur1ReyJdV9ITS6rU+ztKo=;
        b=qabkqjoncZH1y8P+vbu/OUo1W7jy/TsvN4mjJaIdTRGH82L94N59Lf3OBXDGo6hsaY
         fBZjk6oxKjO2+1uP0QB6wzpcs9hE0H7BRLbS44l75Z3QId4FjTnUKZ3ONvv2Adw5beMM
         tnJ9bBgLfi5/p4xnW6sK9ab8poQsPuOwrG6LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=v5/bxXeRdpijxkgO+I/nP5Et7PbYlCiqKQsZrQGwu98jrMJjpvDq1dLYV+frA32SNq
         A71H0JKtQO/QcLI9XyBHbrIpE2SWb3tmwahf68BSWWIXIglUo0YTi/iz5PJRw3+YZjXz
         BYrXO5yCEreZd4xxGuI5ibTmRZn8GRDpeLrTg=
Received: by 10.220.126.208 with SMTP id d16mr1404989vcs.206.1283606076367;
 Sat, 04 Sep 2010 06:14:36 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Sat, 4 Sep 2010 06:14:36 -0700 (PDT)
In-Reply-To: <AANLkTi=7jUSCNiPf+HfEQuxaf16Jt06--bFE7=Of9wp=@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155324>

On Sat, Sep 4, 2010 at 12:58 PM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> ok, there's one other question i need some info on (thank you to
> nguyen for answering about git cat-file): is there a way to make
> git-pack-objects _just_ give the index file, rather than go to all the
> trouble of creating the pack file as well?
>
> the reason i ask is because i would like to get the index file, parse
> it for objects (as nicolas recommends) then present the contents of
> "git cat-file" as files within subdirectories, via this
> pseudo-VFS-layer over bittorrent.

pack-objects.c - write_pack_file():
...
        if (pack_to_stdout) {
            sha1close(f, sha1, CSUM_CLOSE);
        } else if (nr_written == nr_remaining) {
            sha1close(f, sha1, CSUM_FSYNC);
        } else {
            int fd = sha1close(f, sha1, 0);
            fixup_pack_header_footer(fd, sha1, pack_tmp_name,
                         nr_written, sha1, offset);
            close(fd);
        }

        if (!pack_to_stdout) {
            struct stat st;
            const char *idx_tmp_name;
            char tmpname[PATH_MAX];

            idx_tmp_name = write_idx_file(NULL, written_list,
                              nr_written, sha1);

....

ahh, whoops.  any advances on that?

grep write_idx_file *.c */*.c

* git-index-pack requires a pack file in order to re-create the index:
i don't want that
* git-pack-objects appears to have no way of telling it "just gimme
index file please"
* fast-import.c appears not to be what's needed either.

so - any other methods for just getting the index file (exclusively?)
any other commands i've missed?  if not, are there any other ways of
getting a pack's index of objects without err... getting the index
file?  (i believe the answer to be no, but i'm just making sure) and
on that basis i believe it is safe to ask: any objections to a patch
which adds "--index-only" to builtin/pack-objects.c?

l.
