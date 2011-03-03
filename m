From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: libgit2: Resolving HEAD to a SHA
Date: Thu, 3 Mar 2011 18:31:01 +0100
Message-ID: <AANLkTi=Cb2HTqopLs9J1cgakJGNz2O_o7mhW7nKzbqY2@mail.gmail.com>
References: <4D6FBD00.6010208@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Jensen <jjensen@workspacewhiz.com>, vicent@github.com,
	Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 03 18:31:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvCNQ-0007Gz-2P
	for gcvg-git-2@lo.gmane.org; Thu, 03 Mar 2011 18:31:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758461Ab1CCRbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Mar 2011 12:31:42 -0500
Received: from mail-gw0-f51.google.com ([74.125.83.51]:63982 "EHLO
	mail-gw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab1CCRbl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Mar 2011 12:31:41 -0500
Received: by gwb15 with SMTP id 15so686649gwb.10
        for <git@vger.kernel.org>; Thu, 03 Mar 2011 09:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=rxFiZVoHARGMdsARfexsbLpygrApLuNiO4ez1K+n6j4=;
        b=vGj3sV2rxSGfA22rtwXyPvs66T5udAl6EuDUS0QcPgaxjouPB7NvcxX0aLndks6Rce
         nykoMHS2TYOuqxtua9HffwKrsVN4dvZeUvjuWsxp/sZRInAjDyVGykJdIHdpRV1h57Ab
         Taxsbz8YtKnJ4zXr+zq8Zmt6cg9rillhs/6k4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gGYgDWJQdv59Vjrt7TEWLBizNU3W3D91QD07lNi8hZN3EwVqSmfkwxJZFjgO9ikK88
         rCE6Xuk3g/Qpi+wnHetyWSfvOfUu6oV4RDMgsrXLofe08Q0TQ0aaaTYdwAu03cbkK9TD
         L2MS8HxnReO+UyCkSgWC4oKIlkI13A5Y0i3Wo=
Received: by 10.150.178.17 with SMTP id a17mr1913961ybf.163.1299173501134;
 Thu, 03 Mar 2011 09:31:41 -0800 (PST)
Received: by 10.151.11.12 with HTTP; Thu, 3 Mar 2011 09:31:01 -0800 (PST)
In-Reply-To: <4D6FBD00.6010208@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168401>

Heya,

[+scott, vincent]

On Thu, Mar 3, 2011 at 17:08, Joshua Jensen <jjensen@workspacewhiz.com>=
 wrote:
> I spent a couple hours yesterday trying different methods of resolvin=
g HEAD
> to its appropriate SHA-1. =C2=A0At best, I could get a resolution of =
HEAD to
> 'master'.
>
> How do I achieve the functionality of 'git rev-parse' with the libgit=
2 API?
>
> Thanks.
>
> Josh

--=20
Cheers,

Sverre Rabbelier
