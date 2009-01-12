From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH 2/3] Add specification of git-vcs helpers
Date: Mon, 12 Jan 2009 09:13:01 +0100
Message-ID: <496AFB8D.4000803@viscovery.net>
References: <alpine.LNX.1.00.0901110334350.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 09:14:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMHwR-0003u5-J6
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 09:14:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbZALINL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 03:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbZALINL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 03:13:11 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5918 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbZALINK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 03:13:10 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LMHuy-0005eo-Jt; Mon, 12 Jan 2009 09:13:04 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 576C969F; Mon, 12 Jan 2009 09:13:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <alpine.LNX.1.00.0901110334350.19665@iabervon.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105301>

Daniel Barkalow schrieb:
> +NAME
> +----
> +git-vcs-* - Helper programs for interoperation with foreign systems
> +
> +SYNOPSIS
> +--------
> +'git vcs-<system>' <command> [options] [arguments]

The current rule is that helper programs have double-dash in the name:
git-rebase--interactive, git-web--browse, etc.

-- Hannes
