From: demerphq <demerphq@gmail.com>
Subject: Re: git silently ignores aliases of existing commands
Date: Sat, 18 Jul 2009 11:30:25 +0200
Message-ID: <9b18b3110907180230p7fb432cdq56bfee794afc669e@mail.gmail.com>
References: <4A611CE1.3080709@pobox.com>
	 <BLU0-SMTP9743008F68C14C8226D07BAE1F0@phx.gbl>
	 <4A6176E6.4060708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sean Estabrooks <seanlkml@sympatico.ca>, git@vger.kernel.org
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 11:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MS6NJ-00034f-CO
	for gcvg-git-2@gmane.org; Sat, 18 Jul 2009 11:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753620AbZGRJia convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jul 2009 05:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753507AbZGRJia
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Jul 2009 05:38:30 -0400
Received: from mail-px0-f185.google.com ([209.85.216.185]:56064 "EHLO
	mail-px0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938AbZGRJi3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jul 2009 05:38:29 -0400
Received: by pxi15 with SMTP id 15so966037pxi.33
        for <git@vger.kernel.org>; Sat, 18 Jul 2009 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2WFai7Lq+wep4wHG3dWykyXxe0yptWvA+FzCeKAVilU=;
        b=hjfAeT0iWZ2hSY2jTsL0C+Xdx0BnSrL/u85ZgYzcL20hi3x2C05hILVnuFiTzFvKlq
         8cmurceoTCSKo5+ii4u2dAVVUgFVX8I/xp66o7kLogxQN+1vg3pMVEVDUioGlI8/zaai
         7Lehl1BKy0cmlJ2dD4WVz8mHP3+TvXIz5kN10=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uReH2jfMQZLjKaBwU5W0eAKJI+dCMGAvQvAoCOGXMIWw0P8XibgVMlxNJm50aka2fe
         zv5hvA4HylfKn++lefkcKct5mrtWA0oSlIf8Ja1+b4dNBLs8g3+mLV3e86wZdy120j6E
         B33JZXztgeXWQlane+YDA3dQFMElcpiSJxqHM=
Received: by 10.142.230.3 with SMTP id c3mr446931wfh.166.1247909425361; Sat, 
	18 Jul 2009 02:30:25 -0700 (PDT)
In-Reply-To: <4A6176E6.4060708@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123512>

2009/7/18 Michael G Schwern <schwern@pobox.com>:
> Sean Estabrooks wrote:
>> On Fri, 17 Jul 2009 17:52:49 -0700
>> Michael G Schwern <schwern@pobox.com> wrote:
>>
>> [...]
>>> It would be nice if git used the alias *before* the installed comma=
nd. =A0This
>>> lets me fix/change default behaviors without having to come up with=
 a new
>>> command. =A0(Another handy example: =A0blame =3D blame -w) =A0It do=
esn't do anything
>>> useful right now anyway.
>>
>> This has been discussed a few times on the list already. =A0 Here is=
 one such
>> discussion:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/112487/focus=3D=
112493
>>
>> You'll see that it was decided that Git would not allow commands to =
be overridden
>> so that you could always be sure what a given command would do when =
you sit
>> down at any installation. =A0This is especially important for script=
ing but can
>> also be a problem for everyday usage. =A0 You'll just have to choose=
 a new command
>> name for the alternate default you want.
>
> I'm in the "more than enough rope" camp myself, so count that as a -1=
 fwiw.
>
> More importantly, what about the warning telling the user that what t=
hey did
> is not allowed and didn't work?

Yeah it seems reasonable that if its going to be ignored it should not
be silently ignored.

Especially given that the silentness effectively means there cant be
any new git tools added without possible breakage of installed setups.

cheers,
Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
