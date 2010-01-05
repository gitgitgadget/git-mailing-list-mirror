From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: cannot remove remote branch name
Date: Tue, 5 Jan 2010 02:59:37 +0100
Message-ID: <40aa078e1001041759p22657d0cwe094a348dca32842@mail.gmail.com>
References: <hhu694$3v9$1@ger.gmane.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 02:59:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRyhz-0004XP-DL
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 02:59:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754069Ab0AEB7j convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jan 2010 20:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754057Ab0AEB7j
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 20:59:39 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:60659 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753668Ab0AEB7j convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jan 2010 20:59:39 -0500
Received: by ewy19 with SMTP id 19so7977760ewy.21
        for <git@vger.kernel.org>; Mon, 04 Jan 2010 17:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5Xf3mwZ+CRMaAFlleEh/wX+JzKuO5sERw/SHE4eyaEM=;
        b=jL8GkeibVxUepWWDj8QKTz9JHbgAe9iyStnqyucZMCCAMX/0G5eTugK/vxDeRRX/nK
         oNkXjqOonALo4RTnnYd+GjQbvRbVwDL0Z6MEez7rTAm5yyzjXL+4kcaO5r8scDSfoPOW
         Oxp6y/iZE/71fIvbGaG1ww97a1HgebLWkafjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=PxTX919l2GGe7dflAl+IlKyTNbL+jeeL4ucKoQ4FnhR0eNoXAslzU5tyN+/ekEyQ9G
         4Ef5tXIq3cuwhjNf/5ndber4ZA4Zg7DgnOUBE382oGBOWMA1j9yrEHYpLynSOCREPnvr
         P4Zdw3dyzMAW3u3ZdSLIGF4qUVHMyT7ILq71w=
Received: by 10.216.86.203 with SMTP id w53mr4782177wee.58.1262656777594; Mon, 
	04 Jan 2010 17:59:37 -0800 (PST)
In-Reply-To: <hhu694$3v9$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136153>

On Tue, Jan 5, 2010 at 2:57 AM, SungHyun Nam <goweol@gmail.com> wrote:
> Hello,
>
> How I can remove remote branch name if it already removed
> in remote side?
>
> $ git branch -a
> * master
> =A0remotes/origin/HEAD -> origin/master
> =A0remotes/origin/master
> =A0remotes/origin/test
> $ git branch -D -r test
> error: remote branch 'test' not found.
> $ git branch -D -r remotes/origin/test
> error: remote branch 'remotes/origin/test' not found.
> $ git branch -D remotes/origin/test
> error: branch 'remotes/origin/test' not found.
>
> The 'remotes/origin/test' was removed in remote side.
>

$ git remote prune origin

--=20
Erik "kusma" Faye-Lund
