X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] send-pack --keep: do not explode into loose objects on the
 receiving end.
Date: Sun, 29 Oct 2006 20:44:02 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610292027160.11384@xanadu.home>
References: <Pine.LNX.4.64.0610252333540.12418@xanadu.home>
 <7vwt6j4l77.fsf@assigned-by-dhcp.cox.net> <20061029075638.GB3847@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 01:54:04 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061029075638.GB3847@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30480>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeMCC-0002Cy-MU for gcvg-git@gmane.org; Mon, 30 Oct
 2006 02:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030482AbWJ3BoF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 20:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030483AbWJ3BoF
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 20:44:05 -0500
Received: from relais.videotron.ca ([24.201.245.36]:44794 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030482AbWJ3BoD
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 20:44:03 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7X00021E5EO6C0@VL-MO-MR004.ip.videotron.ca> for git@vger.kernel.org; Sun,
 29 Oct 2006 20:44:02 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Sun, 29 Oct 2006, Shawn Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > This adds "keep-pack" extension to send-pack vs receive pack protocol,
> > and makes the receiver invoke "index-pack --stdin --fix-thin".
> 
> I'm torn on this.  I see that keeping a pack vs. exploding to loose
> objects is a local repository decision and thus should be determined
> by the receiving repository, not the sending one.

I second this.  I think it is really not the remote end's business to 
decide what the local storage policy is, and vice versa.


