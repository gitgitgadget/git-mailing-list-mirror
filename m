From: David Kastrup <dak@gnu.org>
Subject: Re: Mergetool generating blank files (1.5.3)
Date: Fri, 28 Sep 2007 08:19:42 +0200
Message-ID: <85tzpfb9c1.fsf@lola.goethe.zz>
References: <94ccbe710709271312k7eac8e35y353180596a0abc9a@mail.gmail.com>
	<94ccbe710709271338u79ba89beh5a637bf84f8edf44@mail.gmail.com>
	<7v8x6ru97z.fsf@gitster.siamese.dyndns.org>
	<7vwsubsuh1.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271417h6349c807j6424c25175c26ea2@mail.gmail.com>
	<94ccbe710709271422x5d1739c2g5da961c88a4336fe@mail.gmail.com>
	<7vmyv7sshv.fsf@gitster.siamese.dyndns.org>
	<7vir5vss58.fsf@gitster.siamese.dyndns.org>
	<94ccbe710709271523s7e4c7a1dh53e34bd460c31d1f@mail.gmail.com>
	<20070927225218.GD8688@thunk.org>
	<94ccbe710709272117s6dee1a8jad6edf71dfb13c81@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Tso" <tytso@mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Kelvie Wong" <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Fri Sep 28 08:20:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib9Ch-0002lM-BN
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 08:19:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758690AbXI1GTy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 02:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbXI1GTy
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 02:19:54 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:54031 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758679AbXI1GTx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Sep 2007 02:19:53 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id BB53844E70;
	Fri, 28 Sep 2007 08:19:50 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id A24A7345CB6;
	Fri, 28 Sep 2007 08:19:50 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-013-147.pools.arcor-ip.net [84.61.13.147])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 5464422D167;
	Fri, 28 Sep 2007 08:19:42 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B1B6A1C0039C; Fri, 28 Sep 2007 08:19:42 +0200 (CEST)
In-Reply-To: <94ccbe710709272117s6dee1a8jad6edf71dfb13c81@mail.gmail.com> (Kelvie Wong's message of "Thu\, 27 Sep 2007 21\:17\:26 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4417/Fri Sep 28 06:57:11 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59369>

"Kelvie Wong" <kelvie@ieee.org> writes:

> On 9/27/07, Theodore Tso <tytso@mit.edu> wrote:
>
>> It's not that emacs sets $PWD via its first argument, but the output
>> file is passed from emerge-files*-command to stashed in the per-buffer
>> variable emerge-file-out, which in turn gets passed to the emacs lisp
>> file write-file, which is what gets run when you run C-x C-w --- and
>> write-file interprets a relative pathname based on the containing
>> directory of the existing buffer.
>>                                                 - Ted
>>
>
> Ah yes, I just started reading up on elisp a little while ago :)
>
> I'd always assumed that emacs kept an internal "pwd" variable (i.e.
> what's displayed with M-x pwd), but I guess my way of thinking is
> archaic and deprecated :(

It does.  For every buffer.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
