From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Tue, 19 Jan 2010 22:46:51 +0100
Message-ID: <201001192246.53453.trast@student.ethz.ch>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi> <7v3a21amh7.fsf@alter.siamese.dyndns.org> <20100119214400.GA24911@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 22:47:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXLuy-00074I-7L
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 22:47:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497Ab0ASVrQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 16:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753474Ab0ASVrQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 16:47:16 -0500
Received: from gwse.ethz.ch ([129.132.178.238]:4466 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab0ASVrP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 16:47:15 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 19 Jan
 2010 22:46:53 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 19 Jan
 2010 22:46:55 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <20100119214400.GA24911@Knoppix>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137496>

Ilari Liusvaara wrote:
> On Tue, Jan 19, 2010 at 12:06:12PM -0800, Junio C Hamano wrote:
> > As refs behave like a filesystem path and we try to use fnmatch() for
> > anything that behave like a filesystem path, that would break consistency.
> 
> Eh, remind me what commands take refs and shell-glob them? The only
> 'globbing' of refs I'm aware of is in refspecs, and that definitely isn't
> shell globbing...

fetchspecs?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
