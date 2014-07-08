From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v6 08/10] commit: add for_each_mergetag()
Date: Tue, 08 Jul 2014 07:53:16 +0200 (CEST)
Message-ID: <20140708.075316.1145736046390054920.chriscool@tuxfamily.org>
References: <20140707063342.3708.83493.chriscool@tuxfamily.org>
	<20140707063540.3708.39506.chriscool@tuxfamily.org>
	<xmqqegxwby3l.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, mhagger@alum.mit.edu,
	jnareb@gmail.com, sunshine@sunshineco.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 08 07:53:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4OLE-0004tI-MT
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jul 2014 07:53:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752651AbaGHFxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2014 01:53:19 -0400
Received: from mail-3y.bbox.fr ([194.158.98.45]:45250 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbaGHFxS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2014 01:53:18 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id 131EA5E;
	Tue,  8 Jul 2014 07:53:17 +0200 (CEST)
In-Reply-To: <xmqqegxwby3l.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253004>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> In the same way as there is for_each_ref() to
>> iterate on refs, it might be useful to have
>> for_each_mergetag() to iterate on the mergetags
>> of a given commit.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
> 
> Heh, "might be useful" is an understatement ;-) We won't apply a
> change that "might be useful" very lightly, but this refactoring
> already uses the helper in existing code, showing that it *is*
> useful, no?
> 
> Let's have this early in the series, or perhaps even independent of
> the "replace" series.

Ok, thanks,
Christian.
