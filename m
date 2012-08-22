From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 23:05:47 +0200
Message-ID: <004601cd80a9$e79bace0$b6d306a0$@schmitz-digital.de>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de> <7v8vd6alqe.fsf@alter.siamese.dyndns.org> <003001cd808b$9d505730$d7f10590$@schmitz-digital.de> <7vk3wq964r.fsf@alter.siamese.dyndns.org> <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de> <7v7gsq94gd.fsf@alter.siamese.dyndns.org> <004101cd8096$fce3a700$f6aaf500$@schmitz-digital.de> <7vwr0q63po.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 23:06:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4I7o-0001HZ-Mg
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 23:06:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933190Ab2HVVF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 17:05:59 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:53052 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab2HVVF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 17:05:58 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0M96Lt-1SwLUt1PzB-00CPwA; Wed, 22 Aug 2012 23:05:54 +0200
In-Reply-To: <7vwr0q63po.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHjEtoBTcn41aOpScwQkPT+c62HTAJeVUchAO6Wu9cBkiD+9QGuygBoAMLnBsUBv8N3IgG0C8qlluUJh8A=
Content-Language: de
X-Provags-ID: V02:K0:D0Ks5hFZ6tu44yZVWQoNaskXM6RtGBtwG05uKQq2Rui
 WSSZo6+FTmq3vAIEw0Dw0GYKWTHxVi8FsVM/i3JUBI71F3ZbUY
 bE8TO1eDCfh6R0OXCNXVJZI/8+dAMJ33BjBgL/axs+lzYRJI+J
 e5LZ4hEgfkf8ta+k4W0zTFBMVoV30hLKqyci/5WLKzNQmxUGij
 LfrelcMQnA1WNHLVT4k97b2oYAikpgooLcsgwV4UiK3bET+yqU
 6uMR4GO8HyB9WVRPBn33JTiPh4sie4RYQ+7ajon7pOWxrSDX2O
 3KRYEAszQR06CncPJ9cHkz5Zd6lhO0TED+HZOrgTvGWMrbJOCU
 xLx9C+weSJMcznUTnoOcEARCtP5dOkSovuvd212SsaHjECHJfp
 oWo+OakzF8KKw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204097>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 11:02 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> > diff --git a/http.c b/http.c
> >> > index b61ac85..18bc6bf 100644
> >> > --- a/http.c
> >> > +++ b/http.c
> >> > @@ -806,10 +806,12 @@ static int http_request(const char *url, void
> >> > *result, int target, int options)
> >>
> >> Likewrapped X-<
> >
> > Any suggestion?
> 
> Other than "don't wrap" (or "get a real MUA and MTA" X-<), unfortunately
no.
> 
> I do not know if you have checked MUA specific hints section of
> Documentation/SubmittingPatches; there may be environment specific hints
> described for a MUA you may have at hand (or not).

I checked, but Outlook isn't mentioned :-(

Bye, Jojo
