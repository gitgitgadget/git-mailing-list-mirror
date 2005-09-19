From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: [PATCH] Added -d and -e options to the "git" script.
Date: Mon, 19 Sep 2005 10:42:34 -0400
Message-ID: <432ECE5A.7040703@gmail.com>
References: <Pine.LNX.4.58.0509181114190.26803@g5.osdl.org>	<u5tmzm9bbrb.fsf@lysator.liu.se> <432EC7D6.6080105@gmail.com> <u5tvf0xb0fp.fsf@lysator.liu.se>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 16:42:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHMqu-00038x-Jm
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 16:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbVISOmi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 19 Sep 2005 10:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVISOmi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 10:42:38 -0400
Received: from xproxy.gmail.com ([66.249.82.204]:23096 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932444AbVISOmh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 10:42:37 -0400
Received: by xproxy.gmail.com with SMTP id i27so16209wxd
        for <git@vger.kernel.org>; Mon, 19 Sep 2005 07:42:36 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qrGnclLB9a0Cx8K8Z/dJ6v85SqfDZm6q8h5d4ckV5egljxAexYoaFiGHg+2jcoDKlIwWhcAbTnGp/muuDOExMvpPNiNx/ZARlnYz1KW7uZiUfofDlayP6htPkk+eGQs9WaMowRzs+nOLs43i7LJx91jBVwCIugvgdq9/YumCY1E=
Received: by 10.70.16.17 with SMTP id 17mr1350237wxp;
        Mon, 19 Sep 2005 07:42:36 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.89.97.97])
        by mx.gmail.com with ESMTP id h12sm431821wxd.2005.09.19.07.42.35;
        Mon, 19 Sep 2005 07:42:36 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
In-Reply-To: <u5tvf0xb0fp.fsf@lysator.liu.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8869>

David K=E5gedal wrote:
> A Large Angry SCM <gitzilla@gmail.com> writes:
>=20
>>David K=E5gedal wrote:
>>>These flags override the GIT_DIR and EDITOR environment variables.
>>>
>>[Patch snipped]
>>
[...]
>=20
> So please disregard the -e part of my patch for now.  You are free to
> disregard the -d part as well, but I think that makes some kind of
> sense.
>=20
> And If we go down this path, maybe flags for other GIT_* environment
> variables should be settable with git command line flags too?
>=20

Please no!

There are better methods of setting environment variables than an=20
endless set of command options. Use the env command or you own=20
(personal) command wrapper instead.
