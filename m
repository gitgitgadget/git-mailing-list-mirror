From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH 1/2] sequencer: trivial fix
Date: Wed, 29 May 2013 13:13:24 +0200
Message-ID: <001601ce5c5d$89974830$9cc5d890$@schmitz-digital.de>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>	<1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>	<20130528110014.GA1264@hmsreliant.think-freely.org>	<7vobbv2fze.fsf@alter.siamese.dyndns.org>	<51a568db9c9b8_807b33e18996fa@nysa.mail>	<ko4jf7$e4d$1@ger.gmane.org> <CAMP44s0vARKGsn2noBEAxSVHD1bkU9pR7nPCvFJwp5epwidkQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Felipe Contreras'" <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 29 13:13:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UheJv-0001Ix-5k
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 13:13:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965655Ab3E2LN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 07:13:28 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:61586 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965579Ab3E2LN1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 07:13:27 -0400
Received: from DualCore (dsdf-4db5271a.pool.mediaWays.net [77.181.39.26])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LpPi1-1UBMQq2oBp-00f4fD; Wed, 29 May 2013 13:13:25 +0200
In-Reply-To: <CAMP44s0vARKGsn2noBEAxSVHD1bkU9pR7nPCvFJwp5epwidkQw@mail.gmail.com>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQIZRmwJ3YD97SQ9HOHpf/nu9snqLwILqjWaAN8L5zUCjtBjewKk33BDAcf4QhQBowjOiJgp4lBA
Content-Language: de
X-Provags-ID: V02:K0:zMfCxOrH+T+D2mjRgL9H1EeI6hk12ugfAZqo/FTBBpY
 alBbsMLqNIpjEtcMQUfBSTmx+Fo6A7PH5jBSDWf0EKHTM5BSo+
 cJF2VchCOhqJ56TnLu718jKC9rmO3Mz37XyE1BQYPb6uMO1E7d
 XnIlp/s9eZr5fh65edXrWSB2eX8Gq5+o4eQp8dHLvKFVrx+gCd
 KRxn0THevoGwnEnQAeTsT5U2eg/h3vilJQRIs/8PAPHgIgrIB7
 /BMBnVk8WmYADoVdxkxMq2PQlpQxoeC8Ecszo1QtY3WZrGSF34
 3TzdSTOE7v8FXK+BR9C5kees1VGr0OgfNC+RGE3/+apXn6mVLa
 dWOyrTngrWrj2/p32Nri8IICqRxz99Z7fsFciAZv+xeX+pi2Sc
 a7MDrtahVly9A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225786>

> From: Felipe Contreras [mailto:felipe.contreras@gmail.com]
> Sent: Wednesday, May 29, 2013 12:52 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH 1/2] sequencer: trivial fix
> 
> On Wed, May 29, 2013 at 4:58 AM, Joachim Schmitz
> <jojo@schmitz-digital.de> wrote:
> > Felipe Contreras wrote:
> >>
> >> Junio C Hamano wrote:
> 
> >>> It probably is better to fold this patch into the other one when it
> >>> is rerolled to correct the option name gotcha "on the tin".
> >>
> >>
> >> Why? This patch is standalone and fixes an issue that is independent
> >> of the other patch. Why squash two patches that do *two* different
> >> things?
> >>
> >> Anyway, I'll happily drop this patch if you want this memory leak to
> >> remain. But then I'll do the same in the other patch.
> >>
> >> This mantra of avodiing 'goto' is not helping anybody.
> >
> >
> > adding 5 letters (to change the next "if" into an "else if") versus your
> > addition of several lines and some 15 additional letters (ignoring the
> > whitsspace)  is IMHO enough to see what is better?
> 
> This has nothing to do with what Junio said. 

Well, it has, but you had snipped it. But replied to the goto issue regardless

> This is better done without "goto" in general.

Bye, Jojo
