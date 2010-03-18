From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Thu, 18 Mar 2010 11:11:05 +0100
Message-ID: <4BA1FC39.10300@web.de>
References: <4B67227A.7030908@web.de> <7vhbq0wuy6.fsf@alter.siamese.dyndns.org> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> <7vaau6q18q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Michael Witten <mfwitten@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 11:11:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NsChH-0001fa-Cf
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 11:11:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251Ab0CRKLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Mar 2010 06:11:14 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:59697 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab0CRKLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Mar 2010 06:11:12 -0400
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0C717145744CE;
	Thu, 18 Mar 2010 11:11:11 +0100 (CET)
Received: from [85.179.97.38] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #4)
	id 1NsCh4-0005hT-00; Thu, 18 Mar 2010 11:11:10 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.8) Gecko/20100228 SUSE/3.0.3-1.1.1 Thunderbird/3.0.3
In-Reply-To: <7vaau6q18q.fsf@alter.siamese.dyndns.org>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX193keOri96/lE4nv4/YeR4dcAAbi5TjL7E/utQW
	qlbbzlpZGZ/SL8tmDrcB2ZXTKy94RzOfbkMIWj1mO8ToqiU+ZE
	NLau6UQIHjatXegUHT8g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142455>

> You may want retry the command after recording the local changes
> (1) in a temporary commit on the current branch,

Can commits be consistently marked for intermediate use?
Can such "special" commits be easily found later on?


> or (2) by using "git stash".

Is this storage operation supported per branch?
Does a checkout look if any files were stashed away for the specified branch before?

Regards,
Markus
