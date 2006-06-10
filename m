From: Nicolas Pitre <nico@cam.org>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 11:14:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0606101113130.2703@localhost.localdomain>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
 <46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
 <Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
 <Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
 <9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
 <Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
 <9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
 <87y7w5lowc.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0606092001590.5498@g5.osdl.org> <448A847C.20105@dawes.za.net>
 <7vzmglgyz0.fsf@assigned-by-dhcp.cox.net> <448ADB8A.3070506@dawes.za.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 17:14:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fp5Ar-0007Ae-Az
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 17:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWFJPOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 11:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWFJPOn
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 11:14:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39057 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751526AbWFJPOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 11:14:43 -0400
Received: from xanadu.home ([74.56.108.184]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J0N00HVPH0I9510@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 10 Jun 2006 11:14:42 -0400 (EDT)
In-reply-to: <448ADB8A.3070506@dawes.za.net>
X-X-Sender: nico@localhost.localdomain
To: Rogan Dawes <discard@dawes.za.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21609>

On Sat, 10 Jun 2006, Rogan Dawes wrote:

> Out of curiosity, do you think that it may be possible for tree objects to
> compress more/better if they are packed together? Or does the existing pack
> compression logic already do the diff against similar tree objects?

Tree objects for the same directories are already packed and deltified 
against each other in a pack.


Nicolas
