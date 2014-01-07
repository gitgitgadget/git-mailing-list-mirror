From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: What's cooking in git.git (Jan 2014, #01; Mon, 6)
Date: Tue, 07 Jan 2014 18:49:10 +0100
Message-ID: <52CC3E16.4060909@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 07 18:49:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0amI-0000eR-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 18:49:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136AbaAGRtT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 12:49:19 -0500
Received: from mout.web.de ([212.227.15.4]:62402 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752388AbaAGRtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 12:49:18 -0500
Received: from [192.168.178.41] ([84.132.139.6]) by smtp.web.de (mrweb103)
 with ESMTPA (Nemesis) id 0LqUXd-1VWBu116lV-00e1hg for <git@vger.kernel.org>;
 Tue, 07 Jan 2014 18:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:Khsbds+AGT0fySVFopNfDVOnDj0gZcMTIYjdmFwVa2Z2Aby2hOF
 1S8/e+Ym8H070vBcw/v0UZNAywrYpNbD8KIHhimMe7qaJUedjA0ze66O85ic1S5HKDkSMu/
 /NH2dBY4J1eDNG184KSsfue5EXw9SYw/I82DXDw2nucDvXM27MTXjps78/qZDJSaa1E2w7m
 SMDNdlzT0WXEeiciT/jiA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240117>

Am 06.01.2014 23:36, schrieb Junio C Hamano:
> * jl/submodule-recursive-checkout (2013-12-26) 5 commits
>  - Teach checkout to recursively checkout submodules
>  - submodule: teach unpack_trees() to update submodules
>  - submodule: teach unpack_trees() to repopulate submodules
>  - submodule: teach unpack_trees() to remove submodule contents
>  - submodule: prepare for recursive checkout of submodules
> 
>  What is the doneness of this one???

It's still work in progress. Currently I'm working on a test
framework so we can reuse recursive submodule checkout tests
instead of rewriting them for every command that learns the
--recurse-submodule option. Will reroll this series as soon
as I have something presentable.
