From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: minor spelling fix and string factorisation.
Date: Wed, 18 Mar 2009 15:54:23 -0700
Message-ID: <20090318225423.GI23521@spearce.org>
References: <20090318212230.GA2511@zoy.org> <7vvdq6bgzv.fsf@gitster.siamese.dyndns.org> <20090318224301.GH27280@zoy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Sam Hocevar <sam@zoy.org>
X-From: git-owner@vger.kernel.org Wed Mar 18 23:56:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lk4gZ-00036c-So
	for gcvg-git-2@gmane.org; Wed, 18 Mar 2009 23:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755754AbZCRWy0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2009 18:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753184AbZCRWyZ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Mar 2009 18:54:25 -0400
Received: from george.spearce.org ([209.20.77.23]:46157 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754274AbZCRWyZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2009 18:54:25 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id AA6F738221; Wed, 18 Mar 2009 22:54:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090318224301.GH27280@zoy.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113700>

Sam Hocevar <sam@zoy.org> wrote:
> On Wed, Mar 18, 2009, Junio C Hamano wrote:
> 
> > Don't you also need to adjust the existing translations if you are
> > changing the key strings used by mc?
> 
>    I assumed a typical workflow where the translation coordinator
> decides when to update .pot (typically at string freeze before a
> release). I can provide the appropriate patch nonetheless.

Well, we are only adjusting the English translation.  The .pot
and .po files use the English translation as the message keys.
I don't see a reason why we can't fix them for the translators
when the message keys are being modified in ways that shouldn't
impact the translated text.

Unless the translators translated the typos.  I doubt they did.

-- 
Shawn.
