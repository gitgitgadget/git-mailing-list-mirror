From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [REROLL PATCH 7/8] Support remote archive from external
 protocol helpers
Date: Wed, 9 Dec 2009 17:16:58 +0200
Message-ID: <20091209151658.GD15673@Knoppix>
References: <1260278177-9029-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1260278177-9029-8-git-send-email-ilari.liusvaara@elisanet.fi>
 <7v7hsx5935.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 09 16:17:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIOHw-0006Se-Nk
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:17:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbZLIPRB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:17:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbZLIPRA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:17:00 -0500
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:45728 "EHLO
	emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbZLIPQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 10:16:59 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh01-2.mail.saunalahti.fi (Postfix) with SMTP id 424698C6D6;
	Wed,  9 Dec 2009 17:17:05 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A05E83114EC; Wed, 09 Dec 2009 17:17:05 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id ECC6F27D92;
	Wed,  9 Dec 2009 17:16:58 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7v7hsx5935.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134977>

On Tue, Dec 08, 2009 at 03:39:42PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > Helpers which support connect also should support remote archive
> > snapshot (or at least there's only one way to attempt it). So support
> > remote snapshotting for protocol helpers.
> 
> Or "Because the transport layer has been restructured cleanly enough to
> allow passing general payload, there is no reason not to do this change to
> pass 'archive' output in addition to the 'git smart fetch/push protocol'
> payload, and this allows the archive command to take advantage of the
> helper based transports"???

This one is the correct interpretation.

Changed to:
-----------
Support remote archive from all smart transports

Previously, remote archive required internal (non remote-helper)
smart transport. Extend the remote archive to also support smart
transports implemented by remote helpers.
------------

-Ilari
