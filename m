From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fsck: it is OK for a tag and a commit to lack the body
Date: Mon, 29 Jun 2015 07:12:38 +0200
Organization: gmx
Message-ID: <32aa1979e75ba9bc6dc8a58fe32e9e55@www.dscho.org>
References: <20150625155128.C3E9738005C@gemini.denx.de>
 <xmqqegkzzoaz.fsf@gitster.dls.corp.google.com>
 <20150625201309.5026A384E81@gemini.denx.de>
 <xmqqegkzy1ri.fsf@gitster.dls.corp.google.com>
 <2b124e09d9c89ff3892f246ea91aa3c4@www.dscho.org>
 <xmqqoak3wkkq.fsf@gitster.dls.corp.google.com>
 <xmqqbng3wheu.fsf@gitster.dls.corp.google.com>
 <d455a77d76b3558fb79d550d6ed4468d@www.dscho.org>
 <20150626155248.GB30273@peff.net>
 <xmqqlhf3elxk.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 07:12:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9RND-0006br-BJ
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 07:12:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbbF2FMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 01:12:46 -0400
Received: from mout.gmx.net ([212.227.17.22]:59710 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751080AbbF2FMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 01:12:44 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Las1k-1Yl9BA1lKS-00kOME; Mon, 29 Jun 2015 07:12:40
 +0200
In-Reply-To: <xmqqlhf3elxk.fsf_-_@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:NBQ/S+rovAAD1l203cZeFFdu3vcubGVnJK87zd3GdGfwQsPmHoy
 DMX3tjbhYRBlKvF1DDNuTLUhjqEAtRbU0CLk69lR1Z298z94f0pmbxAXAfKBdf9Gu1nycmy
 mFaKk5GIL2d8gGYVQU7OnWvm/nZFIKeVxtyUybjaE9vCTgBoAwxT9SZX/ktfIZRGIkM2fAu
 aUiwNpeozJHwARj/GZ62g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jRv/PZVk7h4=:kXWaL7bQsJ/xyH1QOdK5We
 oecPFNr6yuThXwWVot2WCRcmXBS/oS+S7Zf3vdbJGoy/+62G4/8xBJ0Sn0wBU92xwzk+LMZqk
 EtUnrCyY8zadMF8hX0uAc4UAzP5ucKshfVbTeC1QJLDaUOE++R98vJ04vdYkMqKDQYDePliAD
 2Go7r0RqJ8DNXmSXYU42trUDms6T378FDlLKFUUg9jJIfj2Sm7x6pndli6aKsSzxXG9pc5VmE
 zzEF49Vi/J5fIQkLJ3jl9fldJTougJcdz2Gubtoez49Sif+AZktL4CJ33la3bZeBkmZVbSBYi
 MWk+BUK/O3/9NNJYiSetpH9lqlYSJ3Ur2SuURV9/Ayq7x/YNVTeGUlEWbp/X89Y5f84Xmvbt8
 Hb2BEyI95uZcffjvRE/dPy7g0fF+TGFvSSw+Mk3jiHd9fb3l6m3eDSdbJX74LdgejuOVeml/X
 xTUUjNJEuiVV1Nu8OI/phksscn06MIi33TdtCCbNLf/vYDs6lQx5w17cAVva9Zr0M3Mi8TOhL
 5M88fNJZp1kkZTexSK1RlreZIbdVVlzFoPxuJP9jL+JfrQ1NNfS5DolUkEA+iSS9qqqIFuBj1
 zDmWljfLgmyNLVy0FxjXmHg9WQsi2NUB/74ilFvDEByfHnydQ+3rcoLZ/IZtcL27dMuG5DCtA
 2+78i8u4vu75pKh5xEo3n53ZafSHrGk5MreziWj56VCYG6jVyUcpoaZklD7ObwnNPvzc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272939>

Hi Junio,

On 2015-06-28 20:18, Junio C Hamano wrote:
> diff --git a/fsck.c b/fsck.c
> index 88c92e8..3f264e7 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -255,6 +255,15 @@ static int require_end_of_header(const void
> *data, unsigned long size,
>  		}
>  	}
>  
> +	/*
> +	 * We did not find double-LF that separates the header
> +	 * and the body.  Not having a body is not a crime but
> +	 * we do want to see the terminating LF for the last header
> +	 * line.
> +	 */
> +	if (size && buffer[size - 1] == '\n')
> +		return 0;
> +
>  	return error_func(obj, FSCK_ERROR, "unterminated header");
>  }
>  

Hmm. Maybe we should still warn when there is no empty line finishing the header explicitly, or at least make it FSCK_IGNORE by default so that maintainers who like a stricter check can upgrade the condition to an error?

Otherwise: ACK.

Ciao,
Dscho
