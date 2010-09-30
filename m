From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v2 1/3] Add bidirectional_transfer_loop()
Date: Thu, 30 Sep 2010 18:51:45 +0300
Message-ID: <20100930155145.GA23320@LK-Perkele-V2.elisa-laajakaista.fi>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100930135502.GG4850@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 17:46:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1LLB-0008JN-6v
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:46:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119Ab0I3Pqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 11:46:35 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:45430 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756643Ab0I3Pqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 11:46:34 -0400
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 0DC51EF7C5;
	Thu, 30 Sep 2010 18:46:33 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A05267F3442; Thu, 30 Sep 2010 18:46:32 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id F1873158A63;
	Thu, 30 Sep 2010 18:46:30 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20100930135502.GG4850@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157682>

On Thu, Sep 30, 2010 at 08:55:02AM -0500, Jonathan Nieder wrote:
> Ilari Liusvaara wrote:
> 
> Why not:
> 
> 		trace_printf("trace: adding stdin to ...");
> 
> ?  That would give the user control of where tracing output goes
> (settings like GIT_TRACE=17).
> 
> If trace is too noisy (I don't think it is), maybe we should
> make it more nuanced, like GIT_TRACE=17:transport?

The debugging output is hellishly noisy. I just (successfully) tried to clone
git repo from local copy. The result was no less than 106 773 debugging
messages...

-Ilari
