From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 1/2] Add a new option 'core.askpass'.
Date: Mon, 30 Aug 2010 14:17:05 +0200
Message-ID: <AANLkTimLzZpzgbY2tHVvZXRkhUCAnoGcgGM1eORhjaz=@mail.gmail.com>
References: <201008271251.19754.k.franke@science-computing.de>
 <7vaao8hsmx.fsf@alter.siamese.dyndns.org> <201008301344.22983.k.franke@science-computing.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Frank Li <lznuaa@gmail.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Mon Aug 30 14:19:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oq3KO-0007kl-N2
	for gcvg-git-2@lo.gmane.org; Mon, 30 Aug 2010 14:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755530Ab0H3MTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Aug 2010 08:19:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45936 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755501Ab0H3MTB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Aug 2010 08:19:01 -0400
Received: by gyd8 with SMTP id 8so1934060gyd.19
        for <git@vger.kernel.org>; Mon, 30 Aug 2010 05:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=ndyuiuu1n4Anrn8rSmCSgS3bQmA7UQ7CVrH/KMy8erQ=;
        b=nsV8kXxRpHnIJV4CGijpWUCplgzoM6+/SpxbNg/MJPEBi+OTbqTKUoQiO3BleDqLWk
         OAidcyjo7OuQQUDGGiNle+MUhflJK/TbKh2D3gq/Nkj0BvQizAlU+WzYo0OxpbNMhGfW
         4N8YhL/NJTo/Lccix63grkyxboRPz/bl8ggS0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=pe/P2GgOY/l+oc6nGzizzNOmyANgebOz+2pR24JRCY/VLnbXErs1yITpDHchV2rsUe
         iaa9NbFVB+WmSdmiVe5v2ti+jjr4UBc2nuj05L1iQYwOrFYsTR4khCDuB1rcC3Q7HvCo
         G4Z1Te7rUKtgYkdjvaoIztSOaKllZwwLIX+qc=
Received: by 10.150.95.4 with SMTP id s4mr5057628ybb.324.1283170645413; Mon,
 30 Aug 2010 05:17:25 -0700 (PDT)
Received: by 10.150.211.14 with HTTP; Mon, 30 Aug 2010 05:17:05 -0700 (PDT)
In-Reply-To: <201008301344.22983.k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154793>

On Mon, Aug 30, 2010 at 1:44 PM, Knut Franke
<k.franke@science-computing.de> wrote:
> On Friday 27 August 2010 19:28:38 Junio C Hamano wrote:
>> I don't see ASKPASS documented anywhere in the Documentation/ in the=
 first
>> place. =A0Perhaps we would want to fix that while we are at it.
>
> It's at least mentioned in the core.askpass documentation added by th=
e patch,
> but I'll try to improve.
>
> Incidentally, the documentation for other environment variables
> (GIT_PROXY_COMMAND, GIT_SSL_CERT, GIT_SSL_KEY, GIT_SSL_NO_VERIFY,
> GIT_SSL_CERT_PASSWORD_PROTECTED, GIT_SSL_CAINFO, GIT_SSL_CAPATH)
> is equally sparse.
>
>> Also this
>> does not feel like a "core." thing, but it may be just me.
>
> Where else could it go? It's not entirely http specific:
>

Perhaps "user.getpass"? But I have to admit, I agree with you that
"core.askpass" is the most natural choice. It doesn't describe the
user, it describes the mechanism to authenticate any user at any
remote host, which IMO is much more a "core" matter.
