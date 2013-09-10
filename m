From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Sep 2013, #02; Mon, 9)
Date: Tue, 10 Sep 2013 18:27:22 +0200
Message-ID: <522F486A.1000705@web.de>
References: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 10 18:27:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJQmr-0001ph-3z
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 18:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170Ab3IJQ13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 12:27:29 -0400
Received: from mout.web.de ([212.227.17.12]:55047 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751872Ab3IJQ12 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 12:27:28 -0400
Received: from [192.168.178.41] ([91.3.174.212]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MRA59-1VO4OH14cp-00UdVI for <git@vger.kernel.org>;
 Tue, 10 Sep 2013 18:27:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqa9jl38ve.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:UZp1Pmp0k6EOeGYPg4xxgWnHLnltsVJsJye5jcvy7a74G+joLyg
 yaRQQFyRFFH39hyWVUeIZIWuRtazKxAyBurXBWUAWPzSSOTMfv2eRmdzE4dbWRTew53vd/X
 RT7nDNIPam1bPqu+Q8y0I77MdYzkXO3B1uhV1YdnN5LabJbg2ss1bWN1nEo6ivtuzfDL+ZR
 kUYYlLQ+arZCuY9urIKPw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234440>

Am 10.09.2013 00:53, schrieb Junio C Hamano:
> * bc/submodule-status-ignored (2013-09-04) 2 commits
>  - submodule: don't print status output with ignore=all
>  - submodule: fix confusing variable name
> 
>  Originally merged to 'next' on 2013-08-22
> 
>  Will merge to 'next'.

I propose to cook this some time in next to give submodule
users who have configured ignore=all the opportunity to test
and comment on that. And as Matthieu noticed the documentation
is not terribly clear here, I'll prepare one or two patches to
fix that which should go in together with these changes.
