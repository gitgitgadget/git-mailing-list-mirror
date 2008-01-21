From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Tue, 22 Jan 2008 10:17:45 +1300
Message-ID: <46a038f90801211317v4902ffd3ic8ccc35f8df72bd9@mail.gmail.com>
References: <478E1FED.5010801@web.de>
	 <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
	 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org>
	 <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se>
	 <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org>
	 <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
	 <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org>
	 <373E260A-6786-4932-956A-68706AA7C469@sb.org>
	 <alpine.LFD.1.00.0801211210270.2957@woody.linux-foundation.org>
	 <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Peter Karlsson" <peter@softwolves.pp.se>,
	"Mark Junker" <mjscod@web.de>,
	"Pedro Melo" <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Kevin Ballard" <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 22:19:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH437-0007em-54
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 22:19:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758949AbYAUVRt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jan 2008 16:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757498AbYAUVRs
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 16:17:48 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:51868 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757176AbYAUVRr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 16:17:47 -0500
Received: by ug-out-1314.google.com with SMTP id z38so955668ugc.16
        for <git@vger.kernel.org>; Mon, 21 Jan 2008 13:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7Ek1ye0VsBHMnO6a9McbZ/xfFe+UqMcp8Wiq1EesqWk=;
        b=RGmzKupJMe7j7CN/8403pALumhIcXlkMryywsKmSPrrkRAOKOaaa/QQoHdz30EaXm/zeMQswu/S8iTuuB0yYDhgGC+b8jZFo0tmeduAZ49NZdO6wHukdQolDT60WlAsU4zy9hby0qUFIqndetzvvC4w437nMnAndwv8kMrgRIxk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fbqisyu2/RhgnNxHB487oX6/WOpGtHDNU6vstIhSWzMkp4nDJpvvQmO7dhRUkt75Zaft1irjly40f1ohEwIaIXyZCzxvAbVrHpUXoBA9UWqfKiK0V5SJY+pqiAm1iDip6bDdHD6F9xsitrm4Wsiu/uW8jW0VBqVsEDs1kygajvc=
Received: by 10.66.219.11 with SMTP id r11mr5295015ugg.31.1200950265373;
        Mon, 21 Jan 2008 13:17:45 -0800 (PST)
Received: by 10.66.252.2 with HTTP; Mon, 21 Jan 2008 13:17:45 -0800 (PST)
In-Reply-To: <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71343>

On Jan 22, 2008 9:53 AM, Kevin Ballard <kevin@sb.org> wrote:
> On Jan 21, 2008, at 3:33 PM, Linus Torvalds wrote:
> > Umm. What's this inability to see that data is data is data?
>
> I'm not sure what you mean. I stated a fact - at least on OS X, the
> filename does not contribute to the listed filesize, so changing the
> encoding of the filename doesn't change the filesize. This isn't a
> philosophical point, it's a factual statement.

Kevin,

as you might know, Linus' "other hobby" is to write kernels ;-) From
taht POV, a filename is as much data as the data in the file. Doing
odd things like sorting it, searching through it, etc, is all work for
code higher in the stack that is free to mangle the data in any way it
wants, including creating nice case-insensitive indexes, and
who-knows-what for ideogram-based languages. In contrast, the core OS
treats user data a sacred stuff, and I'm thankful it does.

And from a kernel/filesystem POV, a directory is also a file. So if a
filename has a different number of octets, the directory will be
different.

=46or all the searching and matching, it really makes sense to have
something like locate or SpotLight or whatever to index user files
that should be easy to find and match, because all the locale rules
for matching are hideously expensive to apply. Even today, most UTF-8
aware (and supposedly collation-smart) applications have trouble
matching MART=CDN when asked for mart=EDn in a case-insensitive search.
That pesky latin =ED trips them up everytime.

cheers,


martin
