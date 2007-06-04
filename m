From: Elvis Pranskevichus <elprans@gmail.com>
Subject: Re: [PATCH] Use git-tag in git-cvsimport
Date: Mon, 4 Jun 2007 19:55:52 -0400
Message-ID: <200706041955.52779.elprans@gmail.com>
References: <11808537962798-git-send-email-el@prans.net> <7v1wgto2mh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Jun 05 01:58:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvMQv-0003Q4-9Z
	for gcvg-git@gmane.org; Tue, 05 Jun 2007 01:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757672AbXFDX5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 19:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758962AbXFDX5u
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 19:57:50 -0400
Received: from prans.org ([209.59.209.223]:35283 "EHLO prans.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757672AbXFDX5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 19:57:49 -0400
Received: from cpe0015f287cf0c-cm0011e6ecad14.cpe.net.cable.rogers.com ([74.102.18.24] helo=[192.168.1.10])
	by prans.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <el@prans.net>)
	id 1HvMQn-00036e-DA; Mon, 04 Jun 2007 16:57:49 -0700
User-Agent: KMail/1.9.5
In-Reply-To: <7v1wgto2mh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49142>

> hoi :)

Hi =)

> On Sun, Jun 03, 2007 at 05:01:03PM -0700, Junio C Hamano wrote:
> > Martin Waitz <tali@admingilde.org> writes:
> > > but lightweight tags are not fetched by default.
> > 
> > Are you sure about that?

> not any more now that you questioned it ;-)

Last time I checked, unannotated tags are git-cloned and git-fetched just 
fine. I'm not sure about the exact definition and behaviour of lightweight 
tags, though. 

CVS just doesn't attach any valuable info to the tags, it's just a point in 
time.

> But at least there is a hook script which refuses to receive
> un-annotated tags and I always considered those tags to be temporary
> tags in the local repository.

Well, there's no mention about that in the docs. And I don't think that the 
notion of git losing valid objects along the way is the good one =)

Anyways, the patch wasn't about the tag type change. As I mentioned it's just 
a side effect. The main point is to fix the cvsimport tag breakage. I've 
tested that change on a few big (and messy) CVS repos, and it works just 
fine.

Cheers,
-- 

                 Elvis
