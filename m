X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: On removing files and "git-rm is pointless"
Date: Sat, 02 Dec 2006 22:50:46 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612022246310.2630@xanadu.home>
References: <87odqm2ppv.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0612020919400.3476@woody.osdl.org> <4571DB40.6020800@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Sun, 3 Dec 2006 03:51:04 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <4571DB40.6020800@vilain.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33090>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqiNS-0000ef-Vw for gcvg-git@gmane.org; Sun, 03 Dec
 2006 04:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936651AbWLCDut (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 22:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936652AbWLCDus
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 22:50:48 -0500
Received: from relais.videotron.ca ([24.201.245.36]:23528 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S936651AbWLCDus (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 22:50:48 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9O001NTIONXH20@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Sat,
 02 Dec 2006 22:50:47 -0500 (EST)
To: Sam Vilain <sam@vilain.net>
Sender: git-owner@vger.kernel.org

On Sun, 3 Dec 2006, Sam Vilain wrote:

> Linus Torvalds wrote:
> > I'd like it more if it defaulted to actually removing the file, preferably 
> > refusing to with an error message if the file didn't match the index. 
> 
> index, or HEAD version?  Otherwise you can "update-index"; "rm" without
> seeing something wrong is happening.

Well tough then.

I think what Linus is proposing makes tons of sense.

If you do git rm by mistake then you can always do git checkout on that 
file to get it back.

If you modified it so it doesn't match the index then git rm won't do 
anything by default so you have a chance to think a bit more.

If you updated the index, didn't commit anything but then do git rm then 
you certainly wanted to really rm the file.

If not then just feel the pain of your stupidity and start again from 
the latest version.


