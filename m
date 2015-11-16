From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase-i-exec: Allow space in SHELL_PATH
Date: Mon, 16 Nov 2015 17:01:03 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1511161656480.1686@s15462909.onlinehome-server.info>
References: <1447394599-16077-1-git-send-email-fredrik.medley@gmail.com> <20151113062534.GE32157@sigill.intra.peff.net> <CABA5-zk+RVBxfmuLyK8CcCFUpMXEzbHRKeWWV2SKsJqjnG-nfA@mail.gmail.com> <20151113222748.GA14830@sigill.intra.peff.net>
 <CABA5-zmmKeeDDhSdan9sTppRVeDNuPiR8WX=P4Umdbq=ELafqw@mail.gmail.com> <20151113230933.GA16173@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Fredrik Medley <fredrik.medley@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 16 17:01:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyMDh-0007no-E9
	for gcvg-git-2@plane.gmane.org; Mon, 16 Nov 2015 17:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbbKPQBX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 11:01:23 -0500
Received: from mout.gmx.net ([212.227.15.15]:64803 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752259AbbKPQBV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 11:01:21 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx003) with ESMTPSA (Nemesis) id 0MHHdb-1aBmUd2vQJ-00E5DF;
 Mon, 16 Nov 2015 17:01:04 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <20151113230933.GA16173@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:Y4i5RgrMeKlOY/SMh0S9J9iHrR1VYKrjp5CGbe+NcFm4KU03yxI
 OTGiECI6XBqon4AWuBe1xdv9kQSPf5w171k1hkVNYk5vRjyUt+bEv8Hv17JpTjYipxMyjGT
 Ro9DPBE9Tf2qpQwImogIBkrlwivsy32cI6cn/HQaPOFj/66ar2gSAkaQe6zvhS9/4m2GykI
 BPZFRGEjjXCduHdf0M0iQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:98MNuDSGGdY=:AcMkx6eS8azECin1ajm/nD
 W5LMlgjyVaN6kyiUpDimobL0DuqOmWNmdJUpbkPZJTAlmQL50zPUAaPMzzNNdiK1Jqf0Votda
 3Kd3owOiPedk1iEN2IqJ7yM9HHu7Mr0nYHzilk0l/sOlACynQgumwAtCS3o5Ej6/qwzuU9wig
 cReunp8S4aie9TE2LdBf753D421g3ht+ypFbWxY4WTwNWrdFdgAaif73fdWZ+lw2k7lcI/o8o
 qBOKuhmqaszm8rbaj1qHrLa5sMDRpf2cFSoWdD/QtphxEWDTsxdFS1YOx1IV9lBs8+njDJlL9
 ryXiQhlN1XZMpJupodPY5sdz52qsZVIQ4zqNfRhtUrtf/VZuDibqkvAY0dhuIQeM8wDlJyoO5
 knOtPXO27NzCIbTselEn4VfQ0/HoNH+4m5jOnG+eHEIjgyyNelNyrhB8SwdRKPcaDML4urYTo
 ojaUV19ztKLM3wrBJxs1tlqU/v2H3XxguDGp6i3OIzQ8SlpRjwOIbSRcWjDkAaQlZL009qc8n
 I7vFxIrrSKDArndgN0bbZn55XrFEAHnupBq8J7V5BglrzTVX6xvrV60iFO2dRByBXAmhkDC6P
 GLydfrUnaFRcwujTPCca0ad4Pp2mlOeuBHGA4jF7U5Psn8kbGBTzX7ImgNAbvL5Ao8oLOwMfD
 +2OC0Pamcit+j5XHxIQpArqfQFPfIKKtjUMZDJR1PZJEqe2aa7+srgHgYBZhRbdVsaFW16Uqg
 cB3zluBOKBUEUZ+1sD2pxxskOD+7ksfzRvwRFr+GxyLyqnPUonYRe7xCRBq2/OmBPmxkB1u/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281346>

Hi Peff,

On Fri, 13 Nov 2015, Jeff King wrote:

> It's possible somebody could be doing something clever with $SHELL, but
> I kind of doubt it. If they want to do something clever, it is much
> easier to put it directly on the exec line, and have the normal $SHELL
> run their clever thing.

To clarify the Git for Windows scenario: SHELL_PATH is indeed set to
`/bin/sh`, but reportedly it is converted into a full Windows path when we
leave the POSIX emulation layer, i.e. when `git.exe` is called (which has
*no* idea about POSIX paths, or at least next to none).

The reason is, of course, that regular Windows programs would not know
what to do with the path /bin/sh.

The problem arises when we re-enter the POSIX realm, i.e. when we run a
script (such as `git-rebase`): the path is not converted back!

There are already tickets on Git for Windows' bug tracker where the case
is made that vim has serious problems with that space in the environment
variable, so the long-term fix is really to teach the POSIX emulation
layer (read: MSys2) to convert SHELL_PATH back into a POSIX path when
appropriate.

This is on my plate, but there are quite a couple more urgent tasks I need
to take care of, so please do not hold your breath (unless you are into
that kind of thing).

Ciao,
Dscho
