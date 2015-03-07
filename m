From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: [PATCH] daemon: use strbuf for hostname info
Date: Sat, 07 Mar 2015 11:49:49 +0100
Message-ID: <54FAD7CD.4020408@web.de>
References: <54F96BF2.5000504@web.de> <20150306210627.GA24267@peff.net> <54FA4446.5050103@web.de> <20150307010832.GB8202@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 07 11:50:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YUCJH-0002ov-Mc
	for gcvg-git-2@plane.gmane.org; Sat, 07 Mar 2015 11:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753903AbbCGKuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Mar 2015 05:50:14 -0500
Received: from mout.web.de ([212.227.17.11]:54481 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbbCGKuM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Mar 2015 05:50:12 -0500
Received: from [192.168.178.27] ([79.250.190.19]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MMEzJ-1YOxVK2gV3-0086tr; Sat, 07 Mar 2015 11:50:07
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150307010832.GB8202@peff.net>
X-Provags-ID: V03:K0:ASQ7PAJ92R62NMRVRw/enTGW2iFE8M0u8V+aIbFtynTwtmGLDH/
 k8gZF5p9iXfQ8DD/jGPkwm+J6s4IdSzq09OMnijEdyaBqL8TySbAX+p6YOxh7VHNCJjNXWn
 cu/OT32wJkX0r9QhYGtxE5GnhOcQfiF48NcOiR5zd77LjhZ2Y2ju/h2ecTTRNdROlCKu7nk
 6EKg8+fueXytOt01sFgLA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264996>

Am 07.03.2015 um 02:08 schrieb Jeff King:
> On Sat, Mar 07, 2015 at 01:20:22AM +0100, Ren=C3=A9 Scharfe wrote:
>
>>> Not a big deal, but do we want to rename sanitize_client_strbuf to
>>> sanitize_client? It only had the unwieldy name to distinguish it fr=
om
>>> this one.
>>
>> A patch would look like this.  The result is shorter, but no win in
>> terms of vertical space (number of lines).
>
> IMHO this is an improvement, though whether it is enough to merit the
> code churn I dunno. So I'm in favor, but don't mind dropping it if
> others disagree.

I don't think the change justifies a separate patch, but we can squash=20
it in. :)

Ren=C3=A9
