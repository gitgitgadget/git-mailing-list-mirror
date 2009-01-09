From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Use is_pseudo_dir_name everywhere
Date: Fri, 09 Jan 2009 08:22:30 +0100
Message-ID: <4966FB36.2030409@viscovery.net>
References: <1231457063-29186-1-git-send-email-aspotashev@gmail.com> <1231457063-29186-2-git-send-email-aspotashev@gmail.com> <1231457063-29186-3-git-send-email-aspotashev@gmail.com> <4966F6BB.90408@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Alexander Potashev <aspotashev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Fri Jan 09 08:24:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLBit-0008EI-IV
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 08:24:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081AbZAIHWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 02:22:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751570AbZAIHWk
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 02:22:40 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:2761 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZAIHWj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 02:22:39 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LLBhO-0001Vt-A6; Fri, 09 Jan 2009 08:22:30 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 06C024FB; Fri,  9 Jan 2009 08:22:29 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <4966F6BB.90408@viscovery.net>
X-Spam-Score: 0.1 (/)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104985>

Johannes Sixt schrieb:
> Alexander Potashev schrieb:
>> -		if ((ent->d_name[0] == '.') &&
>> -		    (ent->d_name[1] == 0 ||
>> -		     ((ent->d_name[1] == '.') && (ent->d_name[2] == 0))))
>> +		if (is_pseudo_dir_name(ent->d_name))
> 
> Nit-pick: When I read the resulting code, then I will have to look up that
>   is_pseudo_dir_name() indeed only checks for "." and "..". But if it were
> named is_dot_or_dotdot(), then I would have to do that.

... then I would *not* have to do that, of course.

-- Hannes
