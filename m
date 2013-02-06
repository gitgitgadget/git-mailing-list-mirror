From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: =?windows-1256?Q?Re=3A_will_git_provide_=60submodule_r?=
 =?windows-1256?Q?emove=60_option_=3F=FE?=
Date: Wed, 06 Feb 2013 22:27:48 +0100
Message-ID: <5112CAD4.8060801@web.de>
References: <BAY176-W2328CE9FE72C92BCB27421B4000@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1256
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Lingcha X <douglarek@outlook.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 22:28:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3CXN-00058K-Kq
	for gcvg-git-2@plane.gmane.org; Wed, 06 Feb 2013 22:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758253Ab3BFV1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 16:27:51 -0500
Received: from mout.web.de ([212.227.15.3]:65389 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758103Ab3BFV1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 16:27:50 -0500
Received: from [192.168.178.41] ([79.193.84.147]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MYNrh-1UPSTt24A5-00VnsE; Wed, 06 Feb 2013 22:27:48
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <BAY176-W2328CE9FE72C92BCB27421B4000@phx.gbl>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:yzWLSntXRWPdYCE0EaPZE0ip1ajRIah4AaI/6KYjZh1
 6YXCgTtAGn8fIlqIogqgM7nMs/YJ1wyjrMV4M07w6K2bJTUm2w
 mhGa09GPW1sebfm7cROxt2oYf/iwQPYZVq1yd9tdk7VqxgNUTz
 s3GK17roF4LCRjFtwYDMo+GgGWGYnGsxhE2QWSFESlTFmpO+fX
 tMUxmI8tOuh5UM5qhM+Rw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215644>

Am 05.02.2013 11:32, schrieb Lingcha X:
> As we all know, git provides `submodule add , init, update, sync, sumary, foreach, status`, but where is `submodule remove`?
> 
> will
>  I not delete one of them sometime in the future? Although most people 
> will not use submodule or one who uses it can remove submodule by hand, providing complete options may be a good idea.

Is assume either "git rm <submodule>" (available since 1.8.1) or the upcoming
"git submodule deinit" (currently in pu) will do what you want?
