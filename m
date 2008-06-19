From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] Authentication support for pserver
Date: Thu, 19 Jun 2008 15:00:03 -0400
Message-ID: <46a038f90806191200n237633u80f0be736e8d227b@mail.gmail.com>
References: <87wsrhex4c.fsf@cpan.org>
	 <7vd4t9x2lw.fsf@gitster.siamese.dyndns.org> <87mysdepeh.fsf@cpan.org>
	 <7vir31u210.fsf@gitster.siamese.dyndns.org> <877ijhm1b5.fsf@cpan.org>
	 <46a038f90712180141x2f27e6cei5ef53339fd3f90dc@mail.gmail.com>
	 <86r6ens6k5.fsf@cpan.org> <86iqzyse9u.fsf@cpan.org>
	 <861w2tjpev.fsf@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	martyn@catalyst.net.nz, martin@catalyst.net.nz
To: "=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?=" <avar@cpan.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 21:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9PNZ-0006lr-10
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 21:01:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167AbYFSTAI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Jun 2008 15:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752649AbYFSTAI
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 15:00:08 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:54083 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363AbYFSTAG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 15:00:06 -0400
Received: by an-out-0708.google.com with SMTP id d40so203495and.103
        for <git@vger.kernel.org>; Thu, 19 Jun 2008 12:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=dFTU74E0K7KmjtA/iNP147Kj125nUSihRHaNo8ctLjU=;
        b=in4fyCsaDIbYZm6duznYY2bpYO2uzsN88nlRwmRBx8XdlQagqXbV84epATC4QCpL4K
         oWzX5v6+GG+wDXhoksVbOtSycQxWsmeYsk+U22Xr6pESKiBcAfx6rhNyMUc7TDPN8jLW
         ksfn/Qg4nIJZonLAoS82GH8IxXlPAEwkGzJiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u2KjdmzVmh3sO6cHbTxc39nFNpppEeSshlkdi5rM9jgVY7bGCvx4u4wcXdTBSEkZAu
         9muUhnFJRCkxrhEM+XyKhnyh8pLixZcydKvsnxa6+QNTOaC/HecEJuC3G0ytXq5OxJDX
         ediW6uNvwkh8a68LxePQRFQ7N6q+rpWXIRRoc=
Received: by 10.100.131.3 with SMTP id e3mr3884718and.4.1213902003391;
        Thu, 19 Jun 2008 12:00:03 -0700 (PDT)
Received: by 10.100.250.4 with HTTP; Thu, 19 Jun 2008 12:00:03 -0700 (PDT)
In-Reply-To: <861w2tjpev.fsf@cpan.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85512>

On Thu, Jun 19, 2008 at 1:38 PM, =C6var Arnfj=F6r=F0 Bjarmason <avar@cp=
an.org> wrote:
>> 1. http://git.nix.is/?p=3Davar/git;a=3Dcommitdiff;h=3D60f893bd9fe329=
bd5cf8ec513d10ec00e85feb2c
>
> It has been over 3 months since I submitted this patch without anyone
> acting on it. In absence of comment from the Mart[yi]ns could this
> please applied anyway?

Sorry. My opinion on this is a mild ACK on the technical front, and a
bit of a frown ("do we really want to offer this?"). Specifically, my
concern goes beyond what you can do against a pserver service - git
hooks can be targeted with this. "Warning: as safe as telnet" ;-)

cheers,



m
--=20
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
