From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: git push <branch-name>
Date: Wed, 6 Oct 2010 00:35:16 +0200
Message-ID: <AANLkTinjEoDWhq_EWPj+z++g-b7XMA9d2orXRGtuHyRB@mail.gmail.com>
References: <AANLkTineD3DYsBJBBt13-EWX0_1YUf1cf1wTGUL-jRkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 00:35:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3G6o-00060m-HE
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 00:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab0JEWfi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 18:35:38 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53350 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461Ab0JEWfh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 18:35:37 -0400
Received: by gxk9 with SMTP id 9so2216810gxk.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 15:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YG/2F0LOryYX0FfY1vABsAoPbkGdc6T0KL4IGEHvCDw=;
        b=KNO23SIMvQfjsPsaRXH4fq5Gb/iXTxOGrTDUFHSfe5628hZw1+9DcxoxUah5pgpNhC
         yZ+uVjv0LUsJhtaQT1n/e0YCislEkjYZKPU5cpsW4Fs2gvln10sFXU6/KqYc0lKX0Twp
         EBKQpQ9WWCQjNgBKckDP5Fbw7px+oP7YjrnKM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Ji17fK2i4Yq57CRN58zQlLpLO5Y26JNn9kBbePzxQlz3xfStf6VwckWiUC+ofx+Bwp
         jGe3ouHv6If/fHonZVp3etTtoGWUOzXtd8QX9ICiMFwNYtrE1EZVNhKO6sKHSl6xJ543
         ETLVpNHadUCz8bWnyeQ9Ry5zRTb8aPJTC4xZQ=
Received: by 10.150.186.17 with SMTP id j17mr976176ybf.272.1286318136673; Tue,
 05 Oct 2010 15:35:36 -0700 (PDT)
Received: by 10.151.15.8 with HTTP; Tue, 5 Oct 2010 15:35:16 -0700 (PDT)
In-Reply-To: <AANLkTineD3DYsBJBBt13-EWX0_1YUf1cf1wTGUL-jRkg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158257>

Heya,

On Tue, Oct 5, 2010 at 22:29, Eric Raible <raible@gmail.com> wrote:
> =C2=A0 =C2=A0git push $(git config branch.<branch>.remote) <branch>

Since it is such a simple command expansion, why not create an alias
that does just that?

--=20
Cheers,

Sverre Rabbelier
