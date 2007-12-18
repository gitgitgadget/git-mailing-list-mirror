From: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 18:15:56 -0800
Organization: Oracle Corporation
Message-ID: <20071218021556.GC13821@ca-server1.us.oracle.com>
References: <m3fxy5qwbq.fsf@roke.D-201> <alpine.LFD.0.999999.0712140836140.8467@xanadu.home> <20071214215206.GB7300@mail.oracle.com> <alpine.LFD.0.999999.0712141724260.8467@xanadu.home> <20071214223957.GC7300@mail.oracle.com> <alpine.LFD.0.999999.0712141744460.8467@xanadu.home> <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 03:18:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4S2P-0001rf-Ps
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 03:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751792AbXLRCSG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 21:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbXLRCSF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 21:18:05 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:37631 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751638AbXLRCSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 21:18:04 -0500
Received: from agmgw1.us.oracle.com (agmgw1.us.oracle.com [152.68.180.212])
	by rgminet01.oracle.com (Switch-3.2.4/Switch-3.1.6) with ESMTP id lBI2HXXI012095;
	Mon, 17 Dec 2007 19:17:33 -0700
Received: from acsmt354.oracle.com (acsmt354.oracle.com [141.146.40.154])
	by agmgw1.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBHIPCI1029609;
	Mon, 17 Dec 2007 19:17:32 -0700
Received: from ca-server1.us.oracle.com by acsmt354.oracle.com
	with ESMTP id 6412098191197944156; Mon, 17 Dec 2007 18:15:56 -0800
Received: from mfasheh by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <mark.fasheh@oracle.com>)
	id 1J4Rzw-0005t2-A5; Mon, 17 Dec 2007 18:15:56 -0800
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68690>

Hi,

	Just to "out" myself, I'm the "co-worker" whose name Joel has been
(politely) keeping anonymous.

On Mon, Dec 17, 2007 at 03:41:24PM -0500, Nicolas Pitre wrote:
> > 	You may not see a case for actual corruptions, but my coworker
> > updated his tree on a box with 1.5.x, then tried to work on a box with
> > 1.4.x (I think 1.4.2 back then), and ended up with a tree that was
> > unusable.  He had to re-clone, and I think he got lucky recovering
> > pending changes (probably using 1.5.x on the branches with the changes,
> > as master was what got broken).
> 
> I still claim that there wasn't any corruptions.

The following description is really vague because this was a while ago:

Something made my ocfs2.git tree unusable in that I could no longer do
common tasks, such as git-log, etc without getting messages about corrupted
refs.

I wish I had saved off some of the messages. Sorry.

I had to re-create my git tree several times before I learned by deduction
that it was the older versions of git on some of the machines that were
writing some sort of incompatible format.


> Just for fun, just edit some document with Microsoft Office 95, then 
> open the same document with Office 2007 and save it with default 
> settings.  Now try to open it back with Office 95.  It won't work.  
> Does that mean that the document got corrupted?

Boy, I hope Microsoft Office isn't our bar for compatiblity here...
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
