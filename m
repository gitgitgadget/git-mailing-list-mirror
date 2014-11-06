From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: Installed git 2.1.3 on sparc 8, but got core dump during 'git
 clone'
Date: Thu, 06 Nov 2014 09:26:50 +0100
Message-ID: <545B30CA.4030803@web.de>
References: <1415251144220-7620692.post@n2.nabble.com> <1415255667304-7620693.post@n2.nabble.com> <1415259507566-7620694.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: victor <liwenxi9999@163.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 06 09:27:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmIPP-0007f1-2k
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 09:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751890AbaKFI1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 03:27:08 -0500
Received: from mout.web.de ([212.227.17.11]:56258 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbaKFI1F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 03:27:05 -0500
Received: from [192.168.2.107] ([79.223.115.228]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Laky4-1YSCjn317A-00kQaT; Thu, 06 Nov 2014 09:26:55
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <1415259507566-7620694.post@n2.nabble.com>
X-Provags-ID: V03:K0:Kvixqnufl1YIvD1KjVFp35l0jJj5M6eD4Q6ESnpfQazXVkg5fzP
 cr3Ccgj/d2iO81Xo8MMdCQhO2CgxX8tFnKv5myhLDvh0FgNoH/mbfdu/4bAsyhXp9sCLmf8
 Z2yrZWTaXndd8BHgClJ3gJRQSJWbts/I3S1BMUJY7pmaFkCpRTR9ZSGWv/j8Us9E19vQS2q
 ybGhm8KUiNaUqgXdk3j1w==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2014-11-06 08.38, victor wrote:
> Hi Jeff,
> 
> Thanks for your help, as your suggestion, I can compile/install git with
> --disable_ptheads now.
It seems as if your Git still wants to create a pthread,
Did you use --disable-pthreads or --disable_ptheads ?
