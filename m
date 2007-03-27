From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Submodule object store
Date: Tue, 27 Mar 2007 18:56:09 +0200
Message-ID: <200703271856.09492.Josef.Weidendorfer@gmx.de>
References: <1174930688.5662.20.camel@localhost> <20070327115029.GC12178@informatik.uni-freiburg.de> <20070327155306.GQ22773@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Junio C Hamano <junkio@cox.net>, Eric Lesh <eclesh@ucla.edu>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Martin Waitz <tali@admingilde.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 18:38:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWEhD-0002tT-DM
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 18:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131AbXC0Qit (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933143AbXC0Qit
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 12:38:49 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:60857 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933131AbXC0Qis (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2007 12:38:48 -0400
Received: from dhcp-3s-51.lrr.in.tum.de (dhcp-3s-51.lrr.in.tum.de [131.159.35.51])
	by mail.in.tum.de (Postfix) with ESMTP id E6CFC279F;
	Tue, 27 Mar 2007 18:38:46 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <20070327155306.GQ22773@admingilde.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43281>

On Tuesday 27 March 2007, Martin Waitz wrote:
> For any other way to separate the odb (project id, whatever), we
> can't get a list of references into it by a path-limited traversal
> in the parent. Thus separate odbs which are not bound to a special
> location have some serious downsides.

For path-limited traversal, you still need to know all the paths
with super/subproject boundaries somewhere in the history.
Do you store this information somewhere?
If so, how is this different from directly storing the boundaries
(aside from size)?

Josef
