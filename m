From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Mon, 01 Feb 2010 13:12:20 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1002011309020.1681@xanadu.home>
References: <31a97741002010352x1ad27f26ia4d51857bb2d2d4f@mail.gmail.com>
 <7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Steve Diver <squelch2@googlemail.com>,
	Mark Lodato <lodatom@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>, Ron1 <ron1@flownet.com>,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 19:13:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nc0l9-00017E-N3
	for gcvg-git-2@lo.gmane.org; Mon, 01 Feb 2010 19:12:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab0BASMW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2010 13:12:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:10235 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab0BASMV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2010 13:12:21 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0KX600CTJD8KVZS0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 01 Feb 2010 13:12:20 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vpr4o3lg9.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138637>

On Mon, 1 Feb 2010, Junio C Hamano wrote:

> I do not think we need yet another term "scratchpad" for this, but what is
> important is that both introductory and full documentation explain the
> detached HEAD well.
> 
> Currently we say:
> 
>     Detached HEAD
>     -------------
> 
>     It is sometimes useful to be able to 'checkout' a commit that is
>     not at the tip of one of your branches.  The most obvious
>     example is to check out the commit at a tagged official release
>     point, like this:
> 
>     ------------
>     $ git checkout v2.6.18
>     ------------
> 
>     Earlier versions of git did not allow this and asked you to
>     create a temporary branch using the `-b` option, but starting from
>     version 1.5.0, the above command 'detaches' your HEAD from the
>     current branch and directly points at the commit named by the tag
>     (`v2.6.18` in the example above).
> 
> If read carefully (some may argue that it does not need a very careful
> reading to get it, though), this hints that "detached HEAD" state is a
> substitute for using a temporary branch, but it may not be strong enough.
> 
> I thought that a documentation update in this area was already planned?

Jay Soffian (added to CC) agreed to augment the documentation with the 
comprehensive explanation he posted to the list lately.


Nicolas
