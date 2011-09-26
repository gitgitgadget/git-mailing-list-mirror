From: Georg-Johann Lay <avr@gjlay.de>
Subject: Re: subversion-perl missing
Date: Mon, 26 Sep 2011 18:49:31 +0200
Message-ID: <4E80AD1B.3080700@gjlay.de>
References: <4E8066AB.7000208@gjlay.de> <CAP8UFD0PiiA9SxvOuuh4t8P96v+iaJ0TfcBr1-xjMh4TXBEONQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 26 18:49:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8ENL-0007sC-Up
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 18:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447Ab1IZQtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 12:49:47 -0400
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:19550 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191Ab1IZQtr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 12:49:47 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; t=1317055785; l=1345;
	s=domk; d=gjlay.de;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Subject:CC:To:MIME-Version:From:Date:X-RZG-CLASS-ID:X-RZG-AUTH;
	bh=5vsYQeqslEuAhve60xUYxRSn41k=;
	b=Q8mL24OOVO92Ymn8vPmmOUPXMfptWyjhVQlsncxq+PMHixJgcEoV/97QqlHPF+BdhIn
	5zPqp0KdRTP9R1Zp9Wj8l9ezfzsf3Dnz+hMk7ae7gtqR1NVzM9uMjNz+QwVGfxrXPjQuA
	jc1RK9yAqsGGPesXv6ogytPROYlT2CyFmVQ=
X-RZG-AUTH: :LXoWVUeid/7A29J/hMvvT2k715jHQaJercGObUOFkj18odoYNahU4Q==
X-RZG-CLASS-ID: mo00
Received: from [192.168.0.22]
	(business-188-111-022-002.static.arcor-ip.net [188.111.22.2])
	by smtp.strato.de (cohen mo48) (RZmta 26.7)
	with ESMTPA id R06257n8QGV2Hq ; Mon, 26 Sep 2011 18:49:31 +0200 (MEST)
User-Agent: Thunderbird 2.0.0.24 (X11/20100302)
In-Reply-To: <CAP8UFD0PiiA9SxvOuuh4t8P96v+iaJ0TfcBr1-xjMh4TXBEONQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182132>

Christian Couder schrieb:
> Hi,
> 
> On Mon, Sep 26, 2011 at 1:48 PM, Georg-Johann Lay <spam@spam.com> wrote:
>> Where do I have to go to get the svn+perl stuff? Couldn't locate anything like
>> that in subversion.tigris.org, so that I am stuck and need some hints on how to
>> proceed.
> 
> Perhaps you can try to install this module from CPAN:
> 
> http://search.cpan.org/~mschwern/Alien-SVN-v1.6.12.1/
> 
> or from it's github repo:
> 
> https://github.com/schwern/alien-svn

Hi Christian,

thanks for that hint.

After getting that piece of software, running ./Build.PL and ./Build I just
don't know what to do next.  The README doesn't say anything about how to use
the built modules or how to do an install.

As git-svn complains

...Can't locate SVN/Core.pm in @INC (@INC contains: ...

and

 schwern-alien-svn-9298884>find . -name 'Core.pm'
./src/subversion/subversion/bindings/swig/perl/native/Core.pm
./src/subversion/subversion/bindings/swig/perl/native/blib/lib/SVN/Core.pm

the question is how to do the final trick of telling git how to use Core.pm
(and which of the two?) and do the connexion between git and alien-svn.

Sorry for the noob questions, never used perl or git before...

Johann

> Regards,
> Christian.

p.s. is it possible not to open quote e-mail addresses in mailing lists?
