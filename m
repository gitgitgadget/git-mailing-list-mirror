From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 21:58:18 +0100
Message-ID: <85ejca6glx.fsf@lola.goethe.zz>
References: <478E1FED.5010801@web.de>
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
	<Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se>
	<440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org> <alpine.LFD.1.00.0801!
	210934400.2957@woody.linux-foundation.org>
	<C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08!
	01211129130.2957@woody.linux-foundation.org>
	<373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.0
	801211210270.2957@woody.linux-foundation.org>
	<7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:06:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7ak-0001g9-VX
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:06:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755195AbYAVBFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 20:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYAVBFq
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:05:46 -0500
Received: from mail-in-14.arcor-online.net ([151.189.21.54]:57760 "EHLO
	mail-in-14.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757193AbYAVBFj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 20:05:39 -0500
Received: from mail-in-19-z2.arcor-online.net (mail-in-19-z2.arcor-online.net [151.189.8.36])
	by mail-in-14.arcor-online.net (Postfix) with ESMTP id 3EA8A18760D;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-19-z2.arcor-online.net (Postfix) with ESMTP id 3371E6BD2A;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-102-235.pools.arcor-ip.net [84.61.102.235])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 13BBC28ABA2;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id F1DE41C3B796; Mon, 21 Jan 2008 21:58:18 +0100 (CET)
In-Reply-To: <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> (Kevin Ballard's
	message of "Mon, 21 Jan 2008 15:53:25 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5515/Tue Jan 22 00:03:56 2008 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71386>

Kevin Ballard <kevin@sb.org> writes:

> On Jan 21, 2008, at 3:33 PM, Linus Torvalds wrote:
>
>> On Mon, 21 Jan 2008, Kevin Ballard wrote:

>>> It does? Why on earth should it do that? Filename doesn't
>>> contribute to the
>>> listed filesize on OS X.
>>
>> Umm. What's this inability to see that data is data is data?
>
> I'm not sure what you mean. I stated a fact - at least on OS X, the
> filename does not contribute to the listed filesize, so changing the
> encoding of the filename doesn't change the filesize. This isn't a
> philosophical point, it's a factual statement.

Changing the encoding of the file name most certainly changes the
file size of the directory.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
