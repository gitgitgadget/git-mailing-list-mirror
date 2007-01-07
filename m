From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 20:07:43 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0701072004290.4365@yvahk01.tjqt.qr>
References: <458434B0.4090506@oracle.com> <1166297434.26330.34.camel@localhost.localdomain>
 <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com>
 <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com>
 <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>
 <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com>
 <20070107090336.GA7741@1wt.eu> <Pine.LNX.4.61.0701071141580.4365@yvahk01.tjqt.qr>
 <20070107104943.ee2c5e6f.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964971AbXAGTWK@vger.kernel.org Sun Jan 07 20:23:00 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964971AbXAGTWK@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3dbK-0005pU-0n
	for glk-linux-kernel-3@gmane.org; Sun, 07 Jan 2007 20:22:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964971AbXAGTWK (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Jan 2007 14:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964960AbXAGTWJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 14:22:09 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:43384 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964956AbXAGTWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 14:22:06 -0500
Received: from linux01.gwdg.de ([134.76.13.21])
	by mailer.gwdg.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <jengelh@linux01.gwdg.de>)
	id 1H3daD-000159-Fd; Sun, 07 Jan 2007 20:21:30 +0100
Received: from linux01.gwdg.de (localhost [127.0.0.1])
	by linux01.gwdg.de (8.13.3/8.13.3/SuSE Linux 0.7) with ESMTP id l07J7iJ6026285;
	Sun, 7 Jan 2007 20:07:46 +0100
Received: from localhost (jengelh@localhost)
	by linux01.gwdg.de (8.13.3/8.13.3/Submit) with ESMTP id l07J7hwA026279;
	Sun, 7 Jan 2007 20:07:43 +0100
To: Randy Dunlap <randy.dunlap@oracle.com>
In-Reply-To: <20070107104943.ee2c5e6f.randy.dunlap@oracle.com>
X-Spam-Level: /
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
X-Virus-Scanned: (clean) by exiscan+sophie
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36188>


On Jan 7 2007 10:49, Randy Dunlap wrote:
>On Sun, 7 Jan 2007 11:50:57 +0100 (MET) Jan Engelhardt wrote:
>> On Jan 7 2007 10:03, Willy Tarreau wrote:
>> >On Sun, Jan 07, 2007 at 12:58:38AM -0800, H. Peter Anvin wrote:
>> >> >[..]
>> >> >entries in directories with millions of files on disk. I'm not
>> >> >certain it would be that easy to try other filesystems on
>> >> >kernel.org though :-/
>> >> 
>> >> Changing filesystems would mean about a week of downtime for a server. 
>> >> It's painful, but it's doable; however, if we get a traffic spike during 
>> >> that time it'll hurt like hell.
>> 
>> Then make sure noone releases a kernel ;-)
>
>maybe the week of LCA ?

I don't know that acronym, but if you ask me when it should happen:
_Before_ the next big thing is released, e.g. before 2.6.20-final.
Reason: You never know how long they're chewing [downloading] on 2.6.20.
Excluding other projects on kernel.org from my hypothesis, I'd suppose the
lowest bandwidth usage the longer no new files have been released. (Because
everyone has them then more or less.)


	-`J'
-- 
