From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v2] git-checkout.txt: Document "git checkout <pathspec>"
 better
Date: Wed, 17 Jun 2015 18:12:10 +0200
Message-ID: <55819C5A.40105@web.de>
References: <558127CB.70603@web.de>
 <CACsJy8CuRcV2Rxaz8Ut4ayW-Hyd8Aao5W4JMc20jcfggOG3d4g@mail.gmail.com>
 <vpq8ubiwqo9.fsf@anie.imag.fr> <mlrmnt$te5$1@ger.gmane.org>
 <vpqoaketusa.fsf@anie.imag.fr> <mlrn9r$9ho$1@ger.gmane.org>
 <vpqtwu6sf4r.fsf@anie.imag.fr> <xmqqoake4akt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "Andres G. Aragoneses" <knocte@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:12:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5Fwr-0001RQ-SD
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 18:12:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756899AbbFQQMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 12:12:18 -0400
Received: from mout.web.de ([212.227.15.4]:62716 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756904AbbFQQMP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 12:12:15 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb004) with
 ESMTPSA (Nemesis) id 0LlsUC-1YVvC71X04-00ZMpX; Wed, 17 Jun 2015 18:12:11
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:38.0)
 Gecko/20100101 Thunderbird/38.0.1
In-Reply-To: <xmqqoake4akt.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:ShUH2bWA4N7Qlgn61rgx484EbHC0joo0tyCN/QHhhmKBmuwkq45
 Ywqlf6rxlxOAt2/qk/LNLEu6GWI5g44eiM33v9AouREUSipLooe2YlbiZo/r+rvkwky3LTO
 ej3W9pFqHGLmW6Hj+FcVyISTlJWcYn+lXhdlPfp2zn4ECszo0tIx9yToR/6eb/RY2fdcWK+
 Y13n1Ard8H7X4np+v14Rg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f/e6FRaTyeo=:i9nFu0GT75Cl71fZ35C0VV
 U9mWl0+pfoZW1xzvk66JWIINGst6Xt0jY2YNjMyFfxdksDpT9mfQbZgKhMV0FxuXdL8f+zeTC
 8vJNCp06wTShol5IqiaJsrN1CfkgOGuIp092gfjhFQdwEz75483bZv5WqnSCiVVMESl+zw3Dh
 wL5HrhtPtSaDFd/EXI4vFDuslIv9fVF6uV7k2IwJOL2va3QKyw/s5KapDwVbt2on/UcKh6Sm7
 DxB6i1ZOPyOaYur/KzIYHe9LIaSpu9+QEGBGjYbz7fkz6l4YmHWXytn6vM1lLwIEZcG/w+ZWJ
 8XuD3cPDvYd30ExwaxqhPiPVSFrypbokZWoXIv888uNSau//c1Lh++BUjKw7k8PVuejC1CM86
 T1/MzxMnPaqRmF7Wubz2cbYzU47XKzlEfnHEYUG0Iy6J02XTzZkG9HJlw5UUJSl90gVP0z7VS
 ekcetYAJBlQDo39I63g8VXQp/bqpo2kfZACtjkmC1sHpfrYzeZLCjSl1isBh04iVsiEwxKMSh
 JrV/Xf+PcI8HR4pdGv9VuDla0QWt6T9bdtBs5IH1bzOmGRoiSavLt9A2Tbswb+0wbhBcBoV3o
 jUdMymgdsYtWiFXH3IuvFP5uTGQCtXtp1qzIzpKQFdXTLoskX36qRmWFpvpaRH17fUnQPMEn9
 fBtGfoRWj1m3jEjEUSfJOexzcdAxyfisqY0Js+CwkJFZ3j5KwlGinP26W2qYAohLLcwA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271862>

On 2015-06-17 17.29, Junio C Hamano wrote:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
>> Yes, but "Switch branchs or discard local changes" still does not
>> describe "git checkout HEAD^^^ -- file.txt" (restore to an old state,
>> but does not switch branch) or "git checkout -- file.txt" (get from the
>> index).
> 
> You are right, especially when file.txt does not have any change
> relative to HEAD, there is no "discarding" going on.  You are
> actively introducing a change to an unchanged file by checking
> contents out of a different revision.
> 
>> To me, "discard local changes" imply that there will be no uncommited
>> changes on the files implied in the command after the operation.
> 
> Yup.
Thanks for the comments.
I agree that we should keep the headline as is.
What is about the the rest of the patch?
Does it makes sense ?
