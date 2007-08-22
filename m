From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 11:02:52 -0400
Message-ID: <20070822150252.GA10531@pe.Belkin>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz> <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz> <20070822144943.GA25527@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 17:03:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INrjY-0006Dx-6N
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 17:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762439AbXHVPCz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 11:02:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762110AbXHVPCz
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 11:02:55 -0400
Received: from eastrmmtao102.cox.net ([68.230.240.8]:41937 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761598AbXHVPCy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 11:02:54 -0400
Received: from eastrmimpo02.cox.net ([68.1.16.120])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070822150253.SEDD19980.eastrmmtao102.cox.net@eastrmimpo02.cox.net>;
          Wed, 22 Aug 2007 11:02:53 -0400
Received: from localhost ([68.0.253.29])
	by eastrmimpo02.cox.net with bizsmtp
	id f32s1X00d0epFYL0000000; Wed, 22 Aug 2007 11:02:53 -0400
Received: from chris by localhost with local (Exim 4.66)
	(envelope-from <c.shoemaker@cox.net>)
	id 1INrjQ-0002kC-Tl; Wed, 22 Aug 2007 11:02:52 -0400
Content-Disposition: inline
In-Reply-To: <20070822144943.GA25527@glandium.org>
User-Agent: Mutt/1.5.14 (2007-02-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56388>

On Wed, Aug 22, 2007 at 04:49:43PM +0200, Mike Hommey wrote:
> On Wed, Aug 22, 2007 at 04:29:43PM +0200, David Kastrup <dak@gnu.org> wrote:
> > The problem I see is that C sucks really really bad as a scripting
> > language, and tying together plumbing functionality into porcelain is
> > one of the most powerful, flexible and hack-friendly features of git.
> > Deprecating scripts is making git more opaque.
> (...)
> 
> Having tools being implemented in C rather than shell won't remove the
> tools for you to be able to write scripts and do your plumbing. It might
> remove some examples for you to write your plumbing, though.

Actually, the scripts are being moved into contrib/examples for this
reason, so, they're still available.

-chris
