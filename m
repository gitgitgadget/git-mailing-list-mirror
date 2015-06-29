From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] fsck: it is OK for a tag and a commit to lack the body
Date: Mon, 29 Jun 2015 16:51:03 +0200
Organization: gmx
Message-ID: <27498b4f0033a332e961de055ca226f1@www.dscho.org>
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
 <32aa1979e75ba9bc6dc8a58fe32e9e55@www.dscho.org>
 <xmqqsi9bcboq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Wolfgang Denk <wd@denx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 29 16:51:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z9aPb-00063M-H4
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jun 2015 16:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbbF2OvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2015 10:51:25 -0400
Received: from mout.gmx.net ([212.227.17.22]:61990 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197AbbF2OvJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2015 10:51:09 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MBrCt-1ZJnPq3tDz-00Alpf; Mon, 29 Jun 2015 16:51:05
 +0200
In-Reply-To: <xmqqsi9bcboq.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:Z/dYCeX7WSVhKKjldM7pXnG2eMfA9MkQ7Daocd0xRSNOrhHx3Fn
 8Uf8tNysCv6slLsDzOMJ3b7cOU5l7FLd/KYsBfSw/nUabsTZnW3rdnvdCQLNdSegMredmv4
 ZOjrMou25potQJRrUpMw7T5ZUUfmwSpOXnq3GPM5RL7l2ILtpIAl3pJF4In5KX+YLoERH+k
 cekpTZ7ECB6WHQg2K7hHQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AQc3VanPgvA=:jvlA8Q9cgqIv6ztqKvizz9
 fudNCiQBTx5YVjbP5usNNuYBjoIecflyfsrODBFkmVzN1wSUMmb5VzNO6F3f5K4EdrN/wMLZD
 kK2Lni2hv/N0rOSka8w0ftfcbSwEkTZCFz15CC9rtA72qYw3OLSpsm+OGgkCoyD4t7U7wdspS
 1z888lIeXifZaR1Yp48DM5ZkS4J/ukOzbN8inJF9iaUDRX9BdspBGzD/joh0oyKu3B7lfW8EF
 J+rODVhFd9AyyaW37kSnXlj9CZSWQzh8k9WhGLispGUv8iGwFdQhyNPz3RGM/PJyEHu1KXNZ/
 3c+ghbknpEdoAOPaTaGM6waeu8Bmga+poWf1MgAwdlplRYO1B+MhIJhdeexbJiN23glvieVN+
 hU2zQJrJhVs1wvwCB+n9lOt5s4knlEDJqrMlfRhrtPRTDQMpRYde7opAKyetD1HjmZ93LjZl/
 h6fDfVFYD0BhNn3i3wbE5umokVDic+p8FWOXfCk19fW90ZNoymOemDBkLCmB4JWc/8KQW8Zpc
 i2SNMWTgmOQyyxFvavZq3UCqLNP+DLujSjm0PcWgqx9dIObJBBcdqratCaehSQHe4U9/L1Owp
 PH3MFN68DSuDYgDK9XE/XPdpZ2iyvnqok6rk4GjLzPR5OaUvV2Kf7kdeZUmkO2wrFt2ANe8VI
 lMpLG8fke8vaZckp8Zl+jwkmF1eAZtp+1CRdBUJC5fmXqbjrc/7x9xdI+nG74XAkCXOI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272954>

Hi Junio,

On 2015-06-29 07:42, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> Hmm. Maybe we should still warn when there is no empty line finishing
>> the header explicitly, or at least make it FSCK_IGNORE by default so
>> that maintainers who like a stricter check can upgrade the condition
>> to an error?
> 
> [...]
> 
> And such a check can certainly be added in the future

True. I take my suggestion back.

Thanks for the reality check,
Dscho
