From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] clone: pass the remote name to remote_get
Date: Mon, 22 Mar 2010 00:27:46 +0100
Message-ID: <fabb9a1e1003211627q7ea75194j941fe9ae23f77b66@mail.gmail.com>
References: <1269202789-8833-1-git-send-email-srabbelier@gmail.com> 
	<1269202789-8833-2-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <gitster
X-From: git-owner@vger.kernel.org Mon Mar 22 00:28:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtUZ6-0001tu-5q
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 00:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308Ab0CUX2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 19:28:09 -0400
Received: from mail-bw0-f211.google.com ([209.85.218.211]:58859 "EHLO
	mail-bw0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324Ab0CUX2I (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 19:28:08 -0400
Received: by bwz3 with SMTP id 3so4886735bwz.29
        for <git@vger.kernel.org>; Sun, 21 Mar 2010 16:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type;
        bh=S8vSwS1mspfj/6hLvtpTCjD2ja8OvNgjgDnb5iIOdL4=;
        b=hVt9e+vP84Tuywjb9Nof7YVYzicj8Kd+jHcm5K0ifyLbNNesCTWO5h3gNR5jzSyHqd
         cAlZPBMNH/Gk7tgNVWR2DJCS4OGfwDeo53Gfp4+os0kSXuujp+tAXbz4XserqUyolIgE
         RtdXa6Ab+pfoaFXou/9RAR/TO8Dcl6spe3xXs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=h5pxSIPY05zui3X4okTuv3Xv8bzLHAYNX7KSoDv125nS4YGKogGGSRCC3+Jx76eMWc
         V6Lu/B/gNwhc0zayCVDT2Bw3lrL2JQU5DxcB9BdJBfu9O2GLLeizwJPwDs3o/RpLP9+0
         N/HVRlyfwxTS0fiX0GAM9DIrfmM9NdBQz1tqk=
Received: by 10.204.25.209 with SMTP id a17mr1593273bkc.104.1269214086107; 
	Sun, 21 Mar 2010 16:28:06 -0700 (PDT)
In-Reply-To: <1269202789-8833-2-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142872>

Heya,

On Sun, Mar 21, 2010 at 21:19, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Currently when using a remote helper to clone a repository, the
> remote helper will be passed the url of the target repository as
> first argument (which represents the name of the remote). This name
> is extracted from transport->remote->name, which is set by
> builtin/clone.c when it calls remote_get with argv[0] as argument.
>
> Fix this by passing the name remote will be set up as instead.

Ah, I forgot a sign-off it seems. Also, these two patches were a bit
more involved before (I didn't arrive at their current form for quite
a few hours), so I guess it could makes sense to just squash them into
one patch. Whichever is preferable.

-- 
Cheers,

Sverre Rabbelier
