From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 08 Jul 2010 19:10:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007081909540.6020@xanadu.home>
References: <20100701121711.GF1333@thunk.org>
 <AANLkTikVNkObOxGQhDJ5Qau-vYn2YcomHQW2p2zsMof9@mail.gmail.com>
 <alpine.LFD.2.00.1007081559300.6020@xanadu.home>
 <201007082320.05017.jnareb@gmail.com>
 <AANLkTik3Cp8W5wrWhL7DW736QPt7-2V-E8EAWJB5JYd1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_D+gKY5/03232s76z3lBg/g)"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Theodore Tso <tytso@mit.edu>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 01:10:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX0Ev-0001JO-Vm
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 01:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758712Ab0GHXKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 19:10:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:59920 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756762Ab0GHXKk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 19:10:40 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L59003YNHPRB6A0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Jul 2010 19:10:40 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTik3Cp8W5wrWhL7DW736QPt7-2V-E8EAWJB5JYd1@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150618>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_D+gKY5/03232s76z3lBg/g)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Thu, 8 Jul 2010, Sverre Rabbelier wrote:

> Heya,
> 
> 2010/7/8 Jakub Narebski <jnareb@gmail.com>:
> > By the way, rev-cache project was started mainly to make "counting
> > objects" part of clone / fetch faster.  Would pack v4 offer the same
> > without rev-cache?
> 
> Speaking of pack v4 features...
> 
> I remember from GitTogether08 that one hope was that the metadata
> would be in a different file, such that it could be retrieved
> separately (allowing shallow clones to create and push new commits).
> Is this not something that is part of the design goals for packv4?

No.  And I don't see why a pack format change would need to be involved 
either.


Nicolas

--Boundary_(ID_D+gKY5/03232s76z3lBg/g)--
