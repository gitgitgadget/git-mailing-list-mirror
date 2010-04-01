From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Thu, 01 Apr 2010 08:38:52 +0200
Message-ID: <4BB43F7C.8070003@web.de>
References: <4B67227A.7030908@web.de> <4B898F97.90706@web.de> <7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> <4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de> <32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> <7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA1FC39.10300@web.de> <32541b131003180936x746dad06k386788d3cb6fcdeb@mail.gmail.com> <b4087cc51003181019r4408953bxcd5049c9521b8173@mail.gmail.com> <4BA3329E.6050304@web.de> <4BB21F6D.7070804@web.de> <7vd3ylv4oq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael Witten <mfwitten@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 01 08:39:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxE3W-0005dd-VN
	for gcvg-git-2@lo.gmane.org; Thu, 01 Apr 2010 08:39:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753669Ab0DAGjA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 02:39:00 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:39074 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753657Ab0DAGi7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 02:38:59 -0400
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 18D8614A57673;
	Thu,  1 Apr 2010 08:38:58 +0200 (CEST)
Received: from [78.49.37.65] (helo=[192.168.1.2])
	by smtp05.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1NxE3N-0001QZ-00; Thu, 01 Apr 2010 08:38:58 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7vd3ylv4oq.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1+p/fU5lGitd3ZG0op08GJ3yYAAr0IfxMDimg+y
	om8M4pAUynukXDOvM9Sk27YtoQkpHuKjTMDpqNxFOAwXRQb1+C
	cemCmtKdAw90WBjrF4mw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143719>

> In such a case, you may want retry the command after recording
> the local changes (1) in a temporary commit on the current branch,

Should corresponding work flow actions be also mentioned to clean up such
"temporaries"?


> or (2) by using "git stash".

Do we need a new feature "stash per branch" here?

Will an option be useful to specify that uncommitted changes can be overwritten
by data from the branch switch?

Regards,
Markus
