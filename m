From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 22:09:31 +0100
Message-ID: <8563xm6g38.fsf@lola.goethe.zz>
References: <478E1FED.5010801@web.de>
	<alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
	<478F99E7.1050503@web.de>
	<alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	<F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	<alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	<alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	<440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	<alpine.LFD.1.00.0801210934400.2957@woody.linux-foundation.org>
	<46a038f90801211306g3dd9a167wb74d06e444b18b93@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Kevin Ballard" <kevin@sb.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:06:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7am-0001g9-9z
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:06:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757450AbYAVBFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:05:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYAVBFu
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:05:50 -0500
Received: from mail-in-16.arcor-online.net ([151.189.21.56]:52925 "EHLO
	mail-in-16.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757315AbYAVBFk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 20:05:40 -0500
Received: from mail-in-04-z2.arcor-online.net (mail-in-04-z2.arcor-online.net [151.189.8.16])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id CB9871A7263;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-04-z2.arcor-online.net (Postfix) with ESMTP id B8D39ABC7E;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-102-235.pools.arcor-ip.net [84.61.102.235])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 8D24427EC5;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id ABA121C3AD5B; Mon, 21 Jan 2008 22:09:31 +0100 (CET)
In-Reply-To: <46a038f90801211306g3dd9a167wb74d06e444b18b93@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 22 Jan 2008 10:06:05 +1300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5515/Tue Jan 22 00:03:56 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71389>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> (slightly offtopic) are you praising UTF-8 as storage format (for disk
> and network) or in general? UTF-8-aware string ops like counting
> characters seem to me a horrendous thing at the ASM level.

Huh?  Why?  Just count all characters in the range 00-bf.  That's the
exact character count of utf-8 characters.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
