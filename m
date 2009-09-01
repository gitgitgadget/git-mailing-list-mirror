From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] fast-import.c: Silence build warning
Date: Tue, 1 Sep 2009 08:30:38 +0200
Message-ID: <81b0412b0908312330t3135d033o14a6cb73797edf18@mail.gmail.com>
References: <d2e97e800908310421u7de8ae58o361bd64a026384bf@mail.gmail.com>
	 <7vfxb7y2h3.fsf@alter.siamese.dyndns.org>
	 <d2e97e800908311655t553d6c4bo6ed45fe37819c1d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Wookey <michaelwookey@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 08:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiMtq-0000rd-4i
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 08:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbZIAGak convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2009 02:30:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752571AbZIAGai
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 02:30:38 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:45774 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbZIAGah convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 02:30:37 -0400
Received: by bwz19 with SMTP id 19so3284040bwz.37
        for <git@vger.kernel.org>; Mon, 31 Aug 2009 23:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=s2weO/yNk35yR2WBL+M5LPP1J0AEh6HSqIO6Vm0uh/s=;
        b=CyNR9hzsNcgklgO0sNBZzwIc7yRvufaFDnQwM7nvEmDS+EEEc90avN0iSUUeIjQlnG
         nv0ye6/8l8Mx9RhQV3wD2Ufgk/UxKEGF86ADib7Ao8VnJ2dGs2nz/zYuUP5y9RE92MHD
         pkcP368fpedYNS5dbqM/tQUbXZxXf7eo333UM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Ja8CWrycaIaQDEoirpvJ7ugGpf352NZqtNTjNyfNEadIFe4kEudJ1Kwjdo/KKiFOc6
         p7jkLI/tnJGhTI4k7+h6cesi/BzhMmTBoFzknPadOgw0i11HMZRyMa/l0BJpWCHvkKy2
         H1IsyRMYSZmbYkxbU2Z2t5pbTK1qSntLlHDb0=
Received: by 10.204.34.196 with SMTP id m4mr5199485bkd.62.1251786638405; Mon, 
	31 Aug 2009 23:30:38 -0700 (PDT)
In-Reply-To: <d2e97e800908311655t553d6c4bo6ed45fe37819c1d8@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127525>

On Tue, Sep 1, 2009 at 01:55, Michael Wookey<michaelwookey@gmail.com> w=
rote:
>> Otherwise a clever compiler has every right to complain "the variabl=
e
>> unused is assigned but never used."
>
> =C2=A0I get no other warnings, so does that make gcc less than clever=
? ;-)

It only does what it is instructed to do: the function is annotated wit=
h
warn_unused_result attribute. What really is annoying is someones
choice of the functions to annotate.
