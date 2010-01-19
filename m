From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Tue, 19 Jan 2010 23:44:00 +0200
Message-ID: <20100119214400.GA24911@Knoppix>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <201001191839.27090.trast@student.ethz.ch>
 <20100119183736.GA24204@Knoppix>
 <7v3a21amh7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:44:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXLs1-0005jJ-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 22:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943Ab0ASVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 16:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752580Ab0ASVoM
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 16:44:12 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:43519 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752297Ab0ASVoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 16:44:11 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 4C4E38C092;
	Tue, 19 Jan 2010 23:44:05 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A05B2A46844; Tue, 19 Jan 2010 23:44:05 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 0C9A61C6389;
	Tue, 19 Jan 2010 23:44:01 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7v3a21amh7.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137495>

On Tue, Jan 19, 2010 at 12:06:12PM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > ..., if matching power would be extended,
> > probably the easiest extension would be full-blown extended regular
> > expressions.
> 
> As refs behave like a filesystem path and we try to use fnmatch() for
> anything that behave like a filesystem path, that would break consistency.

Eh, remind me what commands take refs and shell-glob them? The only
'globbing' of refs I'm aware of is in refspecs, and that definitely isn't
shell globbing...

-Ilari
