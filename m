From: Heikki Orsila <shdl@zakalwe.fi>
Subject: Re: [PATCH] Add two core.sharedRepository options: group-readable and world-readable
Date: Sat, 12 Apr 2008 15:05:12 +0300
Message-ID: <20080412120512.GD31039@zakalwe.fi>
References: <20080411140916.GA30667@zakalwe.fi> <7vfxtrnban.fsf@gitster.siamese.dyndns.org> <20080412030021.GB31039@zakalwe.fi> <7vzlrzlluj.fsf@gitster.siamese.dyndns.org> <20080412120159.GC31039@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 14:06:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkeUZ-0002Pj-0l
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 14:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757886AbYDLMFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 08:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757976AbYDLMFO
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 08:05:14 -0400
Received: from zakalwe.fi ([80.83.5.154]:46263 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757790AbYDLMFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 08:05:14 -0400
Received: by zakalwe.fi (Postfix, from userid 1023)
	id D42922C331; Sat, 12 Apr 2008 15:05:12 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080412120159.GC31039@zakalwe.fi>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79349>

On Sat, Apr 12, 2008 at 03:01:59PM +0300, Heikki Orsila wrote:
> You're correct. There are two options, do you have a preference on this 
> matter?
> 
> 1. current method + mask off others when needed
> 
> 2. core.sharedRepository=0xxx
> 
> I think I like option 2 better (preserving backwards compatibility of 
> course).

Okay, based on your later email. I think I will implement option 2.

-- 
Heikki Orsila			Barbie's law:
heikki.orsila@iki.fi		"Math is hard, let's go shopping!"
http://www.iki.fi/shd
