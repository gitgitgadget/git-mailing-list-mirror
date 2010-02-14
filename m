From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH 6/6] contrib: add a hook that copies notes over rewrites
Date: Sun, 14 Feb 2010 17:21:15 +0100
Message-ID: <201002141721.16165.trast@student.ethz.ch>
References: <cover.1266164150.git.trast@student.ethz.ch> <fba55036b8c07f1ee10c4d8f7ed22045277aeb21.1266164150.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 14 17:21:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NghDn-0006Rq-BC
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 17:21:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751842Ab0BNQVS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 11:21:18 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:37790 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933Ab0BNQVR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 11:21:17 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:21:18 +0100
Received: from thomas.localnet (217.162.250.31) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.234.1; Sun, 14 Feb
 2010 17:21:16 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.12-0.1-desktop; KDE/4.4.0; x86_64; ; )
In-Reply-To: <fba55036b8c07f1ee10c4d8f7ed22045277aeb21.1266164150.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139923>

On Sunday 14 February 2010 17:17:11 Thomas Rast wrote:
> +if test -z "$run"; then
> +    exit
> +done

Argh, that's what I get for writing lots of tests except for the PoC
hook.  This should of course say 'fi' instead of 'done'.  Sorry.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
