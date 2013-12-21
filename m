From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-mv-submodule
Date: Sat, 21 Dec 2013 17:08:59 +0100
Message-ID: <52B5BD1B.5090705@web.de>
References: <20131221094833.GA7917@wanderlust>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: fREW Schmidt <frioux@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 17:09:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuP71-0005DQ-UB
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 17:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab3LUQJG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 11:09:06 -0500
Received: from mout.web.de ([212.227.15.3]:51142 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753217Ab3LUQJF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 11:09:05 -0500
Received: from [192.168.178.41] ([84.132.132.189]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MXpdL-1VxzdA13Ul-00WjfA for <git@vger.kernel.org>;
 Sat, 21 Dec 2013 17:09:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131221094833.GA7917@wanderlust>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:K592y9HWVtctbkBaOlEExQSDWCjPTnDLDot8BNAsRB201KaXvoy
 GXe5FBWwt19c6z5QAblu3gxXQeevZJeQyz3WX9lysFB2F2DnSA8xz6yeBNZLUpTu2A7M2Qo
 QMkOHeQjN5HX6xOHk6ctwoPGGeAKiRWRf0ijIkrVrl0usa5mKaSk4b2yHPZwjTut243vqHD
 7Uvp+2LoIpa0ZJJx70A1A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239623>

Am 21.12.2013 10:48, schrieb fREW Schmidt:
> Hello all,
> 
> I was on a plane, moving around some of the many (30ish) submodules in
> my dotfiles and got really annoyed at how much work it is (move the
> dir, remove old from git, add new to git, fix .gitmodules, fix
> .git/config, fix all the parts of the submodule config) so I wrote a
> perl script to work for the most common case.
> 
> As far as I know it should work for anyone not doing Something Weird,
> ie manually fiddling with their submodules.  The main case it does not
> support that I'd like to in the future is submodules containing
> submodules, and also at some point I'd like to wrap git mv to invoke
> this script on demand automatically.

Thanks for sharing! Form a cursory look over your perl script it
looks like it does what stock "git mv" will do since 1.8.5 (except
for changing the name of the submodule, which I would not advise
to do when only moving the submodule location in the work tree).
