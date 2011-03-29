From: Maxin john <maxin@maxinbjohn.info>
Subject: Re: [PATCH] Remove "bashism" from contrib/thunderbird-patch-inline/appp.sh
Date: Tue, 29 Mar 2011 09:47:41 +0300
Message-ID: <AANLkTi=Nd897+GrfmPS38aQo_Vh-J9cJr9bB-UzN_CqQ@mail.gmail.com>
References: <AANLkTin-USDnTxeKT_KOZW5kgC0vFXYbMNP9ct6fzbUC@mail.gmail.com>
	<7v7hbiviwv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?ISO-8859-1?Q?Lukas_Sandstr=F6m?= <luksan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 08:47:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4SiS-0000l5-7A
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 08:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729Ab1C2Grn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2011 02:47:43 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:62334 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774Ab1C2Grm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 02:47:42 -0400
Received: by ywj3 with SMTP id 3so1478367ywj.19
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 23:47:41 -0700 (PDT)
Received: by 10.151.13.7 with SMTP id q7mr1809599ybi.304.1301381261487; Mon,
 28 Mar 2011 23:47:41 -0700 (PDT)
Received: by 10.150.139.2 with HTTP; Mon, 28 Mar 2011 23:47:41 -0700 (PDT)
X-Originating-IP: [91.154.177.92]
In-Reply-To: <7v7hbiviwv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170230>

Hi,

> It is better to explain the patch as
>
>  Subject: contrib/thunderbird-patch-inline: do not require /bin/bash =
to run

Yes. I do agree with you. I should have chosen a better Subject line
for this patch. Should I resend this patch with this modified Subject
line ?

Thanks and Regards,
Maxin B. John


On Tue, Mar 29, 2011 at 4:01 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Maxin john <maxin@maxinbjohn.info> writes:
>
>> Remove "bashism" and minor corrections for
>> contrib/thunderbird-patch-inline/appp.sh
>
> The script seems to only use standard POSIX shell features and nothin=
g
> particularly bash specific nor outside POSIX in general that we exclu=
de
> from our coding standards (e.g. "local", use of "function" noiseword,
> substring expansion ${parmeter:offset:length}).
>
> It is better to explain the patch as
>
> =A0Subject: contrib/thunderbird-patch-inline: do not require /bin/bas=
h to run
>
>
