X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 14:21:19 +0100
Message-ID: <20061116132119.GH5453@diana.vm.bytemark.co.uk>
References: <87k61yt1x2.wl%cworth@cworth.org> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home> <200611150917.23756.andyparkins@gmail.com> <Pine.LNX.4.64.0611151023160.2591@xanadu.home> <7vfyckoaju.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611151309290.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 16 Nov 2006 13:22:46 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611151309290.2591@xanadu.home>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31581>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkhC7-0005dh-Sn for gcvg-git@gmane.org; Thu, 16 Nov
 2006 14:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424039AbWKPNWH convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006 08:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424041AbWKPNWH
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 08:22:07 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:54790 "EHLO
 diana.vm.bytemark.co.uk") by vger.kernel.org with ESMTP id S1424039AbWKPNWE
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 08:22:04 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1
 (Debian)) id 1GkhB9-0004ji-00; Thu, 16 Nov 2006 13:21:19 +0000
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

On 2006-11-15 13:11:36 -0500, Nicolas Pitre wrote:

> On Wed, 15 Nov 2006, Junio C Hamano wrote:
>
> > Nicolas Pitre <nico@cam.org> writes:
> >
> > > But again I think it is important that the URL to use must be a
> > > per branch attribute i.e. attached to "default/master" and not
> > > just "default". This way someone could add all branches of
> > > interest into the "default" group even if they're from different
> > > repositories, and a simple get without any argument would get
> > > them all.
> >
> > I think the "one group per one remote repository" model is a lot
> > easier to explain. At least when I read your first "branch group"
> > proposal that was I thought was going on and I found it quite
> > sensible (and it maps more or less straightforwardly to the way
> > existing .git/refs/remotes is set up by default).
>
> I think one group per remote repo is how things should be by default
> too. But we should not limit it to that if possible.

Without the limitation, we risk name collisions when getting all
branches from the remote repository (that is, including any new
branches we previously didn't know about).

--=20
Karl Hasselstr=F6m, kha@treskal.com
