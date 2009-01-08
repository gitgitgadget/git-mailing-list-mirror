From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
	that are corrupted in a pack file
Date: Wed, 7 Jan 2009 19:13:14 -0800
Message-ID: <20090108031314.GG10790@spearce.org>
References: <1231292360.8870.61.camel@starfruit> <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain> <1231314099.8870.415.camel@starfruit> <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain> <1231368935.8870.584.camel@starfruit> <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain> <1231374514.8870.621.camel@starfruit> <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain> <20090108030115.GF10790@spearce.org> <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "R. Tyler Ballance" <tyler@slide.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?iso-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 04:14:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKlLy-00014C-U2
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 04:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752220AbZAHDNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 22:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbZAHDNP
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 22:13:15 -0500
Received: from george.spearce.org ([209.20.77.23]:50866 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751755AbZAHDNP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 22:13:15 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 4389038210; Thu,  8 Jan 2009 03:13:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104883>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> The Z_STREAM_ERROR probably comes from inflate() itself - and could very 
> easily be due to a allocation error in inflateInit leaving the stream data 
> incomplete.
> 
> Let me try wrapping that dang thing and send a patch. 

Yup.  I'm actually doing the same thing...

-- 
Shawn.
