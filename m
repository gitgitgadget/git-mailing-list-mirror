From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] completion: add new zsh completion
Date: Mon, 30 Jan 2012 12:11:05 +0100
Message-ID: <4F267AC9.1080407@viscovery.net>
References: <1327881699-25461-1-git-send-email-felipe.contreras@gmail.com> <vpqwr89d1p7.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jan 30 12:11:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrp8l-0001Q4-K6
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 12:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab2A3LLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 06:11:10 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:59067 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794Ab2A3LLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 06:11:09 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Rrp8b-0004Pd-Lw; Mon, 30 Jan 2012 12:11:05 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 4D47E1660F;
	Mon, 30 Jan 2012 12:11:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <vpqwr89d1p7.fsf@bauges.imag.fr>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189342>

Am 1/30/2012 9:39, schrieb Matthieu Moy:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
>> +ZSH_VERSION='' . /usr/share/git/completion/git-completion.bash
> 
> Probably stating the obvious, but this path shouldn't be hardcoded.
> 
> Something along the lines of
> 
> ZSH_VERSION='' . $(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
> 
> should do it (mostly untested, and written by a non-ZSH expert).

Moreover, if zsh is POSIX compliant, the value of ZSH_VERSION will be an
empty string after this statement. That may or (more likely) may not be
what you want.

-- Hannes
