From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: FW: [cygwin] Cygwin's git says "error: failed to read delta-pack base object"
Date: Thu, 4 Dec 2014 16:34:03 -0500
Organization: PD Inc
Message-ID: <F5D60A90C93A45359EF00CC200C81561@black>
References: <64C98FC352BD45EC9632202946A081E1@black> <20141204005443.GB200195@vauxhall.crustytoothpaste.net>
Reply-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	  <git@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 04 22:34:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwe2R-0004xW-40
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 22:34:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933207AbaLDVeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 16:34:11 -0500
Received: from mail.pdinc.us ([67.90.184.27]:60632 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932094AbaLDVeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Dec 2014 16:34:09 -0500
Received: from black (five-58.pdinc.us [192.168.5.58])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id sB4LY3CC009130;
	Thu, 4 Dec 2014 16:34:04 -0500
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <20141204005443.GB200195@vauxhall.crustytoothpaste.net>
Thread-Index: AdAPXRtpqnFJ0p5ySsSWNqpxnc3bEwArKJ3g
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260806>

> -----Original Message-----
> From: brian m. carlson
> Sent: Wednesday, December 03, 2014 19:55
> 
> On Wed, Dec 03, 2014 at 06:31:18PM -0500, Jason Pyeron wrote:
> > I remember hitting this a while ago, but just gave up.
> > 
> > It seems to be a problem for others too.
> > 
> > Any ideas on how to debug this so it can be patched?
> > 
> > -----Original Message-----
> > From: Dave Lindbergh
> > Sent: Wednesday, December 03, 2014 18:07
> > To: cygwin
> > 
> > Aha - you're right.
> > 
> > It works fine on a local NTFS volume.
> > 
> > I get the error when I do it on Z:, which is mapped to a 
> network drive
> > (on another Windows box).
> > 
> > Is there a workaround? Why does this happen?
> 
> I don't think anyone is sure.  My wild guess is that there's something
> about the way that Cygwin wraps Windows calls that makes it 
> fail in this
> case.  It might be interesting to run the Windows and Cygwin versions
> under an strace equivalent and see where things differ.

[this was posted to the cygwin list]

http://nerdfever.com/files/strace.txt

> 
> It's an interesting problem, but I don't have any Windows 
> systems, so I
> can't look into it.

If it becomes a little less magic, I will chomp on the problem, but I cannot make a predictable test case.

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00. 
