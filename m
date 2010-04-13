From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 5/5] describe: Break annotated tag ties by tagger date
Date: Tue, 13 Apr 2010 11:32:29 +0200
Message-ID: <201004131132.30186.trast@student.ethz.ch>
References: <20100411024008.GC23075@spearce.org> <1271114729-18166-5-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 11:32:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1cU9-0002Se-MF
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 11:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752428Ab0DMJch (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 05:32:37 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:32352 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751898Ab0DMJcg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 05:32:36 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.247.2; Tue, 13 Apr
 2010 11:32:35 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.247.2; Tue, 13 Apr
 2010 11:32:30 +0200
User-Agent: KMail/1.13.2 (Linux/2.6.31.12-0.2-desktop; KDE/4.4.2; x86_64; ; )
In-Reply-To: <1271114729-18166-5-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144802>

Shawn O. Pearce wrote:
> If the tag is an older-style annotated tag with no tagger date,
> we assume a date stamp of 1 second after the UNIX epoch.

This patch doesn't seem to actually set this, but as a minor nit: the
'1 second' contradicts the 0 mentioned in the last patch.

(The effect is the same for all practical purposes.)

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
