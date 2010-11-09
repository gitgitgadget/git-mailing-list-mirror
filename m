From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 9 Nov 2010 23:17:07 +0100
Message-ID: <AANLkTi=F6768YZdR4H-vcnHgknV=roHG249dzbNRJVXR@mail.gmail.com>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 23:17:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFwVW-0005rn-Or
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 23:17:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754371Ab0KIWRa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 17:17:30 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47217 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754306Ab0KIWRa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 17:17:30 -0500
Received: by fxm16 with SMTP id 16so5424085fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 14:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=bdOdS5EKVF+ALd26Zb3rXol95MZpwNrixMBGdB6Dxg0=;
        b=bipAsfmRE+itEZ/1ob+VtkgKU/hOH/8MQCoYR23UIykgxelzBklmBdEjuCEAXfTJp5
         eG4gstWDXOENG6z/WcFGd4nLMlYaC5YoQUJ/ooI/fbxoDc2V7X3Pw7nO/jQ9LG5JKGL+
         xWICSYSFh6IPzvBkTX1ZefXn7nMKBDFS7iUsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=F+q4hvpWQqfvFecqUDaz47ky9JrEdGAvQ2ylRKZEylLZGbjUWmEUhswXhugV9/08tO
         0jyhmnwuXGNngYHbvlt6zgY/5lUiNh8l02k8YVhZqa3nY34mzQqxHqwLlvXGd1QI15Ky
         BRd5dk9tqXEn4lhXj9ik0UMQmU/+6CfHCqmC4=
Received: by 10.223.97.73 with SMTP id k9mr5686354fan.120.1289341047840; Tue,
 09 Nov 2010 14:17:27 -0800 (PST)
Received: by 10.223.96.66 with HTTP; Tue, 9 Nov 2010 14:17:07 -0800 (PST)
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161102>

On Tue, Nov 9, 2010 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Here are the topics that have been cooking. =A0Commits prefixed with =
'-' are
> only in 'pu' while commits prefixed with '+' are in 'next'. =A0The on=
es
> marked with '.' do not appear in any of the integration branches, but=
 I am
> still holding onto them.
>
> --------------------------------------------------
> [New Topics]
>
> * dk/maint-blame-el (2010-05-25) 1 commit
> =A0(merged to 'next' on 2010-11-05 at 8456c66)
> =A0+ git-blame.el: Add (require 'format-spec)
>
> * ef/mingw-daemon (2010-11-04) 16 commits
> =A0- daemon: opt-out on features that require posix
> =A0- daemon: make --inetd and --detach incompatible
> =A0- daemon: use socklen_t
> =A0- mingw: use poll-emulation from gnulib
> =A0- mingw: import poll-emulation from gnulib
> =A0- daemon: get remote host address from root-process
> =A0- Improve the mingw getaddrinfo stub to handle more use cases
> =A0- daemon: use full buffered mode for stderr
> =A0- daemon: use run-command api for async serving
> =A0- mingw: add kill emulation
> =A0- mingw: support waitpid with pid > 0 and WNOHANG
> =A0- mingw: use real pid
> =A0- inet_ntop: fix a couple of old-style decls
> =A0- compat: add inet_pton and inet_ntop prototypes
> =A0- mingw: implement syslog
> =A0- mingw: add network-wrappers for daemon
>
> Will merge to 'next'.

Thanks.

On Tue, Nov 9, 2010 at 8:53 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> * yd/dir-rename (2010-10-29) 5 commits
> =A0- Allow hiding renames of individual files involved in a directory=
 rename.
> =A0- Unified diff output format for bulk moves.
> =A0- Add testcases for the --detect-bulk-moves diffcore flag.
> =A0- Raw diff output format for bulk moves.
> =A0- Introduce bulk-move detection in diffcore.
>

This series currently breaks the Windows build of 'pu', as we lack
memrchr there. Jonathan Nieder posted a patch
(<20101015051750.GA21830@burratino>) that adds a memrchr
implementation. This should probably either be rebased on top of that
patch, or re-rolled.

While 'pu' not building on Windows might not be a big deal, it's worth
keeping in mind before merging it further.

> * ab/i18n (2010-10-07) 161 commits
>  - po/de.po: complete German translation
>  - po/sv.po: add Swedish translation
>  - gettextize: git-bisect bisect_next_check "You need to" message
<...>
>  - tests: use test_cmp instead of piping to diff(1)
>  - t7004-tag.sh: re-arrange git tag comment for clarity
>
> Will merge to 'next' to see what happens; it is getting ridiculously
> painful to keep re-resolving the conflicts with other topics in fligh=
t,
> even with the help with rerere.

Hmmm, this is a bit more annoying IMO - this currently breaks in
msysgit, due to lack of gettext and NO_GETTEXT not working properly.
=C6var is aware of this
(AANLkTiny+NmXew6UxjNMO+o75=3DCxxWm9iVRMRxs0LyTJ@mail.gmail.com), but
haven't fixed it yet. I do have the patches needed to get a gettext in
msysgit, so it's not a very big deal to me. But are you sure that this
makes this series ready for 'next'?
