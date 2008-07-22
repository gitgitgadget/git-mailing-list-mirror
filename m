From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/9] Makefile: Normalize $(bindir) and $(gitexecdir) 
  before comparing
Date: Tue, 22 Jul 2008 09:25:21 +0200
Message-ID: <48858B61.5070300@viscovery.net>
References: <1216667998-8879-1-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-2-git-send-email-johannes.sixt@telecom.at> <1216667998-8879-3-git-send-email-johannes.sixt@telecom.at> <alpine.DEB.1.00.0807220147320.3407@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCGN-0007jN-Kt
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbYGVHZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYGVHZY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:25:24 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57183 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810AbYGVHZX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:25:23 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLCFN-00040Y-Gn; Tue, 22 Jul 2008 09:25:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4746B6D9; Tue, 22 Jul 2008 09:25:21 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0807220147320.3407@eeepc-johanness>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89457>

Johannes Schindelin schrieb:
> Hi,
> 
> On Mon, 21 Jul 2008, Johannes Sixt wrote:
> 
>> +	bindir=$$(cd '$(DESTDIR_SQ)$(bindir_SQ)' && pwd) && \
>> +	execdir=$$(cd '$(DESTDIR_SQ)$(gitexecdir_SQ)' && pwd) && \
> 
> These lack quotes, no?

No. RHS of an assignment doesn't need quotes as long as the shell syntax
makes clear where the assignment ends, which is the case here because of
the brackets $(...).

-- Hannes
