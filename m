From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2] rev-parse --namespace
Date: Tue, 19 Jan 2010 18:39:25 +0100
Message-ID: <201001191839.27090.trast@student.ethz.ch>
References: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Tue Jan 19 18:39:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXI3K-0005qS-NG
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 18:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782Ab0ASRji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 12:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754570Ab0ASRjh
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 12:39:37 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:40831 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab0ASRjg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 12:39:36 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 19 Jan
 2010 18:39:34 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Tue, 19 Jan
 2010 18:39:28 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.3.90; x86_64; ; )
In-Reply-To: <1263798952-27624-1-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137478>

Ilari Liusvaara wrote:
> Add --namespace=<namespace> option to rev-parse and everything that
> accepts its options. This option matches all refs in some subnamespace
> of refs hierarchy.
> 
> Example:
> 
> 'git log --branches --not --namespace=remotes/origin'
> 
> To show what you have that origin doesn't.

Sorry for being so late to this discussion, but... wouldn't it be
nicer to give it some globbing powers and the same semantics as
'fetch' lines?  That way spelling "all master branches of my remotes"
and other such things would be easy.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
