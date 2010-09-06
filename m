From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH v2] string-list: Document STRING_LIST_INIT_* macros.
Date: Sun, 5 Sep 2010 21:15:08 -0300
Message-ID: <AANLkTi=cfOaivQ0OcLw8XU4JXAnW8kPj1SZbOOQPs2ua@mail.gmail.com>
References: <1283730055-14477-1-git-send-email-tfransosi@gmail.com>
	<20100905235752.GA18060@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 02:15:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsPMj-0006Wu-Ly
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754909Ab0IFAPK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Sep 2010 20:15:10 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34583 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab0IFAPJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Sep 2010 20:15:09 -0400
Received: by qwh6 with SMTP id 6so3417890qwh.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 17:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xHweBjas3h/y+gNHSNdl41y0KUbxs2LkU9YISt4I39k=;
        b=SiEOL8eieyef7gvy3/rCxL5Ck+yyPle1KHKQN5Sn/p8ihsuo843xQYbjyhi63zX4BE
         uVbrqn5aUaQ/vQIzdXvXKsezPhf6r9pBPwarP1Pdzv5tcWBufYmkuoHbhNGIjE7IIocy
         jcbzQYKeJA9GJOgNAMgpz5V8edQei5YUP4Ac0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NpfKP4z9l2CjOvcKQgVGNZA6JtqvCgqbY91oFWo/TGHQFr4676Qvg8HD2Wvbtd3WJN
         qgktrwP103M1ze8u1D43VizvXRm02YW/0Gd9jbVCo/8IISzofajw0x87VRzjzodDBGaB
         CNfP+LgJjclExxeyf+8Jn6z+5S/sA6tuPxA64=
Received: by 10.224.60.213 with SMTP id q21mr1195570qah.65.1283732108677; Sun,
 05 Sep 2010 17:15:08 -0700 (PDT)
Received: by 10.229.245.202 with HTTP; Sun, 5 Sep 2010 17:15:08 -0700 (PDT)
In-Reply-To: <20100905235752.GA18060@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155504>

On Sun, Sep 5, 2010 at 8:57 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hmm, something seems to have go wrong here. =C2=A0Did you intend to
> insert that line break and duplicate the text below it?
>
Ops, good catch. Fixed that.

>> @@ -52,6 +58,18 @@ However, if you use the list to check if a certai=
n string was added
>> =C2=A0already, you should not do that (using unsorted_string_list_ha=
s_string()),
>> =C2=A0because the complexity would be quadratic again (but with a wo=
rse factor).
>>
>> +Macros
>> +------
>> +
>> +`STRING_LIST_INIT_NODUP`::
>> +
>> + =C2=A0 =C2=A0 Initialize the members and set the `strdup_strings` =
member to 0.
>
> I think this section is not very useful.

OK, removed that section.
