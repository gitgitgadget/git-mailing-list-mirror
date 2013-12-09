From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: mv/rm submodules
Date: Mon, 09 Dec 2013 18:49:22 +0100
Message-ID: <52A602A2.6060909@web.de>
References: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: George Papanikolaou <g3orge.app@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 09 18:49:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vq4xV-00045B-LY
	for gcvg-git-2@plane.gmane.org; Mon, 09 Dec 2013 18:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761375Ab3LIRtZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 12:49:25 -0500
Received: from mout.web.de ([212.227.15.4]:58813 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755614Ab3LIRtY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 12:49:24 -0500
Received: from [192.168.178.41] ([84.132.175.50]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MGiLB-1Vm0Tz24Xp-00DZJy for <git@vger.kernel.org>;
 Mon, 09 Dec 2013 18:49:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.1
In-Reply-To: <CAByyCQCakKyUqJQDdFrTMf2CUJihRhqSUVCwT21VDN1EOerVWw@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:JGVPD3I9W0PHZ3BpsTY6Dzl+pjcGddT+4Jol2FLbtE6F6Hj3QqS
 ZvgsJ3uEiUGD8Y64hOaiyz04vEy9kUtnS08Onbq67sI7O0vDKwcCtRUns3qu3J/eXbgnRZ+
 B61bZvPxDqGkgXdZKDf1Hc339lF9xdYmtR9AdHJr6LK+c+NECLJ4XE8SyXA1RlX8o/OX2HQ
 rFYw2RKVFg89dE3nVJs7Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239074>

Am 09.12.2013 11:59, schrieb George Papanikolaou:
> I was just playing with the new features of 'git mv' in 1.8.5 and
> realized that both rm
> and mv don't change the .git/config file. Is that on purpuse?

Yes. Only the "path" entry in .gitmodules needs to be updated
when a submodule is moved. Its name stays the same and thus the
.git/config entry automatically applies to the new location.

> Also after mv you need to run 'submodule update' and I think this should be
> documented somewhere.

You're right, this should be mentioned in the mv man page. I'll
prepare a patch for that.

Thanks for your feedback.
