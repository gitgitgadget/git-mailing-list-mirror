From: david@lang.hm
Subject: Re: [RFC] format-patch stuff
Date: Sat, 12 May 2007 15:54:28 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0705121553300.31357@asgard.lang.hm>
References: <Pine.LNX.4.64.0705121109520.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun May 13 00:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hn0XF-0000Ip-P0
	for gcvg-git@gmane.org; Sun, 13 May 2007 00:57:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342AbXELW5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 18:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbXELW5y
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 18:57:54 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:59236
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342AbXELW5x (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 18:57:53 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l4CMvoGg006338;
	Sat, 12 May 2007 15:57:50 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <Pine.LNX.4.64.0705121109520.18541@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47105>

On Sat, 12 May 2007, Daniel Barkalow wrote:

> It would be nice if git-format-patch would generate a [PATCH 0/n] message
> at the start of the series if some option were given. This would, of
> course, have to be editted afterwards to include actual information, but
> it would at least be pre-generated in series and with the configured
> headers and such.

instead of the 0/n message be empty, have it start off listing the subject 
lines of the patches to follow (makeing it easier to add any comments 
about them)

David Lang
