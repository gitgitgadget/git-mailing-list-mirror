From: Derek Fawcus <dfawcus@cisco.com>
Subject: Re: Suggestion: "man git clone"
Date: Fri, 22 Aug 2008 16:03:53 +0100
Message-ID: <20080822150353.GC13490@cisco.com>
References: <48ACB29C.7000606@zytor.com> <g8m6d1$7nf$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 22 17:07:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWYE4-0007B1-RE
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 17:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYHVPFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 11:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbYHVPFw
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 11:05:52 -0400
Received: from ams-iport-1.cisco.com ([144.254.224.140]:16569 "EHLO
	ams-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508AbYHVPFw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 11:05:52 -0400
X-IronPort-AV: E=Sophos;i="4.32,252,1217808000"; 
   d="scan'208";a="17964769"
Received: from ams-dkim-2.cisco.com ([144.254.224.139])
  by ams-iport-1.cisco.com with ESMTP; 22 Aug 2008 15:05:50 +0000
Received: from ams-core-1.cisco.com (ams-core-1.cisco.com [144.254.224.150])
	by ams-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m7MF5oYK003686
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 17:05:50 +0200
Received: from edi-view2.cisco.com (edi-view2.cisco.com [64.103.71.156])
	by ams-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m7MF5oV8011036
	for <git@vger.kernel.org>; Fri, 22 Aug 2008 15:05:50 GMT
Received: from dfawcus-laptop (localhost [127.0.0.1]) by edi-view2.cisco.com (8.11.2/CISCO.WS.1.2) with ESMTP id m7MF5nX01237 for <git@vger.kernel.org>; Fri, 22 Aug 2008 16:05:49 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <g8m6d1$7nf$1@ger.gmane.org>
User-Agent: Mutt/1.4.2.3i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; l=668; t=1219417550; x=1220281550;
	c=relaxed/simple; s=amsdkim2001;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dfawcus@cisco.com;
	z=From:=20Derek=20Fawcus=20<dfawcus@cisco.com>
	|Subject:=20Re=3A=20Suggestion=3A=20=22man=20git=20clone=22
	|Sender:=20;
	bh=eXuA2OgWEqHDencD+zBzAKtbyQAJYd5dCtmS4/VDIx0=;
	b=incvwwuHJJmXNLUVmQ9AtaMO2PjoXBe35K/1U7fb92mlqZ70eD3jsmmgD3
	i0tMu1a39CQ8MGm0GhGGguFb+BFO0VZtWBdz1KzFLXAmQH4xF9VYE0rqy2H/
	CA5cpDQQaE;
Authentication-Results: ams-dkim-2; header.From=dfawcus@cisco.com; dkim=pass (
	sig from cisco.com/amsdkim2001 verified; ); 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93307>

On Fri, Aug 22, 2008 at 01:02:57PM +0200, Michael J Gruber wrote:
> I've heard about some other SCMs which have only "scm help bla", so this
> suggestion would be in-line with common usage. [Not that git would have
> to learn from other SCM's ;) ]

Clearcase - commands such as 'cleartool describe',  man page in ct+describe.1

Has 'cleartool help describe' (and 'cleartool describe -help') which gives a
usage summary,  and 'cleartool man describe' (or 'man ct+describe') for the
man page.

So basically the same solution,  but a slightly different choice/use for keywords.

(and if one has an alias 'ct=cleartool',  it seems to make more sense).

DF
