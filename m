From: Konrad Scherer <Konrad.Scherer@windriver.com>
Subject: Re: Git: How to keep multiple bare repos in sync?
Date: Thu, 14 May 2015 09:11:28 -0400
Message-ID: <55549F00.5030101@windriver.com>
References: <2015051312090840845945@126.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 7bit
To: chenxitwo <chenxitwo@126.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 14 15:11:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YssvZ-0003jX-Hk
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 15:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933438AbbENNLo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 09:11:44 -0400
Received: from mail.windriver.com ([147.11.1.11]:32861 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933315AbbENNLh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 09:11:37 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t4EDBUu4000192
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 14 May 2015 06:11:31 -0700 (PDT)
Received: from [128.224.23.129] (128.224.23.129) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.224.2; Thu, 14 May
 2015 06:11:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <2015051312090840845945@126.com>
X-Originating-IP: [128.224.23.129]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269039>

On 2015-05-13 12:09 AM, chenxitwo wrote:
> There are three git server(bare repos), but i don't know to solve the
> problem that how to keep these git servers in sync.

I am using grokmirror[1] to mirror 600+ git repositories across three 
datacenters. It syncs quickly and efficiently. The setup is a bit 
complicated (it requires python, python git libraries and a webserver). 
There are packages for Fedora. It all depends on how many repos you are 
trying to mirror.

[1]: https://github.com/mricon/grokmirror
