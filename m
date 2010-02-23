From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] Create /gitk as a symlink to gitk-git/gitk-wish.
Date: Tue, 23 Feb 2010 13:47:41 -0500
Message-ID: <32541b131002231047y4dc49f85s56ba91e6bc7bf16c@mail.gmail.com>
References: <1266536738-2933-1-git-send-email-apenwarr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Feb 23 19:48:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njznn-0002Q1-IC
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 19:48:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753351Ab0BWSsG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Feb 2010 13:48:06 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:63990 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab0BWSsE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Feb 2010 13:48:04 -0500
Received: by gwj16 with SMTP id 16so653439gwj.19
        for <git@vger.kernel.org>; Tue, 23 Feb 2010 10:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8dU8IZlCM+TtcEFBpUT4BBEnMr6vSTkJ5q/Bc1hKeg0=;
        b=Iu56dvmQuRRRFGKAc6R7plwgNzGK1INCdvS+hoMaHfQdymzNo2XcT90AIcRsV5l0dc
         a0wbbx+uYNPsy2NtbQLnm6SlMMTn/hNEQfKZINDVdzmlf98UiUD/tfv6kOcEpqwWOH71
         2ZXbz1l+qWSzTZ62W4FbIYHx+CEiZSTOUdyPs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DEYgFyRuwUGFI2bCfzGE0l24iGkI1AS5AWwHGY19p4Yghtpo40NSNpUkfilyfqOZMd
         fXquYLQu3c/Erw9jQEGU8UrRG8ddueHhp4ckITu3kMqvgxKJzDxGJeH/QWfNIpU9QZqY
         r6xRrtdYP9uSc1csP4uJDB0WF/QaiAksXlZBY=
Received: by 10.151.125.4 with SMTP id c4mr636163ybn.204.1266950881205; Tue, 
	23 Feb 2010 10:48:01 -0800 (PST)
In-Reply-To: <1266536738-2933-1-git-send-email-apenwarr@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140823>

On Thu, Feb 18, 2010 at 6:45 PM, Avery Pennarun <apenwarr@gmail.com> wr=
ote:
> In earlier versions of git, you could add the git source dir to your =
PATH
> and the 'gitk' command would work. =A0At some point, this stopped wor=
king
> because the file formerly known as gitk is now gitk-git/gitk-wish.
>
> Have the Makefile automatically generate a symlink to it when buildin=
g, to
> restore the earlier functionality.
>
> Signed-off-by: Avery Pennarun <apenwarr@gmail.com>

Any comments on this one?

Avery
