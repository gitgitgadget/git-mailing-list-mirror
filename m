From: Nix <nix@esperi.org.uk>
Subject: Re: git: cannot rename foo to Foo on a case-insensitive filesystem (e.g. on Windows)
Date: Sun, 02 Sep 2007 01:20:20 +0100
Message-ID: <87bqcluddn.fsf@hades.wkstn.nix>
References: <3f4fd2640708280117k3f1cd03el676a87084a83480f@mail.gmail.com>
	<46D3ED4E.6030606@op5.se>
	<3f4fd2640708280317o2cee8ae9j28a92f39d8e6a583@mail.gmail.com>
	<alpine.LFD.0.999.0708281522260.25853@woody.linux-foundation.org>
	<85mywbb7p7.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0708281555580.25853@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Kastrup <dak@gnu.org>, Reece Dunn <msclrhd@googlemail.com>,
	Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 02 02:20:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRdCr-0002yL-Gr
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 02:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbXIBAUj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 1 Sep 2007 20:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932545AbXIBAUj
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Sep 2007 20:20:39 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:55641 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932353AbXIBAUi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2007 20:20:38 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l820KLXS015349;
	Sun, 2 Sep 2007 01:20:21 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l820KK27015115;
	Sun, 2 Sep 2007 01:20:20 +0100
Emacs: if it payed rent for disk space, you'd be rich.
In-Reply-To: <alpine.LFD.0.999.0708281555580.25853@woody.linux-foundation.org> (Linus Torvalds's message of "Tue, 28 Aug 2007 16:01:45 -0700 (PDT)")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.5-b28 (linux)
X-DCC-INFN-TO-Metrics: hades 1233; Body=5 Fuz1=5 Fuz2=5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57288>

On 29 Aug 2007, Linus Torvalds verbalised:
> And if you use that algorithm, them '=DF' and 'ss' are equal in a=20
> case-insensitive filesystem.=20
>
> Does anybody do that? I don't know. But I sure as hell wouldn't be=20
> surprised.

Oh yes, they do. Guess what I spent the last month fixing in a huge hea=
p
of proprietary software. Of course the problem is not truly fixable
because of the potentially unbounded set of context-dependent stuff suc=
h
as `Masse'.

(I hear some people got a summer holiday...)
