From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] Add support for GIT_ONE_FILESYSTEM
Date: Tue, 16 Mar 2010 00:16:19 +0100
Message-ID: <fabb9a1e1003151616m4c0e9100g77170433f6a67912@mail.gmail.com>
References: <20100315214003.GB11157@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lars Damerow <lars@pixar.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 00:16:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrJWs-0002Ax-Sc
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 00:16:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937117Ab0COXQm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Mar 2010 19:16:42 -0400
Received: from mail-px0-f198.google.com ([209.85.216.198]:52295 "EHLO
	mail-px0-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937142Ab0COXQk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Mar 2010 19:16:40 -0400
Received: by pxi36 with SMTP id 36so2370930pxi.21
        for <git@vger.kernel.org>; Mon, 15 Mar 2010 16:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=HN0fBrco+nDLPGr9Ump6t3vTPaqPwDgHN2UKoi/s56k=;
        b=TxnA/i2rex/hatZuqluZgjvrgj9ylIzt9/g+bfrD8fz1OG2vtAHHbZxi9EngA45beb
         77nAx6b9BOHtLOzLT/7Gs/TILmAMDTPdSsL3de1qyHvgs3AHXzB6wJLquDBxFCHJsQfV
         jtYM6tU1EchQmYBEtiLSL8YbnoEQWowZ3rt60=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=tCtYzqQBl62cmHV8Xl8Fxs3qvu7xfTIv1F57YJVbiHyCrknrFR1mswssS9yTk4p+th
         QIFx8XPWveU3uZwWOUU3iSKPlHPXpajrPJAj7oq/dOkAW1hZqlrDj7fNZtvFQdxq2Pwj
         eiNr+++5bWH5gSySUImlksWy/LP4o89Gwx6Js=
Received: by 10.143.21.5 with SMTP id y5mr3621784wfi.324.1268694999243; Mon, 
	15 Mar 2010 16:16:39 -0700 (PDT)
In-Reply-To: <20100315214003.GB11157@pixar.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142271>

Heya,

On Mon, Mar 15, 2010 at 22:40, Lars Damerow <lars@pixar.com> wrote:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (buf.st_dev !=3D cur=
rent_device)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("re=
fusing to cross filesystem boundary '%s/..'", cwd);

Great, that's going to tell the unfortunate user who runs into this a
whole lot of nothing. Shouldn't you at least tell them what git was
trying to do, how they can fix it if this is not the desired behavior,
etc. etc.?

--=20
Cheers,

Sverre Rabbelier
