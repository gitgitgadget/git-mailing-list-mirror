From: Marcus Comstedt <marcus@mc.pp.se>
Subject: Re: Fix for normalization of foreign idents
Date: Mon, 06 Sep 2010 11:42:33 +0200
Message-ID: <yf9vd6j5hti.fsf@mc.pp.se>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
	<20100823213531.GD2120@burratino> <yf97hjhrol5.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 11:42:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsYDv-0001D2-Px
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 11:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822Ab0IFJmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Sep 2010 05:42:38 -0400
Received: from ua-85-227-1-6.cust.bredbandsbolaget.se ([85.227.1.6]:58971 "EHLO
	bahamut.mc.pp.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750734Ab0IFJmi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Sep 2010 05:42:38 -0400
Received: from bahamut.mc.pp.se (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bahamut.mc.pp.se (Postfix) with ESMTPS id 116C4F3DF;
	Mon,  6 Sep 2010 11:42:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mc.pp.se; s=hedgehog;
	t=1283766155; bh=o0d/RQMAhn4blJGGYbsol8WLuF2vKoWzMAZFuhLfsY4=;
	h=To:Cc:Subject:References:From:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=erIyHjl7521TekCK55aGUr9K5nkGwXVgInaki
	febqQOAuhKnkpu69+9PyydMUICAmyyUFwh/MfRohjLkGOrf7zdbqbdKXQrpEpJMlzW2
	WVpfvN9f5wnBj2OKpH2UrXnC5PvuOHYyNQ62aORGPIQGQKtG5nBl24AQs2LGex1cZhQ
	=
Received: (from marcus@localhost)
	by bahamut.mc.pp.se (8.14.3+Sun/8.14.3/Submit) id o869gYSB006302;
	Mon, 6 Sep 2010 11:42:34 +0200 (CEST)
X-Authentication-Warning: bahamut.mc.pp.se: marcus set sender to marcus@mc.pp.se using -f
In-Reply-To: <yf97hjhrol5.fsf@chiyo.mc.pp.se> (Marcus Comstedt's message of "Mon, 23 Aug 2010 23:44:38 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) XEmacs/21.4.22 (usg-unix-v)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155547>


Hi.

Was this patch simply forgotten, or are there some remaining
concerns about it?

Should I submit a new patch which simply fixes the inconsistency
which breaks checkout, and leaves the removal of foreign idents
on commit to user interaction or hook scripts, as suggested by
Jonathan?  That would at least restore deterministic behavior...


  // Marcus
