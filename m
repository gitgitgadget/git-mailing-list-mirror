From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] pull: refuse complete src:dst fetchspec arguments
Date: Wed, 21 Oct 2009 10:06:43 +0200
Message-ID: <200910211006.44398.trast@student.ethz.ch>
References: <d561e70f0aa802ceb96eba16d3bb2316134d69c8.1256062808.git.trast@student.ethz.ch> <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Sean Estabrooks <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Wed Oct 21 10:07:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0WEX-0005Lb-2v
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 10:07:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353AbZJUIHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 04:07:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbZJUIHg
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 04:07:36 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:24697 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751237AbZJUIHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 04:07:35 -0400
Received: from CAS01.d.ethz.ch (129.132.178.235) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 10:07:41 +0200
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.176.0; Wed, 21 Oct
 2009 10:07:17 +0200
User-Agent: KMail/1.12.2 (Linux/2.6.27.29-0.1-default; KDE/4.3.1; x86_64; ; )
In-Reply-To: <BLU0-SMTP97AA2287062D9A104101C8AEC00@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130899>

Sean Estabrooks wrote:
> Instead of removing this test it should be modified or replaced
> with a test that ensures the new functionality operates correctly.
> In this case that would mean checking that using a full refspec
> errors out.

Indeed, sorry.  I meant it to be flagged as an RFC patch, and with
those I usually go for the minimal possible effort to not break the
test suite outright.  As such, it also lacks doc updates.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
