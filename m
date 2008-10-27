From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [RFC PATCH v2] fetch-pack: log(n)-transmission find_common()
Date: Mon, 27 Oct 2008 19:29:23 +0900
Message-ID: <20081027192923.6117@nanako3.lavabit.com>
References: <1224790716-20551-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 11:31:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuPNL-0005yy-7D
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 11:31:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751907AbYJ0K3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 06:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751988AbYJ0K3y
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 06:29:54 -0400
Received: from karen.lavabit.com ([72.249.41.33]:44699 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751639AbYJ0K3x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 06:29:53 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id BFCCDC843A;
	Mon, 27 Oct 2008 05:29:52 -0500 (CDT)
Received: from 9801.lavabit.com (212.62.97.21)
	by lavabit.com with ESMTP id 5OPEPBNR9HBB; Mon, 27 Oct 2008 05:29:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=L8ofCTeAEdVBueEQpGO7g9r4Sf+7h+vbdbdwDBAmOsII9sKWhY7woh5lKYjH1pmt1er7PdlsnQvS74ziAyiZy8V1kKxyWqpcZnFah/AuYxObZCqCI9lSx4pmGty9hsoq+9Qt5w6Ge3eQqYdRHBgHrvqs4u8wyqEhxztCk3kwRCU=;
  h=From:To:Cc:Date:Subject:In-reply-to:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-reply-to: <1224790716-20551-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99223>

Quoting Thomas Rast <trast@student.ethz.ch>:

> Replaces the existing simple history search with a more sophisticated
> algorithm:
> 
> 1) Walk history with exponentially increasing stride lengths; i.e.,
>    send the 1st commit, then the 2nd after that, then the 4th after
>    that, and so on.
> 
> 2) Bisect the resulting intervals.

Junio, may I ask what the status of this patch is? I see Nicolas responded and said "I gave this a quick try". Wasn't it a good enough review?

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
