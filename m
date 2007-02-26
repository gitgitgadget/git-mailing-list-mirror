From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-remote and remotes with '.' in their names
Date: Mon, 26 Feb 2007 12:28:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702261227450.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <87k5y5tlol.fsf@briny.internal.ondioline.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Paul Collins <paul@briny.ondioline.org>
X-From: git-owner@vger.kernel.org Mon Feb 26 12:28:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLe2K-0004Qq-HL
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 12:28:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbXBZL2x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 06:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbXBZL2x
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 06:28:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:56248 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751205AbXBZL2w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Feb 2007 06:28:52 -0500
Received: (qmail invoked by alias); 26 Feb 2007 11:28:51 -0000
X-Provags-ID: V01U2FsdGVkX1/ERKtVLoHEBCn5Coq7yxnHXTe5TWTnG9o6adHEIV
	6TJA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <87k5y5tlol.fsf@briny.internal.ondioline.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40618>

Hi,

On Mon, 26 Feb 2007, Paul Collins wrote:

> With this patch I get the correct list, but then it will break if there 
> are ever config keys like "remote.$remote_name.foo.bar".

I think you do not need to worry. AFAIR variable names in the config must 
not contain dots, so the only way to set your example variable would be

[remote "$remote_name.foo"]
	bar = blabla

Ciao,
Dscho
