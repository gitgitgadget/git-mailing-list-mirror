From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] tag: add -i and --introduced modifier for --contains
Date: Thu, 17 Apr 2014 09:17:33 +0200
Message-ID: <mvm8ur42zn6.fsf@hawking.suse.de>
References: <1397681938-18594-1-git-send-email-mcgrof@do-not-panic.com>
	<xmqqppkhexw3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, git@vger.kernel.org,
	"Luis R. Rodriguez" <mcgrof@suse.com>, Jiri Slaby <jslaby@suse.cz>,
	Jan Kara <jack@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 17 09:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WagZp-0001sa-Tp
	for gcvg-git-2@plane.gmane.org; Thu, 17 Apr 2014 09:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752298AbaDQHRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Apr 2014 03:17:36 -0400
Received: from cantor2.suse.de ([195.135.220.15]:59259 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751444AbaDQHRf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Apr 2014 03:17:35 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 1467BAC30;
	Thu, 17 Apr 2014 07:17:34 +0000 (UTC)
X-Yow: In order to make PLANS for the WEEKEND...so that we can read RESTAURANT
 REVIEWS and decide to GO to that restaurant & then NEVER GO...so we can
 meet a FRIEND after work in a BAR and COMPLAIN about Interior Sect'y
 JAMES WATT until the SUBJECT is changed to NUCLEAR BLACKMAIL...and so
 our RELATIVES can FORCE us to listen to HOCKEY STATISTICS while we
 wait for them to LEAVE on the 7:48....
In-Reply-To: <xmqqppkhexw3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 16 Apr 2014 15:02:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246412>

Junio C Hamano <gitster@pobox.com> writes:

> And you are right that the commit is contained in v3.4, so we also
> should be able to describe it as v3.4~479^2~9^2 as well.

IMHO it should be described as v3.4-rc1~192^2~9^2, which is what git
describe --contains --match=v3.4\* returns.  This path is only a few
commits longer than v3.5-rc1~120^3~76^2.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
