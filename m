From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 21:35:42 +0100
Message-ID: <85prvu6hnl.fsf@lola.goethe.zz>
References: <478E1FED.5010801@web.de>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	<B45968C6-3029-48B6-BED2-E7D5A88747F7@sb.org>
	<alpine.LFD.1.00.0801161707150.2806@woody.linux-foundation.org>
	<8AC4CC86-A711-483D-9F9C-5F8497006A1D@sb.org>
	<alpine.LFD.1.00.0801161959210.2806@woody.linux-foundation.org>
	<B719D4A2-0D05-4C55-95FC-AB880D58E1AC@wincent.com>
	<alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org>
	<478F99E7.1050503@web.de>
	<alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	<F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	<alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	<alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se>
	<440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801211
	151180.20753@xanadu.home>
	<AE99FDAA-F8D3-49F7-A0B9-CDFCC4903824@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:06:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7ak-0001g9-Ao
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352AbYAVBFo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYAVBFo
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:05:44 -0500
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:57763 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757304AbYAVBFj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 20:05:39 -0500
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 6E54B18769E;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 60C3A2D37DB;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-102-235.pools.arcor-ip.net [84.61.102.235])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 3F15E1FB024;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id AA4561C3D4E5; Mon, 21 Jan 2008 21:35:42 +0100 (CET)
In-Reply-To: <AE99FDAA-F8D3-49F7-A0B9-CDFCC4903824@sb.org> (Kevin Ballard's
	message of "Mon, 21 Jan 2008 12:25:52 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5515/Tue Jan 22 00:03:56 2008 on mail-in-05.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71384>

Kevin Ballard <kevin@sb.org> writes:

> I agree, Linus's approach is indeed fast. And if speed is more
> important than treating filenames as text instead of octets, then so
> be it. This is a trade-off. But a trade-off doesn't mean one approach
> is "wrong", it just means the authors of HFS+ thought it was an
> acceptable trade-off. HFS+ wasn't designed to be a high-performance
> filesystem that deals with lots of files, it was designed to be a
> filesystem used by regular people on the Mac, and I believe treating
> filenames as text is a good choice in this scenario.

Regular people have brains, not filesystems.  HFS+ is employed by
computers, and computers can produce or query or process lots of data in
very short time spans, in their own pace.  And if Mac users did not want
to make use of that, they would still be using Mac classics.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
