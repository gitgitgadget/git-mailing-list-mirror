From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 19/25] t6034: use modern test_* helpers
Date: Wed, 25 Mar 2015 00:43:34 +0100
Message-ID: <20150325004334.Horde.frKSaf3PFu150aHhx6lRlw3@webmail.informatik.kit.edu>
References: <20150320100429.GA17354@peff.net>
 <20150320101315.GS12543@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 25 00:43:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YaYUA-0001uv-7g
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 00:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbbCXXnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2015 19:43:46 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43828 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752411AbbCXXnp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Mar 2015 19:43:45 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1YaYU3-0001RV-H9; Wed, 25 Mar 2015 00:43:43 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1YaYTu-00089c-Op; Wed, 25 Mar 2015 00:43:34 +0100
Received: from x590cf8a1.dyn.telefonica.de (x590cf8a1.dyn.telefonica.de
 [89.12.248.161]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Wed, 25 Mar 2015 00:43:34 +0100
In-Reply-To: <20150320101315.GS12543@peff.net>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.2)
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1427240623.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266239>


Quoting Jeff King <peff@peff.net>:

> These say roughly the same thing as the hand-rolled
> messages. We do lose the "merge did not complete" debug
> message, but merge and write-tree are prefectly capable of

s/prefectly/perfectly/

> writing useful error messages when they fail.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
