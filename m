From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Oct 2013, #02; Mon, 14)
Date: Tue, 15 Oct 2013 21:45:49 +0200
Message-ID: <525D9B6D.2090201@web.de>
References: <20131014184524.GW9464@google.com> <20131015001231.GA9464@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 15 21:46:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWAZ1-0004V7-3K
	for gcvg-git-2@plane.gmane.org; Tue, 15 Oct 2013 21:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759689Ab3JOTpv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 15:45:51 -0400
Received: from mout.web.de ([212.227.15.3]:49409 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757374Ab3JOTpv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 15:45:51 -0400
Received: from [192.168.178.41] ([91.3.172.217]) by smtp.web.de (mrweb004)
 with ESMTPA (Nemesis) id 0MY1Am-1VJ3WP2LsO-00UpQs for <git@vger.kernel.org>;
 Tue, 15 Oct 2013 21:45:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <20131015001231.GA9464@google.com>
X-Enigmail-Version: 1.5.2
X-Provags-ID: V03:K0:MY+f/xcZDWjDxlyrkkWxu+sLB3rpz9AlAymGK5+1PBcyeg2jyeK
 2HklFJ9nhES+GadK+qEVotNZljvcjSQvE9FFh8yZcmtNoJ42lYiuMVaur6qS71BDr+Ky9Ft
 Rba0MCbitR1sBOaDmIAicvNNLibJ3om+2ykVvTFx54UaEd9STbULFJvjHbmbgG/TRyiHKMy
 astzwa3+3mun4P4EyGauA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236197>

Am 15.10.2013 02:12, schrieb Jonathan Nieder:
> * jl/submodule-mv (2013-10-13) 1 commit
>  - mv: Fix spurious warning when moving a file in presence of submodules
> 
>  Moving a regular file in a repository with a .gitmodules file was
>  producing a warning 'Could not find section in .gitmodules where
>  path=<filename>'.
> 
>  The test can use a little cleanup.  Otherwise looks good.

What cleanups do you have in mind? The new test is basically a copy from
another one from the same file, so maybe some other tests there need some
cleanups too? ;-)
