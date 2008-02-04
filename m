From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] [v8] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Mon, 4 Feb 2008 17:43:52 +0100
Message-ID: <459F2F36-7110-42A0-BDC1-FED70BC499BD@zib.de>
References: <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de> <12021001351967-git-send-email-prohaska@zib.de> <alpine.LSU.1.00.0802041502290.7372@racer.site>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:51:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM4XR-0000v0-Ky
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 17:51:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699AbYBDQuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 11:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbYBDQut
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 11:50:49 -0500
Received: from mailer.zib.de ([130.73.108.11]:35838 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750979AbYBDQut (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 11:50:49 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id m14GgvIh002122;
	Mon, 4 Feb 2008 17:42:57 +0100 (CET)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id m14GgrTu020762
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 4 Feb 2008 17:42:57 +0100 (MET)
In-Reply-To: <alpine.LSU.1.00.0802041502290.7372@racer.site>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72524>


On Feb 4, 2008, at 4:02 PM, Johannes Schindelin wrote:

> Hi,
>
> On Mon, 4 Feb 2008, Steffen Prohaska wrote:
>
>>  - refactored to lines max 84 chars long.
>
> Why 84?  I think the standard is still 80.

Because the surrounding code already had lines with
more than 80 characters and the most natural refactoring
without too much wrapping effort resulted in 84.

Is 80 a strict limit?

	Steffen
