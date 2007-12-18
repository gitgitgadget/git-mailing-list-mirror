From: Mark Fasheh <mark.fasheh@oracle.com>
Subject: Re: [PATCH] provide advance warning of some future pack default
	changes
Date: Mon, 17 Dec 2007 18:23:23 -0800
Organization: Oracle Corporation
Message-ID: <20071218022323.GD13821@ca-server1.us.oracle.com>
References: <alpine.LFD.0.999999.0712141724260.8467@xanadu.home> <20071214223957.GC7300@mail.oracle.com> <alpine.LFD.0.999999.0712141744460.8467@xanadu.home> <20071215004230.GF7300@mail.oracle.com> <alpine.LFD.0.999999.0712142114400.8467@xanadu.home> <20071217200920.GB19816@mail.oracle.com> <alpine.LFD.0.999999.0712171517320.8467@xanadu.home> <7v3au16myj.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999999.0712171641460.8467@xanadu.home> <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 03:24:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4S8H-0003Ez-8d
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 03:24:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751607AbXLRCYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 21:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXLRCYF
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 21:24:05 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:20372 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbXLRCYE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 21:24:04 -0500
Received: from agmgw2.us.oracle.com (agmgw2.us.oracle.com [152.68.180.213])
	by agminet01.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id lBI2NaNj029878;
	Mon, 17 Dec 2007 20:23:36 -0600
Received: from acsmt355.oracle.com (acsmt355.oracle.com [141.146.40.155])
	by agmgw2.us.oracle.com (Switch-3.2.0/Switch-3.2.0) with ESMTP id lBHIVnb3028385;
	Mon, 17 Dec 2007 19:23:35 -0700
Received: from ca-server1.us.oracle.com by acsmt355.oracle.com
	with ESMTP id 6411398331197944604; Mon, 17 Dec 2007 18:23:24 -0800
Received: from mfasheh by ca-server1.us.oracle.com with local (Exim 4.67)
	(envelope-from <mark.fasheh@oracle.com>)
	id 1J4S79-0005yT-Ha; Mon, 17 Dec 2007 18:23:23 -0800
Content-Disposition: inline
In-Reply-To: <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68691>

On Mon, Dec 17, 2007 at 04:41:19PM -0800, Junio C Hamano wrote:
> It is not a corruption, but the distinction doesn't matter much to the
> end user who wants to get the job done with the data right now.  The
> data that was made inaccessible is inaccessible.  The only difference is
> that it is recoverable once the user upgrades, but that may be painful,
> even though it may be rewarding afterwards and worth doing so, and the
> user may not be able to afford doing so right at that moment.

Junio, I agree 100% with your description here. This is all about user
experience and data which is silently made inaccessible makes them feel
pretty bad.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
