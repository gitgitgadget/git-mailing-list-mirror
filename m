From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 0/2] New 'stage' command
Date: Sun, 5 Apr 2009 22:28:24 +0300
Message-ID: <94a0d4530904051228m4e57ec90y810dded41f47e443@mail.gmail.com>
References: <1238939331-10152-1-git-send-email-felipe.contreras@gmail.com>
	 <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 05 21:30:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqY2g-0004Fz-P7
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:30:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575AbZDET23 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Apr 2009 15:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756572AbZDET22
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:28:28 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:43793 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756568AbZDET21 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Apr 2009 15:28:27 -0400
Received: by fg-out-1718.google.com with SMTP id 16so151788fgg.17
        for <git@vger.kernel.org>; Sun, 05 Apr 2009 12:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=75VZAQaJo/V5oaE9By5ed8NU+PL6m22ifC7ODqZco0E=;
        b=NoHvK/ccNvVUaL0haR9O/RSbKLi5ty25sLbbq2shROaSmLHY+/KbY2tj/8tsm+3Qcz
         UZ3O4W1tP4YXccaDAIGHA9zjC14yWtlK4p52yZvIMWdBSXSOZFRkRtQWP86IaWZNVkLD
         vIvxSxTXKe9SnOLGmrGwVLvmtn0C6UEYoI8ek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GHCcJ/zRNPOZnAStfnqdC2/o0A7DH/mu8BxiMsUjWv2Em+VGZT9N6I8HeHEj+cHmRV
         AmRm3raGABqSSG3uI9hMr9GXwYeXdrS7khcgPgKcNYs6LW7uaCx4RctQiAXklV/00vD+
         fNXrnRqu3poAkSR/9KUbMwufeMCaoHKATQ1G4=
Received: by 10.86.82.16 with SMTP id f16mr2522227fgb.26.1238959704994; Sun, 
	05 Apr 2009 12:28:24 -0700 (PDT)
In-Reply-To: <7vmyausz3h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115684>

On Sun, Apr 5, 2009 at 10:02 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> This is the list of actions I've mapped:
>>
>> =C2=A0* add: git stage =3D git stage add (git add)
>> =C2=A0* rm: (git rm --cached)
>> =C2=A0* diff: (git rm --cached)
>> =C2=A0* import: stage all files; modified, deleted, new
>> =C2=A0* ls: (git ls-files --stage)
>
> I do not think these are good ideas at all, as it just spreads more
> confusion, not less.

Do you agree that there's already a lot of confusion? (stage, cache,
index, etc.)

And do you agree that many git newbies don't use the stage? Actually
most of them don't even know what it is, and just do "git commit -a".

If so, how do you think these issues should be handled?

--=20
=46elipe Contreras
