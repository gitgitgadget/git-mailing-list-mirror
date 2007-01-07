From: Rene Herman <rene.herman@gmail.com>
Subject: Re: How git affects kernel.org performance
Date: Sun, 07 Jan 2007 10:38:20 +0100
Message-ID: <45A0BF8C.4040508@gmail.com>
References: <20061216094421.416a271e.randy.dunlap@oracle.com>	<20061216095702.3e6f1d1f.akpm@osdl.org>	<458434B0.4090506@oracle.com>	<1166297434.26330.34.camel@localhost.localdomain>	<1166304080.13548.8.camel@nigel.suspend2.net>	<459152B1.9040106@zytor.com>	<1168140954.2153.1.camel@nigel.suspend2.net>	<45A08269.4050504@zytor.com>	<45A083F2.5000000@zytor.com>	<Pine.LNX.4.64.0701062130260.3661@woody.osdl.org>	<20070107085526.GR24090@1wt.eu> <20070107011542.3496bc76.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Willy Tarreau <w@1wt.eu>, Linus Torvalds <torvalds@osdl.org>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932460AbXAGJkA@vger.kernel.org Sun Jan 07 10:40:35 2007
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932460AbXAGJkA@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3UW1-0003S6-8p
	for glk-linux-kernel-3@gmane.org; Sun, 07 Jan 2007 10:40:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932460AbXAGJkA (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 7 Jan 2007 04:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbXAGJkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 04:40:00 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:52344 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932460AbXAGJj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 04:39:59 -0500
Received: from [213.51.146.189] (port=41265 helo=smtp2.tilbu1.nb.home.nl)
	by smtpq1.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1H3UVM-0007Du-Nf; Sun, 07 Jan 2007 10:39:52 +0100
Received: from cc334381-b.groni1.gr.home.nl ([82.73.14.214]:47088 helo=[192.168.0.3])
	by smtp2.tilbu1.nb.home.nl with esmtp (Exim 4.30)
	id 1H3UVK-0008Bl-6c; Sun, 07 Jan 2007 10:39:50 +0100
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20070107011542.3496bc76.akpm@osdl.org>
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36145>

On 01/07/2007 10:15 AM, Andrew Morton wrote:

> Yeah, slowly-growing directories will get splattered all over the
> disk.
> 
> Possible short-term fixes would be to just allocate up to (say) eight
>  blocks when we grow a directory by one block.  Or teach the 
> directory-growth code to use ext3 reservations.
> 
> Longer-term people are talking about things like on-disk
> rerservations. But I expect directories are being forgotten about in
> all of that.

I wish people would just talk about de2fsrag... ;-\

Rene
