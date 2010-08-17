From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/5] Update compat/regex
Date: Tue, 17 Aug 2010 18:50:16 -0500
Message-ID: <20100817235016.GL2221@burratino>
References: <20100817080322.GA28476@burratino>
 <1282037082-12996-1-git-send-email-avarab@gmail.com>
 <7vzkwkaktr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Paolo Bonzini <paolo.bonzini@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Frank Li <lznuaa@gmail.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 18 01:52:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlVwu-0006gP-6a
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 01:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0HQXv7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 19:51:59 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42870 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab0HQXv6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 19:51:58 -0400
Received: by vws3 with SMTP id 3so5152141vws.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=KhCvE0/ETteotnb9hti6bBA2RvXveblc3J3j6vHwOLI=;
        b=q0Tzd0YXH6asEPiiK0wtbbPUyJlEpeiolu1BTqqV9Z405C2/PMld8S9EvmTpgnCYBe
         lxPQSJKRTky4FmfxHkwLnCI2LFxglN3NI7n+W2/Y+gfH2e26+hGrLIu5hO5juULh+eLz
         gPs8oMmVNKVlCLq0kL/hnQk94BN95UH+QS3v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CutbASIruaHLArE//nYK6OHomlbay4yrsY+f+H3EgBYtpsobYLV9Pj00zBh3yNR3PN
         waE+/MRSlgSd+fbHcdJV7as+mkBqeOc2lq0mHGeZBe3+sbhXEza537V9x1VerYvObG+L
         woiOZ/lre5w6O4GibF+K04Rvr08kobtFw1CxA=
Received: by 10.220.62.72 with SMTP id w8mr4444141vch.209.1282089117632;
        Tue, 17 Aug 2010 16:51:57 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id m6sm2456037vcx.24.2010.08.17.16.51.55
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Aug 2010 16:51:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vzkwkaktr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153797>

Junio C Hamano wrote:

> Hmm, is there [1/5] in the series?

Yes, but it probably missed the list because of vger's message length
limits.

=46or convenience, here is the series.  I also think the first two
patches should be combined, but this does not do so because others
might disagree.  Patch 5 (autoconf) is the v2 version.

The following changes since commit 452c6d506b1a6dcf24d4ceaa592afc39c1c1=
a60e:

  push: mention "git pull" in error message for non-fast forwards (2010=
-08-12 18:06:07 -0700)

are available in the git repository at:
  git://repo.or.cz/git/jrn.git ab/compat-regex

=46rank Li (1):
      Change regerror() declaration from K&R style to ANSI C (C89)

Jonathan Nieder (1):
      autoconf: don't use platform regex if it lacks REG_STARTEND

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (3):
      compat/regex: use the regex engine from gawk for compat
      compat/regex: get the gawk regex engine to compile within git
      t/t7008-grep-binary.sh: un-TODO a test that needs REG_STARTEND

 Makefile                      |    4 +
 compat/regex/regcomp.c        | 3889 ++++++++++++++++++++++++++++++++
 compat/regex/regex.c          | 5003 +--------------------------------=
--------
 compat/regex/regex.h          |  462 +++--
 compat/regex/regex_internal.c | 1744 ++++++++++++++
 compat/regex/regex_internal.h |  810 +++++++
 compat/regex/regexec.c        | 4377 +++++++++++++++++++++++++++++++++=
++
 config.mak.in                 |    1 +
 configure.ac                  |   21 +
 t/t7008-grep-binary.sh        |    2 +-
 10 files changed, 11207 insertions(+), 5106 deletions(-)
 create mode 100644 compat/regex/regcomp.c
 create mode 100644 compat/regex/regex_internal.c
 create mode 100644 compat/regex/regex_internal.h
 create mode 100644 compat/regex/regexec.c
