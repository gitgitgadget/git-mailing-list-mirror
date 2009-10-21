From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git gc and kernel.org
Date: Wed, 21 Oct 2009 10:00:23 +0900
Message-ID: <4ADE5D27.2000907@zytor.com>
References: <4ADD6026.8070203@zytor.com> <237967ef0910200208t290d7ba2l15c75081da5448de@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>, ftpadmin@kernel.org
To: Mikael Magnusson <mikachu@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 03:01:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0PZm-0005OF-Ek
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 03:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbZJUBBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 21:01:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752638AbZJUBBG
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 21:01:06 -0400
Received: from terminus.zytor.com ([198.137.202.10]:52798 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752413AbZJUBBF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 21:01:05 -0400
Received: from [192.168.11.29] (p32183-ipbffx02marunouchi.tokyo.ocn.ne.jp [220.106.13.183])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.3) with ESMTP id n9L10SLd011246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Tue, 20 Oct 2009 18:00:30 -0700
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20091014 Fedora/3.0-2.8.b4.fc11 Thunderbird/3.0b4
In-Reply-To: <237967ef0910200208t290d7ba2l15c75081da5448de@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130876>

On 10/20/2009 06:08 PM, Mikael Magnusson wrote:
>
> I don't know how you create repos on kernel.org, but by default both
> git init and git clone uses /usr/share/git-core/templates for the new
> repo, for example I put a symbolic ref h ->  HEAD there to save some
> typing. You can enable whatever hooks you want there, but they would
> only take effect for new repos.
>

They only take effect for new repos, and any changes I do there get 
messed up when git is updated.

	-hpa
