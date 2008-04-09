From: Bryan Donlan <bdonlan@fushizen.net>
Subject: Re: [PATCH 2/8] config.c: Escape backslashes in section names
	properly
Date: Wed, 9 Apr 2008 10:13:34 -0400
Message-ID: <20080409141334.GA24402@shion.is.fushizen.net>
References: <cover.1207702130.git.bdonlan@fushizen.net> <1207704604-30393-1-git-send-email-bdonlan@fushizen.net> <1207704604-30393-2-git-send-email-bdonlan@fushizen.net> <47FC62B0.3060802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Roben <aroben@apple.com>,
	gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 09 16:33:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjbN2-0006YM-Bd
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 16:33:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbYDIOc1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 10:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755392AbYDIOc0
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 10:32:26 -0400
Received: from satoko.is.fushizen.net ([64.71.152.231]:40507 "EHLO
	satoko.is.fushizen.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbYDIOcZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 10:32:25 -0400
Received: from hillmannl2.umeres.maine.edu ([130.111.243.252] helo=shion)
	by satoko.is.fushizen.net with esmtpa (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjb3O-0001E8-SZ; Wed, 09 Apr 2008 14:13:34 +0000
Received: from bd by shion with local (Exim 4.69)
	(envelope-from <bdonlan@fushizen.net>)
	id 1Jjb3O-0006Nr-Ff; Wed, 09 Apr 2008 10:13:34 -0400
Content-Disposition: inline
In-Reply-To: <47FC62B0.3060802@viscovery.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79109>

On Wed, Apr 09, 2008 at 08:31:12AM +0200, Johannes Sixt wrote:
> Bryan Donlan schrieb:
> > Signed-off-by: Bryan Donlan <bdonlan@fushizen.net>
> 
> What is your definition of "properly"? Please give an example of what went
> wrong.

The included patch to the test suite is an example - specifically if an
element of the configuration key name other than the first or last
contains a backslash, it would not be escaped on output, but would be
treated as an escape sequence on input. Thus the backslash would be
lost.
