From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH v2 1/3] t7700: demonstrate mishandling of objects in packs
 with a .keep file
Date: Tue, 04 Nov 2008 20:17:40 +0100
Message-ID: <49109FD4.30003@op5.se>
References: <20081103161202.GJ15463@spearce.org> <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Nov 04 20:19:40 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxRR9-0000qu-6x
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 20:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbYKDTSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 14:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753867AbYKDTSQ
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 14:18:16 -0500
Received: from mail.op5.se ([193.201.96.20]:54631 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753307AbYKDTSP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 14:18:15 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5B9291B80CA3;
	Tue,  4 Nov 2008 20:13:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.974
X-Spam-Level: 
X-Spam-Status: No, score=-2.974 tagged_above=-10 required=6.6
	tests=[AWL=-0.475, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uyX8Ca3P1tOk; Tue,  4 Nov 2008 20:13:18 +0100 (CET)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 8F5481B800B1;
	Tue,  4 Nov 2008 20:13:14 +0100 (CET)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <muOuA1nLBoljLnZoguxeFeKt-8Q-I9Y3ljvxnLWLt9KyA8HwVtMa4Q@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100096>

Brandon Casey wrote:
> From: Brandon Casey <drafnel@gmail.com>
> 
> Objects residing in pack files that have an associated .keep file are not
> supposed to be repacked into new pack files, but they are.
> 
> Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
> ---
> 
> 
> This version replaces the use of 'head -n -1' with a grep, and should work on
> all platforms.
> 

sed 1q is faster, as it stops parsing after the first line (the same as 'head
-n 1' does, but in a more portable fashion).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
