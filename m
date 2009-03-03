From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] git filter-branch: Process commits in --date-order
Date: Tue, 03 Mar 2009 08:41:46 +0100
Message-ID: <49ACDF3A.1090309@viscovery.net>
References: <1236035454-12236-1-git-send-email-peda@lysator.liu.se> <alpine.DEB.1.00.0903030126530.10279@pacific.mpi-cbg.de> <7vbpsjl97d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Rosin <peda@lysator.liu.se>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 08:43:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePHd-0004wc-EN
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 08:43:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752320AbZCCHly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 02:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbZCCHlx
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 02:41:53 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5996 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750868AbZCCHlx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 02:41:53 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LePG6-0003Vm-J1; Tue, 03 Mar 2009 08:41:46 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 523DE6B7; Tue,  3 Mar 2009 08:41:46 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <7vbpsjl97d.fsf@gitster.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112015>

Junio C Hamano schrieb:
> I am wondering if it even makes sense to allow users to disable
> topological ordering.
> 
> Doesn't filter-branch have the same "child commits build on top of parent
> commits" dependency as fast-export has?  And didn't you guys fix
> fast-export recently?

Doesn't --date-order have the same guarantee as --topo-order with respect
to parents and children, only that commits that can be rearranged such
that the guarantee remains are emitted in date order?

Anyway, the patch is unnecessary: If --date-order is needed, it can be
passed on the command line; this will override --topo-order.

-- Hannes
