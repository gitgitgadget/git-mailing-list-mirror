From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Introduce gc.autowarnonly config option
Date: Sat, 5 Nov 2011 15:22:11 +0100
Message-ID: <CAGdFq_jQ_2NueWD5YqXb-nuT6boOw66TJ0+m5mFPqenND2RBsQ@mail.gmail.com>
References: <20111105140529.3A6CE9004A@inscatolati.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Fernando Vezzosi <buccia@repnz.net>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 05 15:22:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RMh97-0006ku-Gs
	for gcvg-git-2@lo.gmane.org; Sat, 05 Nov 2011 15:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab1KEOWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Nov 2011 10:22:53 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57133 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1KEOWw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2011 10:22:52 -0400
Received: by qao25 with SMTP id 25so1097qao.19
        for <git@vger.kernel.org>; Sat, 05 Nov 2011 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=86dPgdgsJWTiUjs/nRS59HXPXrQ8Pjab4Nou3bdc61E=;
        b=v45bpnRbwbNKhUQoJIjkPU2V0Hp7t3Ntf0PkClG7ny2PfTUeep15B/zj5PvOc6BYKc
         5+Zguh9WpN3b3cq9fXf1n8iuE+R3yNmFROLnaGo7csyyDlC7obiZ14mLLVxhSyo7rqMi
         X9PU8FpDnvFbnTqqtabAekeep0Xgq3G+CW6/o=
Received: by 10.182.45.102 with SMTP id l6mr450552obm.0.1320502972053; Sat, 05
 Nov 2011 07:22:52 -0700 (PDT)
Received: by 10.182.52.3 with HTTP; Sat, 5 Nov 2011 07:22:11 -0700 (PDT)
In-Reply-To: <20111105140529.3A6CE9004A@inscatolati.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184850>

Heya,

On Sat, Nov 5, 2011 at 14:39, Fernando Vezzosi <buccia@repnz.net> wrote=
:
> When `git gc --auto` would detect need for garbage collection to run,=
 it
> would just run. =C2=A0With this patch, enabling gc.autowarnonly will =
instead
> make it just emit a warning.
>
> Reviewed-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Fernando Vezzosi <buccia@repnz.net>

Highly relevant considering recent (3 hours ago) patch that instead
adds a warning that gc will happen soon.

--=20
Cheers,

Sverre Rabbelier
