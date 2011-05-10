From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 (for maint)] git-completion: fix regression in zsh support
Date: Tue, 10 May 2011 20:36:33 +0300
Message-ID: <BANLkTinRB-hUwOdZsWRFZWxUAebkFeaGVQ@mail.gmail.com>
References: <1305030039-16044-1-git-send-email-felipe.contreras@gmail.com>
	<7vr586jwzm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 19:36:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJqrS-0007Ij-AZ
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 19:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357Ab1EJRgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 13:36:35 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55600 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751030Ab1EJRgf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 13:36:35 -0400
Received: by fxm17 with SMTP id 17so4472133fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 10:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=91TN3jaSPieITbKd+8bmmgIPhMsoaJAD+2mCRjraM3k=;
        b=CehmyjOfk2PNWbVxCjX6psk8SA72dLtQ0tSM/6NMNj8zvIYo8dhSxK8RMsD8Ul2eZm
         ePbts5kteF7RgpTBaRSkn7jhvTlqQVbEPYNVZFv/vJI01QCHSqRsBlRrS7GJH//rYupX
         kKlAR/ZfArfUqd1tAhQQsfP44EnL09wJ58xWA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Jbvgbt2BThfXSVB076ezrx9EMHVaabRTp6P2VpvHqoc4po3bFzsoVExe4UtxI+086R
         M4iBiHPI8Etq3mX0rdvUUi48r9s2CZZHS1stfoJRlcwSTSURhl36UiqTW9a1q/G3Ibkj
         cxii5KSnopIhdw3qvhxtPc3Wnfl/XGoA/03zo=
Received: by 10.223.100.86 with SMTP id x22mr1748728fan.108.1305048993718;
 Tue, 10 May 2011 10:36:33 -0700 (PDT)
Received: by 10.223.74.130 with HTTP; Tue, 10 May 2011 10:36:33 -0700 (PDT)
In-Reply-To: <7vr586jwzm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173343>

On Tue, May 10, 2011 at 8:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Right now zsh is quite broken;...
>
> Yuck--sounds like zsh as a whole is broken, but certainly you didn't mean
> that ;-)

Right: s/zsh/zsh support/

> Could you also clarify "Right now" a bit?
>
> Is "The git-completion script in contrib/ in 1.7.5 is broken for versions
> of zsh before 4.3.12" a good rewrite of the above?

Well, "right now" all versions of zsh are before 4.3.12. I also don't
see the point mentioning of 1.7.5. Maybe "The git-completion script in
contrib/ is quite broken".

> of zsh before 4.3.12"
> No need for resend if that is the only change required.

All right. Hopefully there won't be other changes.

-- 
Felipe Contreras
