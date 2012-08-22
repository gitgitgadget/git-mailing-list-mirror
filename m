From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Wed, 22 Aug 2012 20:50:22 +0200
Message-ID: <004101cd8096$fce3a700$f6aaf500$@schmitz-digital.de>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de> <7v8vd6alqe.fsf@alter.siamese.dyndns.org> <003001cd808b$9d505730$d7f10590$@schmitz-digital.de> <7vk3wq964r.fsf@alter.siamese.dyndns.org> <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de> <7v7gsq94gd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:50:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4G0k-0006s8-Qa
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756116Ab2HVSud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:50:33 -0400
Received: from moutng.kundenserver.de ([212.227.17.10]:57460 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab2HVSub (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:50:31 -0400
Received: from DualCore (dsdf-4d0a052e.pool.mediaWays.net [77.10.5.46])
	by mrelayeu.kundenserver.de (node=mrbap0) with ESMTP (Nemesis)
	id 0MXmrv-1T7t900ruJ-00WqQb; Wed, 22 Aug 2012 20:50:29 +0200
In-Reply-To: <7v7gsq94gd.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHjEtoBTcn41aOpScwQkPT+c62HTAJeVUchAO6Wu9cBkiD+9QGuygBoAMLnBsWXAHoPoA==
Content-Language: de
X-Provags-ID: V02:K0:7lcsnyPvCoDSk6wffX+93N+H21cnxhcg4jST8nbouyY
 NMwtFuipSSnQOuZqC8Fp/gM6mH8fg8Nn5R/9EwzWaFJGTPe5D8
 yiPxmFzH3HGquaP9Jxkia/Mu1S7ojIYhBQF0MAw+Fz2wvpqR1i
 VWvpNW/Q1egXBoNPUBEpbrlhdsFzw50yHOTm3TVJeiP0Jo44hf
 tMvujiLKpDlXQjMpKxS9t4DK/UYDCjCxpE0+nh7pROYd2WkI0d
 uFr70NwmQs8NYWLLJVJB5B4r6iY5SEccF2np9tXBCksF5d6kSn
 X8pYpMe/W8NDymcJi24W3R2Pdo3aK4YDWF2hFvOIEPfDcmXlSH
 QtEA7dH3q/p3LUWU57p4UOMMb+LCJJw+eJwSag8LdMxxHLmWYl
 AcCIyVOYKDcoA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204066>



> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Wednesday, August 22, 2012 8:17 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >
> > This reverts be22d92 (http: avoid empty error messages for some curl
> > errors,
> > 2011-09-05) on platforms with older versions of libcURL.
> >
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> > ---
> >  http.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/http.c b/http.c
> > index b61ac85..18bc6bf 100644
> > --- a/http.c
> > +++ b/http.c
> > @@ -806,10 +806,12 @@ static int http_request(const char *url, void
> > *result, int target, int options)
> 
> Likewrapped X-<

Any suggestion?
