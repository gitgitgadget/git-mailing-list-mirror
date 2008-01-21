From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 22:05:51 +0100
Message-ID: <85abmy6g9c.fsf@lola.goethe.zz>
References: <478F99E7.1050503@web.de>
	<alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org>
	<F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	<alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	<alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	<Pine.LNX.4.64.0801211509490.17095@ds9.cixit.se>
	<440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	<86r6gbi0pr.fsf@lola.quinscape.zz>
	<CFF9E74C-4A4C-4E5F-8DA3-662D80095503@sb.org>
	<20080121204330.GX14871@dpotapov.dyndns.org>
	<A101AC54-F0CF-4C33-8986-CC6B8DD7F17F@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Tue Jan 22 02:06:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH7an-0001g9-0J
	for gcvg-git-2@gmane.org; Tue, 22 Jan 2008 02:06:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757495AbYAVBFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 20:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757342AbYAVBFw
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 20:05:52 -0500
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:60268 "EHLO
	mail-in-01.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757316AbYAVBFk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 20:05:40 -0500
Received: from mail-in-05-z2.arcor-online.net (mail-in-05-z2.arcor-online.net [151.189.8.17])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id CB103103AC3;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net [151.189.21.42])
	by mail-in-05-z2.arcor-online.net (Postfix) with ESMTP id BB9AB2DABFF;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-102-235.pools.arcor-ip.net [84.61.102.235])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9B30727ECA;
	Tue, 22 Jan 2008 02:05:38 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2E9ED1C3AD5A; Mon, 21 Jan 2008 22:05:51 +0100 (CET)
In-Reply-To: <A101AC54-F0CF-4C33-8986-CC6B8DD7F17F@sb.org> (Kevin Ballard's
	message of "Mon, 21 Jan 2008 15:53:10 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5515/Tue Jan 22 00:03:56 2008 on mail-in-02.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71387>

Kevin Ballard <kevin@sb.org> writes:

> On Jan 21, 2008, at 3:43 PM, Dmitry Potapov wrote:
>
>> On Mon, Jan 21, 2008 at 11:59:24AM -0500, Kevin Ballard wrote:
>>>
>>> No, it's a question of hashing algorithm. And it's one that's fairl=
y
>>> easily solved simply by picking a specific nonambiguous UTF-8
>>> encoding before hashing.
>>
>> UTF-8 is a *single* encoding, and it maps every Unicode character to
>> a unique binary representation. So, it is completely nonambiguous.
>
> In this case, encoding refers to normalization form, as other people
> have used it in the conversation besides me.

There exists more than one "normalization form" (even across MacOS
platforms), and git is cross-platform.  And people can't be made to
agree on normalization forms, anyway.  You are aware that Unicode code
points are shared between some Chinese and Japanese signs, and that
stroked forms might be composed differently in different languages?  We
don't need to go to the Far East, anyway: in Turkish, =C4=B0 and i are
equivalent, as are I and =C4=B1, whereas in other European languages, I=
 is
instead equivalent to i.  In the Netherlands, =C3=BF is IIRC equivalent=
 to
ij.  And so on.

> I suggest you stop trying to find inconsequential stuff to argue
> about, especially when a tiny bit of critical thinking would reveal
> the answer.

Now that you have established that you are the only person on the list
capable of critical thinking, how about going elsewhere where you can
find similarly sharp critical thinkers?

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
