From: Patricia Bittencourt Egeland <pbegeland@linea.gov.br>
Subject: Re: how to check pending commits to be pushed?
Date: Thu, 28 Feb 2013 17:32:42 -0700
Message-ID: <6A41B50E-A274-4572-98CF-4AE9CA6820E2@linea.gov.br>
References: <C89CA603-2D94-44DB-8576-A296BAB5DA53@linea.gov.br> <kgo9d6$oru$1@ger.gmane.org>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1485\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Joachim Schmitz <jojo@schmitz-digital.de>
X-From: git-owner@vger.kernel.org Fri Mar 01 02:07:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBERH-0002pm-CJ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 02:07:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082Ab3CABGl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2013 20:06:41 -0500
Received: from mailout17.yourhostingaccount.com ([65.254.253.140]:44771 "EHLO
	mailout17.yourhostingaccount.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751855Ab3CABGk convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2013 20:06:40 -0500
X-Greylist: delayed 2030 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2013 20:06:40 EST
Received: from mailscan02.yourhostingaccount.com ([10.1.15.2] helo=mailscan02.yourhostingaccount.com)
	by mailout17.yourhostingaccount.com with esmtp (Exim)
	id 1UBDu4-0004DY-F6
	for git@vger.kernel.org; Thu, 28 Feb 2013 19:32:48 -0500
Received: from impout02.yourhostingaccount.com ([10.1.55.2] helo=impout02.yourhostingaccount.com)
	by mailscan02.yourhostingaccount.com with esmtp (Exim)
	id 1UBDu3-0001TE-Ql; Thu, 28 Feb 2013 19:32:47 -0500
Received: from authsmtp10.yourhostingaccount.com ([10.1.18.10])
	by impout02.yourhostingaccount.com with NO UCE
	id 60Yn1l00M0D2B7u010Ynb4; Thu, 28 Feb 2013 19:32:47 -0500
X-Authority-Analysis: v=2.0 cv=HIVB5/Rv c=1 sm=1
 a=KW/L2U7X8cySBEjBjYk5eg==:17 a=Qa21fcannPsA:10 a=oEvEc7kAb_wA:10
 a=8nJEP1OIZ-IA:10 a=niRPyrMlA9wA:10 a=VwQbUJbxAAAA:8 a=ZUUlr_48YtwLPIN1TIIA:9
 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=HA2AdBAGp7EA:10
 a=2gI1vAumJwWs0gD4Ojj1yg==:117
X-EN-OrigOutIP: 10.1.18.10
X-EN-IMPSID: 60Yn1l00M0D2B7u010Ynb4
Received: from host-184-166-132-193.bzm-mt.client.bresnan.net ([184.166.132.193] helo=[10.0.1.19])
	by authsmtp10.yourhostingaccount.com with esmtpa (Exim)
	id 1UBDu3-00025b-I1; Thu, 28 Feb 2013 19:32:47 -0500
In-Reply-To: <kgo9d6$oru$1@ger.gmane.org>
X-Mailer: Apple Mail (2.1485)
X-EN-UserInfo: 957f87d35c43172285e6793414996149:be26a490d08ddddd1ae22626b86f1c91
X-EN-AuthUser: patricia@egeland.us
X-EN-OrigIP: 184.166.132.193
X-EN-OrigHost: host-184-166-132-193.bzm-mt.client.bresnan.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217264>

Inside the super repo, I used "git submodule foreach", that way (which worked fine):
git submodule foreach "git status || true"

No idea why the line bellow didn't work:
git submodule foreach "git status"

Thanks,
Patricia

On Feb 28, 2013, at 11:58 AM, Joachim Schmitz <jojo@schmitz-digital.de> wrote:

> Patricia Bittencourt Egeland wrote:
>> Hi,
>>     Does someone know how to identify pending commits to be pushed
>> in a local super repository (with quite some submodules), with
>> git-1.6.5-1 ?  
> 
> git status ?
> 
> Bye, Jojo
> 
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
