From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH amend] git-config: print error message if the config file
 cannot be read
Date: Fri, 12 Oct 2007 13:59:44 +0200
Message-ID: <470F61B0.40907@viscovery.net>
References: <20071009125102.1305.qmail@054bd0fc8effa5.315fe32.mid.smarden.org> <470B8286.5060006@viscovery.net> <20071012114057.30803.qmail@12f4c67b8560e2.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Gerrit Pape <pape@smarden.org>
X-From: git-owner@vger.kernel.org Fri Oct 12 14:00:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgJBO-0003RV-K1
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 13:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757150AbXJLL7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 07:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757094AbXJLL7t
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 07:59:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:13206 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757055AbXJLL7s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 07:59:48 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IgJB2-0006cg-8x; Fri, 12 Oct 2007 13:59:37 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 8C7BD4E4; Fri, 12 Oct 2007 13:59:44 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071012114057.30803.qmail@12f4c67b8560e2.315fe32.mid.smarden.org>
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60681>

Gerrit Pape schrieb:
>> You probably want to see an error message *only* if you have supplied
>> a file name with --file.
> 
> I changed the patch to die() only if --file was sepcified, and errno is
> not 0.

Thanks. I can live with that. ;)

-- Hannes
