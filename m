From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH next] Complete prototype of git_config_from_parameters()
Date: Fri, 21 May 2010 12:18:01 +0200
Message-ID: <AANLkTilhCcJ7Qsz_KL8ymhfkgy0_MtoE9WsVZp080YLi@mail.gmail.com>
References: <0c117d8ae7550689d0f19814872ccefe68fb4e62.1274436375.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri May 21 12:18:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFPIz-0005xz-Oe
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 12:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753526Ab0EUKSH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 06:18:07 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33691 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0EUKSG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 06:18:06 -0400
Received: by gyg13 with SMTP id 13so374242gyg.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 03:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=POUl4eRP5PlMlfpMlGpEfN9T/RzqjsqAio+knFbGkEU=;
        b=Z9cMqt/BM9613JgGSJ4isgdg579BbjGGjlHwG7F537BZMaMZ3dXbErMMjD4rgZF6yV
         AG6wdErRNs6yLdl4i+yAjKYLJu5vD7EhC+7SA6qi1D5QQyPnpBmi6/bD+TpgBcpzeZ9Z
         HOLZPa/HQdKNlwIY68+7osQNPfh3FlWlON9Dw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=b4FhXpp5KdoXOztKoXEpl80Bpus+OvLfBDXN2h5usZkQdsDkk7hGCjMg2ULLK9TpMU
         JINXdwngeOkzrIc8yjiJY8GSxDB5xaCy2sk9WuKJEaQRc7u42o5eXjPzmFpRIoiOr8Ke
         coJgdqC1BOZa0xjPXuUg7F+oORClYl4lIoshE=
Received: by 10.101.149.15 with SMTP id b15mr1691832ano.219.1274437081240; 
	Fri, 21 May 2010 03:18:01 -0700 (PDT)
Received: by 10.100.154.8 with HTTP; Fri, 21 May 2010 03:18:01 -0700 (PDT)
In-Reply-To: <0c117d8ae7550689d0f19814872ccefe68fb4e62.1274436375.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147446>

On Fri, May 21, 2010 at 12:07, Thomas Rast <trast@student.ethz.ch> wrot=
e:
> Add the missing argument list. =C2=A0(Its lack triggered a compiler w=
arning
> for me.)

Oh, thanks! I just forgot about the prototype from the previous iterati=
ons.
