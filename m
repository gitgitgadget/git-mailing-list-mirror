From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Is it possible get the tag name of working copy in Git?
Date: Fri, 13 Mar 2015 10:36:06 +0100
Message-ID: <5502AF86.9050803@web.de>
References: <CAFL7HFUNMrTfLx+kj6rBiNeuLhbkPF_t32kOYYSxBP9F=eKSxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: chen chang <chenchangs@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 10:36:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWM1G-0006BL-Vb
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 10:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbbCMJgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 05:36:31 -0400
Received: from mout.web.de ([212.227.15.3]:60524 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbbCMJg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 05:36:27 -0400
Received: from [192.168.88.199] ([194.47.243.242]) by smtp.web.de (mrweb001)
 with ESMTPSA (Nemesis) id 0Lbrk4-1ZFH5X456y-00jHHD; Fri, 13 Mar 2015 10:36:24
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Icedove/31.5.0
In-Reply-To: <CAFL7HFUNMrTfLx+kj6rBiNeuLhbkPF_t32kOYYSxBP9F=eKSxQ@mail.gmail.com>
X-Provags-ID: V03:K0:1PTNL7sudnQ53ikonh4PJX6IpwZKNp3sgSC2e45S4TAW+k0wuUz
 tZYKAm0yfkc/WP+APm4m8KaxQnLmsY2DQxz5S+9fSnJ42B5pkrKgRk6BmOnG1iZiTb7nW4+
 TPS7QxsmPEpfAI3siLzhrMTVip5w9zvYm9tUx0C3GGvHH2da3EX+heC1ppDPZakFdOKLnGe
 SIfoQeJkhXpOaV41GdtJQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265410>

On 03/13/2015 08:08 AM, chen chang wrote:
> I want to use make file auto generate the revision number of working
> copy from the tag name in git.
You should have the tag name, as it is set up before running make,
and probably feed into both "git checkout tagXXYYXX" and the Makefile.

If you want the "version number", what is this ?
Git has a sha value, you can git it like this:

git rev-parse HEAD  | cut -b 1-9

HTH
