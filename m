From: Markus Heidelberg <markus.heidelberg@web.de>
Subject: Re: [PATCH] grep: don't support "grep.color"-like config options
Date: Tue, 21 Apr 2009 02:11:52 +0200
Message-ID: <200904210211.52818.markus.heidelberg@web.de>
References: <1240268295-10296-1-git-send-email-markus.heidelberg@web.de> <alpine.DEB.1.00.0904210145260.10279@pacific.mpi-cbg.de>
Reply-To: markus.heidelberg@web.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 02:13:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw3bj-0005Ix-F1
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 02:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753727AbZDUAL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 20:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753443AbZDUAL1
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 20:11:27 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:37540 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752311AbZDUAL1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 20:11:27 -0400
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate03.web.de (Postfix) with ESMTP id 03482FAD6955;
	Tue, 21 Apr 2009 02:11:24 +0200 (CEST)
Received: from [89.59.65.183] (helo=.)
	by smtp06.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #277)
	id 1Lw3a7-00040K-00; Tue, 21 Apr 2009 02:11:23 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0904210145260.10279@pacific.mpi-cbg.de>
Jabber-ID: markus.heidelberg@web.de
Content-Disposition: inline
X-Sender: markus.heidelberg@web.de
X-Provags-ID: V01U2FsdGVkX1/WQvglhRpYeyFBjWwpPV84ddwP79ULV1gK5m4/
	A1YsQUu2mVYlu/GYo8yTELQe8k+NwEvofOHhgi8xTmW/8QK5Tn
	fJh6xSI8GRuTtddlL79g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117049>

Johannes Schindelin, 21.04.2009:
> Hi,
> 
> On Tue, 21 Apr 2009, Markus Heidelberg wrote:
> 
> > color.grep and color.grep.* is the official and documented way to 
> > highlight grep matches. Comparable options like diff.color.* and 
> > status.color.* exist for backward compatibility reasons only and are not 
> > documented any more.
> 
> But is it really so bad that we have to possibly break existing setups?

Given that they have never been documented since introduction of "grep
--color" in March, wouldn't it be pure luck from a users' POV, that they
even worked, after the user accidentally typed grep.color instead of
color.grep with git-config?
Should we then also introduce branch.color afterwards?

Also, colorized grep isn't yet released, people currently using
grep.color (and I guess they are very few, if any) normally are
compiling git on their own and shouldn't have problems with it
disappearing.

> The cost of keeping them is really small IMHO.

Maybe, but it's always nice to keep things simpler and cleaner.

Markus
