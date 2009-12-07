From: Baz <brian.ewins@gmail.com>
Subject: Re: Speedlimit at "git clone"
Date: Mon, 7 Dec 2009 11:15:00 +0000
Message-ID: <2faad3050912070315y7f2bf99dpb2e1f61b55587fe6@mail.gmail.com>
References: <4B17AA6B.7030000@access.denied> <4B1AB717.9030601@access.denied>
	 <20091206144322.GB26440@coredump.intra.peff.net>
	 <alpine.DEB.2.00.0912061912180.19656@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Mon Dec 07 12:15:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHbYb-0002aY-0W
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 12:15:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933678AbZLGLOz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Dec 2009 06:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932890AbZLGLOy
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 06:14:54 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:36684 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932488AbZLGLOy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 06:14:54 -0500
Received: by yxe17 with SMTP id 17so3779363yxe.33
        for <git@vger.kernel.org>; Mon, 07 Dec 2009 03:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qRE92SmJYV4DJVV4jyXKdAQd5EWWDnb/5wBuekitU3Q=;
        b=pfB/XU2vfGk+S4oWxBL/IjO/ZrhETRSXfnOBeXlkQIkBTZkGOXrYxq3B6R57IZ3faM
         3LPcZ3eJtibjGlDLnUpJtE2D2L3D2G/073br1L5lWf7F8m/l34EkCQkkedpGnSdk+nvr
         5ca8G0LCL/iYG+5YDytU0FPBv9fOn+lx6utpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pd4K18pUG+Y//I3p1PVMxyDKcEzu8y/5R23bRWnrXJ3SL+QThM0fepNYMHqCdei7hC
         KiltOVFuhzrm/Bc2HRLtm2b+95CmyRozwztPd/pcOgt4RlOUmB2xJczIVEHJb+Kocnyx
         bzKyzj/bKvQ+SQuw/klewbmVFVyu4xOA5SpAc=
Received: by 10.90.16.40 with SMTP id 40mr1418277agp.7.1260184500114; Mon, 07 
	Dec 2009 03:15:00 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.0912061912180.19656@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134735>

2009/12/6 Daniel Stenberg <daniel@haxx.se>:
> On Sun, 6 Dec 2009, Jeff King wrote:
>
>>>> how can i limit the download speed at "git clone"?
>>>>
>>> no one any idea?
>>
>> Git has no internal support for doing this.
>
> libcurl provides such a feature so if the clone is done over HTTP it =
would
> be easy to offer, but I figure it would also be weird to only provide=
 it
> over a single particular transfer method...

There is always 'trickle'.
http://monkey.org/~marius/pages/?page=3Dtrickle

I think this is the preload-based tool Peff was thinking of. I've not
used it with git, but I have used it successfully limiting bandwidth
for other downloads.

-Baz

>
> --
>
> =C2=A0/ daniel.haxx.se
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
