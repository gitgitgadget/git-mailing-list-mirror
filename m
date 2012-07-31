From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: GIT smart http vs GIT over ssh
Date: Tue, 31 Jul 2012 10:47:05 +0200
Message-ID: <50179B89.4050106@drmicha.warpmail.net>
References: <CACbucKmOxKLpY-iHDpX3GJ7BGsipR9hhXm8UA1hdbNdCzNMMRw@mail.gmail.com> <CACbucKnj5tqtAX5tJRRp+O8MA=tMD_xESsREPcAwffNS6Kvfag@mail.gmail.com> <20120731031011.GA1685@localhost.localdomain> <CACbucKmEAz2BQCA28LObk_4Vk4S+-T2bAHaszNNR6=tH0mj9pg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>, git@vger.kernel.org
To: vishwajeet singh <dextrous85@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 10:47:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sw86k-0004fJ-38
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 10:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932Ab2GaIrI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 04:47:08 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45714 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755833Ab2GaIrH (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 04:47:07 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 37CD5206ED;
	Tue, 31 Jul 2012 04:47:07 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 31 Jul 2012 04:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=raLUmKbC1aCpip0E3SRymR
	e+Ic8=; b=F+VcstMNivmNAEgLwmMjCwfRHXtBBNPaCYMVw7NhYCMQ0FzllmkNF8
	b4yxi4zZhT5Gq4akhT+pEumWdnC1b/uSE6wOO5krcCiQaDpM39o0OPGCBr8E/NS4
	7ppjzrrYlc8sRh9L3oR+idUDiw0CxwMdsxeG0ZeR5c2uWqLc1HSYU=
X-Sasl-enc: tv/bICTEZG0yAiKlCIs2bCaGs/mBGQ6WLnFKrTZr95Yw 1343724426
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 97D3B8E01F7;
	Tue, 31 Jul 2012 04:47:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120717 Thunderbird/14.0
In-Reply-To: <CACbucKmEAz2BQCA28LObk_4Vk4S+-T2bAHaszNNR6=tH0mj9pg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202637>

vishwajeet singh venit, vidit, dixit 31.07.2012 05:19:
> On Tue, Jul 31, 2012 at 8:40 AM, Konstantin Khomoutov
> <kostix+git@007spb.ru> wrote:
>> On Tue, Jul 31, 2012 at 08:36:07AM +0530, vishwajeet singh wrote:
>>
>>> Just wanted to know the difference between smart http and ssh and in
>>> what scenarios we need them
>>> I am setting up a git server,  can I just do with smart http support
>>> or I need to enable the ssh support to use git effectively.
>>> As I understand github provides both the protocols, what's the reason
>>> for supporting both protocols.
>> http://git-scm.com/book/en/Git-on-the-Server-The-Protocols
>> http://git-scm.com/2010/03/04/smart-http.html
>>
> 
> Thanks for the links, I have already gone through those links, was
> looking from implementation perspective do I really need to support
> both protocols on my server or I can just do with smart http and
> what's the preferred way of doing it smart http or ssh
> 
> 

You need to provide what your users demand ;)

Seriously, this is why GitHub and other providers offer both. Not only
are some users more comfortable with one protocol or the other (Win
users don't prefer ssh generally) but some might be able to use only one
because of firewalls or corporate rules.

>From the server perspective, the setup is completely different, of
course. Do you have shell accounts already which you want to reuse for
ssh+git? Do you prefer setting up a special purpose shell account
(gitosis/gitolite) or setting up a web server with authentication?

Michael
