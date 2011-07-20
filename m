From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: pre-commit not working at server side push
Date: Wed, 20 Jul 2011 10:18:07 +0300
Message-ID: <20110720071807.GA10104@LK-Perkele-VI.localdomain>
References: <20110720121356.4dc21f6b@shiva.selfip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "J. Bakshi" <joydeep@infoservices.in>
X-From: git-owner@vger.kernel.org Wed Jul 20 09:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjR1L-0007yb-Jt
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 09:16:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037Ab1GTHQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 03:16:34 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:43758 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829Ab1GTHQd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 03:16:33 -0400
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id CD89B13B403;
	Wed, 20 Jul 2011 10:16:31 +0300 (EEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A00FE6A6703; Wed, 20 Jul 2011 10:16:31 +0300
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 9ECA241BE2;
	Wed, 20 Jul 2011 10:16:29 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20110720121356.4dc21f6b@shiva.selfip.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177522>

On Wed, Jul 20, 2011 at 12:13:56PM +0530, J. Bakshi wrote:
> Hello list,
> 
> I have this bash script to check php syntax error and prevent the commit if there is any
 
<snip>
 
> Running fine when placed it at local copy.
> 
> I have placed the hook at the server under hooks directory and provided the execute permission also
> 
> $ chmod a+x hooks/pre-commit
> 
> But even with wrong php syntax I am able to push the file. Have I missed something ?

Pre-commit runs on commit, not on push. And push is not commit.

-Ilari
