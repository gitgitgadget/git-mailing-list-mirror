From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] difftool: Make directory diff symlink work tree
Date: Wed, 13 Mar 2013 09:11:34 +0000
Message-ID: <20130313091134.GI2317@serenity.lan>
References: <CAJELnLGq_oLBiNHANoaE7iEiA6g4fXX0PtJbqPFi4PQ+5LLvnA@mail.gmail.com>
 <CAJDDKr4mTc8-FX7--pd7j0vUbdk_1+KU0YniKEhRdee6SaS-8Q@mail.gmail.com>
 <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <20130312192459.GD2317@serenity.lan>
 <CAJELnLEmrBSiua3xe_Y7MS1SCL8TD28sQH-R6Kfn9Zk+Zm6=kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Matt McClure <matthewlmcclure@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 10:12:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFhjN-0000rj-O1
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 10:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab3CMJLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 05:11:51 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:42943 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468Ab3CMJLu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 05:11:50 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id A4F15CDA598;
	Wed, 13 Mar 2013 09:11:49 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ibdzxsdcRe1N; Wed, 13 Mar 2013 09:11:42 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id C63D4CDA594;
	Wed, 13 Mar 2013 09:11:36 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJELnLEmrBSiua3xe_Y7MS1SCL8TD28sQH-R6Kfn9Zk+Zm6=kw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218044>

On Tue, Mar 12, 2013 at 08:26:21PM -0400, Matt McClure wrote:
> On Tue, Mar 12, 2013 at 3:24 PM, John Keeping <john@keeping.me.uk> wrote:
> > If so I think you want some new mode of operation for difftool instead
> > of this patch which will also affect unrelated commands.
> 
> Are you suggesting that difftool do the reset work above given a new
> option or by default?

I was suggesting something like the "--symlink-all" option discussed in
the parallel thread, but it looks like we now have a better solution
than that.


John
