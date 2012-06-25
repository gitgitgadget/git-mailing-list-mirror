From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git diff --ignore-submodules fails if submodule is inaccessible
Date: Mon, 25 Jun 2012 18:59:37 +0200
Message-ID: <4FE898F9.5050409@web.de>
References: <CAGHpTBL=hHazYv09KxADi3xa5s1TM2KNFteg4E=uW0WYDy_kxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Orgad and Raizel Shaneh <orgads@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 18:59:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjCdc-0004Vg-BG
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jun 2012 18:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757384Ab2FYQ7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jun 2012 12:59:40 -0400
Received: from mout.web.de ([212.227.15.3]:52644 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201Ab2FYQ7j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2012 12:59:39 -0400
Received: from [192.168.178.48] ([91.3.156.12]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0Ldn19-1S1vir16ln-00iP2V; Mon, 25 Jun 2012 18:59:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <CAGHpTBL=hHazYv09KxADi3xa5s1TM2KNFteg4E=uW0WYDy_kxA@mail.gmail.com>
X-Provags-ID: V02:K0:MImkB5/XLJnBTbA4selnGDxBLaZ+taRtJ4zvr3KHtmG
 eXUmG/ftQjYlaSzvSOtqG6jB0JelGO3c8RQSzHhEkVcOktV6Pd
 5m6i/9v3IanNIJzNoHd1s07hUq+Yu9mQHInWEcPvwWT9JL6kL1
 B/9xSlnDWXpRN5mHEoJ1xk6ctxhGuWMRpHzcCOUf0qA33h05+u
 bL4CekrhGUVCW53YkQR3w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200585>

Am 25.06.2012 17:01, schrieb Orgad and Raizel Shaneh:
> I have a submodule set up with a gitfile which points to an absolute path.
> 
> Trying to access the superproject from the network, running 'git diff
> --ignore-submodules' yields 'fatal: Not a git repository:
> <submodule-absolute-path>'.
> 
> It should really ignore submodules when requested...

Yes. I can reproduce that here and will look into it.
