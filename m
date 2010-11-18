From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v8 0/3] git-remote-fd & git-remote-ext
Date: Thu, 18 Nov 2010 04:31:04 +0200
Message-ID: <20101118023104.GA28255@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1289878454-17192-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <7vy68rg9c9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 18 03:31:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIuH8-00064R-Gh
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 03:31:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0KRCa5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Nov 2010 21:30:57 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:44719 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754775Ab0KRCa5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Nov 2010 21:30:57 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 8FB4E8C6EE;
	Thu, 18 Nov 2010 04:30:54 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02E468BDF7; Thu, 18 Nov 2010 04:30:54 +0200
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 69C9B27D85;
	Thu, 18 Nov 2010 04:30:51 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vy68rg9c9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161646>

On Wed, Nov 17, 2010 at 09:15:34AM -0800, Junio C Hamano wrote:
> Thanks; the changes from the last round all look sensible to me, but did
> you know that the last round has already been in 'next' for a few weeks by
> now already?

Oops... Sorry. :-/
 
> If you don't mind I'll turn these three into the following and queue as
> 4/3 on top of what is already merged, as reverting the merge with the old
> series and merging the new round to 'next' makes it messier than it
> already is.

I tested applying that patch. Doesn't seem to break things at least code-
wise (no surprise, it only adds headers and adds one conditional that only
evaluates to false on invalid input).

So I don't mind applying that patch. Acking the patch.

-Ilari
