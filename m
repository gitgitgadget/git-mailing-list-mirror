From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC/PATCH 10/11] branch.c: use 'ref-filter' APIs
Date: Wed, 19 Aug 2015 17:49:47 +0200
Message-ID: <vpq37zf2s84.fsf@anie.imag.fr>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438067468-6835-1-git-send-email-Karthik.188@gmail.com>
	<vpqh9oov017.fsf@anie.imag.fr>
	<CAOLa=ZR6Cu_AgB4sOBX3Tf_M0w8XN57ej8d_fZo+h7pwFDZs+A@mail.gmail.com>
	<vpq3807gdp0.fsf@anie.imag.fr>
	<CAOLa=ZTHRLTbmB7iadc3z7=-pshjR0QS8R_StZb7xOyu_gJ=Sw@mail.gmail.com>
	<vpqbneucddv.fsf@anie.imag.fr>
	<CAOLa=ZTNv7bRMZL_yAGSKxDyBPUBuMQKsybQBg3sKbLzM=m0YQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:50:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZS5co-0006PN-AW
	for gcvg-git-2@plane.gmane.org; Wed, 19 Aug 2015 17:50:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbbHSPty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2015 11:49:54 -0400
Received: from mx2.imag.fr ([129.88.30.17]:53296 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbbHSPtx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2015 11:49:53 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JFnjAP011549
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Wed, 19 Aug 2015 17:49:45 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t7JFnlTj021382;
	Wed, 19 Aug 2015 17:49:47 +0200
In-Reply-To: <CAOLa=ZTNv7bRMZL_yAGSKxDyBPUBuMQKsybQBg3sKbLzM=m0YQ@mail.gmail.com>
	(Karthik Nayak's message of "Mon, 3 Aug 2015 15:50:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 19 Aug 2015 17:49:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t7JFnjAP011549
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1440604186.64979@yx4+hoAJgfujhrG3bWu37A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276198>

Karthik Nayak <karthik.188@gmail.com> writes:

> On Thu, Jul 30, 2015 at 12:59 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>
>> IIRC, historicaly Git allowed some weirdly named refs which made some
>> commands ambiguous (e.g. a branch named after an option like '-d').
>> We're forbidding their creation so people shouldn't have any, but we
>> it's important to continue showing them in case some people have old
>> bad-named branches lying around.
[...]
> Agreed. But then again the warning tells about the broken ref, as in it's name
> So I think It's ok?
>
> for e.g. t1430 :
> [trash directory.t1430-bad-ref-name] ../../git branch
> warning: ignoring ref with broken name refs/heads/broken...ref
> * master

[ Late answer, I'm still catching up with my holiday's emails ;-) ]

OK, the warning gives a different interface but it seems as good as the
old one.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
