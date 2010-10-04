From: Yann Dirson <ydirson@free.fr>
Subject: Re: [PATCH v4 1/4] Introduce wholesame directory move detection in
 diffcore.
Date: Mon, 4 Oct 2010 20:19:29 +0200
Message-ID: <20101004181929.GS4983@home.lan>
References: <1286138529-6780-1-git-send-email-ydirson@altern.org>
 <1286138529-6780-2-git-send-email-ydirson@altern.org>
 <AANLkTinhfxXPqapzdBkSehq9Qxv20=bxq9HwR8kQfPdn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ?var Arnfj?r? Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 20:10:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2pUV-0007QN-4D
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 20:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745Ab0JDSJj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 14:09:39 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:60483 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265Ab0JDSJi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 14:09:38 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 6E6F1D4815C;
	Mon,  4 Oct 2010 20:09:31 +0200 (CEST)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1P2pdJ-0002jy-VK; Mon, 04 Oct 2010 20:19:29 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTinhfxXPqapzdBkSehq9Qxv20=bxq9HwR8kQfPdn@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158081>

On Mon, Oct 04, 2010 at 02:59:20AM +0000, ?var Arnfj?r? Bjarmason wrote:
> On Sun, Oct 3, 2010 at 20:42, Yann Dirson <ydirson@altern.org> wrote:
> > This feature tries to group together files moving from and to
> > identical directories - the most common case being directory renames.
> 
> You should change the C++/C99 comments to C89 comments since we target
> the latter.

Right.  Most of them are here as reminders to either fix something or
be sure fixing it was considered before submission for inclusion -
hopefully using unacceptable syntax helps here :)
