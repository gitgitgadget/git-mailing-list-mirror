From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: `git checkout --orpan` leaves a dirty worktree
Date: Sun, 10 Feb 2013 21:10:45 +0100
Message-ID: <5117FEC5.8080109@web.de>
References: <CALkWK0mjf5vsiHvMW-QyzMHdmZQvdzjw_ORJnMd=mT6RCqB1xg@mail.gmail.com> <20130208200402.GB8461@google.com> <CALkWK0mdLabT7XyuYsDCROBC5FX+tDgyMnjMRbdkO41PTWd_Ug@mail.gmail.com> <7vvca2zhkb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:11:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4dFJ-0008FG-2J
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 21:11:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756868Ab3BJUK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2013 15:10:57 -0500
Received: from mout.web.de ([212.227.15.3]:54040 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756794Ab3BJUK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2013 15:10:56 -0500
Received: from [192.168.178.41] ([91.3.153.14]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0LkPrz-1Uf3a72hat-00blgK; Sun, 10 Feb 2013 21:10:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <7vvca2zhkb.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5
X-Provags-ID: V02:K0:b94Ev8BwGtOYyR3w/oBGIePa3izMiCd1vsVWFLkFFLT
 WYTbHZWhSBZF58SfxWtpcPBUAbWhwF8CCOdSm1wcSkQT+9rpdO
 c/vBepYusvJMrJtKDg05JhqJF457OOmbiPgtE0IoCIqKJkkaTL
 jdV/zqAYz9m3Pp6JrUl2UJidWI/iE7TJYRdPIw+HyiTOHwCxu1
 4pCghAjP+M32FoTCbu+4g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215929>

Am 08.02.2013 21:17, schrieb Junio C Hamano:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>> BTW, Is there a better way to clean out the worktree than `git rm -rf
>> .`, since that fails for submodules?  The impulsive `reset --hard`
>> obviously fails because there is no HEAD.
> 
> I _think_ the "git rm" is one of the things on Jens's roadmap.

Hmm, "git rm" does remove submodules since 1.8.1 (but they have to be
cloned with Git 1.7.8 or newer). Or is there something special about
the orphan checkout I'm missing here?
