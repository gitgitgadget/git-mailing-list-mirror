From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/4] repack: don't repack local objects in packs with
 .keep file
Date: Fri, 07 Nov 2008 09:14:22 +0100
Message-ID: <4913F8DE.1050308@op5.se>
References: <oDevG_2ETMLvy6rfSqvxfmFqABeVqlDUcU6FjP07E5IzqLaopWkQbQ@cipher.nrlssc.navy.mil> <P5afFyDEMjF9ynd9dfSfGeRo_GFY_K6ZAn2nIYo8_xGgSl4LapbSOA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri Nov 07 09:16:18 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyMVp-0004mM-3N
	for gcvg-git-2@gmane.org; Fri, 07 Nov 2008 09:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbYKGIO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2008 03:14:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbYKGIO5
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Nov 2008 03:14:57 -0500
Received: from mail.op5.se ([193.201.96.20]:55320 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751409AbYKGIO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2008 03:14:57 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C7AB324B0B85;
	Fri,  7 Nov 2008 09:08:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2TD000WxaOvY; Fri,  7 Nov 2008 09:08:06 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 88C4324B0011;
	Fri,  7 Nov 2008 09:08:05 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <P5afFyDEMjF9ynd9dfSfGeRo_GFY_K6ZAn2nIYo8_xGgSl4LapbSOA@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100294>

Brandon Casey wrote:
> If the user created a .keep file for a local pack, then it can be inferred
> that the user does not want those objects repacked.
> 

I disagree. It can be inferred that the user doesn't want those packfiles
*removed*.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
