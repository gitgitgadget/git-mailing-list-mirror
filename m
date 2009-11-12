From: Pascal Obry <pascal@obry.net>
Subject: Re: git-svn problem with v1.6.5
Date: Thu, 12 Nov 2009 10:03:06 +0100
Message-ID: <a2633edd0911120103y688a2b2ah2c33c47de195ee81@mail.gmail.com>
References: <4AF9E7FE.3060701@obry.net>
	 <32541b130911111141n7b029b1ep68656d2eb39be3c7@mail.gmail.com>
	 <4AFB1756.7090708@obry.net> <20091111202201.GA10351@dcvr.yhbt.net>
	 <20091111203413.GA9648@dcvr.yhbt.net> <4AFB32DC.50505@obry.net>
	 <20091111224454.GA16178@dcvr.yhbt.net> <4AFBADA9.3060401@obry.net>
	 <20091112071121.GA569@dcvr.yhbt.net>
	 <a2633edd0911120011u34d69100p1565ab5bf96a7709@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Avery Pennarun <apenwarr@gmail.com>, adambrewster@gmail.com,
	git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Nov 12 10:03:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8VaN-0005Pv-Az
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 10:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbZKLJDF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 04:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752176AbZKLJDE
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 04:03:04 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:52628 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbZKLJDD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 04:03:03 -0500
Received: by fxm21 with SMTP id 21so1960399fxm.21
        for <git@vger.kernel.org>; Thu, 12 Nov 2009 01:03:06 -0800 (PST)
Received: by 10.204.36.202 with SMTP id u10mr2777816bkd.196.1258016586324; 
	Thu, 12 Nov 2009 01:03:06 -0800 (PST)
In-Reply-To: <a2633edd0911120011u34d69100p1565ab5bf96a7709@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132749>

Eric,

> Will review the procedure for filtering branches :(

A quick review does not show something obviously wrong on my side.

The commit on the rewritten repo has a different sha-1 which is
expected. So to me it seems that after a filter-branch on a git-svn
repo it is mandatory to recreate all .rev_map*? Is that right? Is so,
this is the missing piece in the procedure on my side.

Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
