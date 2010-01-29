From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: master^ is not a local branch -- huh?!?
Date: Fri, 29 Jan 2010 21:35:08 +0100
Message-ID: <fabb9a1e1001291235h26681e65qe4851cae1c536b6d@mail.gmail.com>
References: <ron1-2E17EF.12204629012010@news.gmane.org> <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ron1 <ron1@flownet.com>, Jacob Helwig <jacob.helwig@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 29 21:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaxYy-000408-1t
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 21:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799Ab0A2Uf3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2010 15:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659Ab0A2Uf3
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 15:35:29 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:59239 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753903Ab0A2Uf2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2010 15:35:28 -0500
Received: by pxi12 with SMTP id 12so1940454pxi.33
        for <git@vger.kernel.org>; Fri, 29 Jan 2010 12:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=l0vHmEesi+0EYnwyeCHxA5wzWtoe+9kMnolMVBF5e44=;
        b=FftGDdXWSrQrcg49PKHYo3gwfF3xIfTg9OFzSKJcbfszz9pGi6fbkfXn1qBeOwUhSH
         OQjnTXW0XBoyi6cBSFR2yQnSfM1Nd1Oy/hchZj9O0a0NDk64iaSmZMoOUOlyG0lEI9Xa
         MycFDsby2qY18pYhxwDXMsoSg3L4NQAk3NWjo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l31JFRuW3/sYT/n84yLu2+rdRb/9FIuXcYSkXkTtDNPyFfxchGE7jY4MlAyz1MbPgn
         6m6QaQ9e6VYu5Dw0WLwg6Hx9edtK2wvENSe73ysfGPe7mRk70lObx64o4gndjMS4O6tS
         5eR8lP15Hnb6L7odgQmtPO1elmdt2ad8x+Yew=
Received: by 10.143.153.30 with SMTP id f30mr871027wfo.281.1264797328106; Fri, 
	29 Jan 2010 12:35:28 -0800 (PST)
In-Reply-To: <8c9a061001291227v34ca0745l1ab35ef6ca5863dc@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138350>

Heya,

On Fri, Jan 29, 2010 at 21:27, Jacob Helwig <jacob.helwig@gmail.com> wr=
ote:
> On Fri, Jan 29, 2010 at 12:20, Ron1 <ron1@flownet.com> wrote:
>> This is a test repository which has never been pulled from nor pushe=
d to
>> anywhere. =A0So how is it possible that I have a non-local branch?
>
> master^ is a commit (the first parent of master), not a branch (local
> or otherwise).

Perhaps we should change the message to say "not a branch" if it's not
a reference to a remote branch? Or simply changing the text to "not a
(local) branch"?

--=20
Cheers,

Sverre Rabbelier
