From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 6/8] Remove special casing of http, https and ftp
Date: Tue, 1 Dec 2009 21:39:44 +0200
Message-ID: <20091201193943.GA15571@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1259675838-14692-7-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091201182414.GK21299@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 01 20:40:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFYZw-0006Fq-8R
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 20:40:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbZLATjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 14:39:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752496AbZLATjn
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 14:39:43 -0500
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:38941 "EHLO
	emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZLATjn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 14:39:43 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh03-2.mail.saunalahti.fi (Postfix) with SMTP id B8CBAEBA7E;
	Tue,  1 Dec 2009 21:39:47 +0200 (EET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A00C79AF780; Tue, 01 Dec 2009 21:39:47 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id A861C41BE4;
	Tue,  1 Dec 2009 21:39:45 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091201182414.GK21299@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134254>

On Tue, Dec 01, 2009 at 10:24:14AM -0800, Shawn O. Pearce wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> 
> These should all be hardlinks to a single executable, not duplicate
> relinks of the same object files.

Fixed for next round (probably send that out in few days).

-Ilari
