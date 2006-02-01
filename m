From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [Announce] gitview-0.1
Date: Wed, 1 Feb 2006 21:58:05 +0100
Message-ID: <20060201205805.GA6384@steel.home>
References: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 21:59:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4P3Y-0004Ll-Bb
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 21:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWBAU6P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 15:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWBAU6P
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 15:58:15 -0500
Received: from devrace.com ([198.63.210.113]:18955 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932463AbWBAU6P (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2006 15:58:15 -0500
Received: from tigra.home (p54A06D68.dip.t-dialin.net [84.160.109.104])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k11Kw8np099589;
	Wed, 1 Feb 2006 14:58:09 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F4P3G-0008PD-00; Wed, 01 Feb 2006 21:58:06 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F4P3F-0003tE-Sp; Wed, 01 Feb 2006 21:58:05 +0100
To: Aneesh Kumar <aneesh.kumar@gmail.com>
Content-Disposition: inline
In-Reply-To: <cc723f590601312016vabba201ye6d3739b3927f1a@mail.gmail.com>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=0.9 required=4.5 tests=AWL,RCVD_IN_NJABL_DUL 
	autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15446>

Aneesh Kumar, Wed, Feb 01, 2006 05:16:59 +0100:
> 
> Gnome based git repository browser. The code is derived from bazaar-ng
> repository browser.
> 
> To see how it looks
> 
> http://www.flickr.com/photos/17388011@N00/92918446/
> 
> I don't have a web location where i can host it so i am attaching it below.
> It would be great if we can get it added to git repository
> 
> sample usage
> takes same argument as git rev-list
> 
> gitview --since=2.week.ago
> 

Doesn't really work here: no tree like on your screenshot, and a lot
of messages like this:

(gitview:14905): GLib-GObject-WARNING **: IA__g_object_set_property: object clas
s `PyGtkGenericCellRenderer' has no property named `out-lines'

(gitview:14905): GLib-GObject-WARNING **: IA__g_object_set_property: object clas
s `PyGtkGenericCellRenderer' has no property named `in-lines'

(gitview:14905): GLib-GObject-WARNING **: IA__g_object_set_property: object clas
s `PyGtkGenericCellRenderer' has no property named `node'

(gitview:14905): GLib-GObject-WARNING **: IA__g_object_set_property: object clas
s `PyGtkGenericCellRenderer' has no property named `out-lines'

(gitview:14905): GLib-GObject-WARNING **: IA__g_object_set_property: object clas
s `PyGtkGenericCellRenderer' has no property named `in-lines'

(gitview:14905): GLib-GObject-WARNING **: IA__g_object_set_property: object clas
s `PyGtkGenericCellRenderer' has no property named `node'
Traceback (most recent call last):
  File "/home/raa/gitview", line 166, in on_render
    ctx = window.cairo_create()
AttributeError: 'gtk.gdk.Window' object has no attribute 'cairo_create'

Gentoo, Python 2.4.2, pycairo 1.0.2.
