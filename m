From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Useful tracking branches and auto merging
Date: Tue, 5 Oct 2010 00:06:17 +0300
Message-ID: <AANLkTi=nsv58ai1G6DhN935FY20U3AAjSC3OoitB-8st@mail.gmail.com>
References: <AANLkTimq0sKUavKiXepDOz+DvrymuRAVUyAyV+FzbCBD@mail.gmail.com>
	<20101004204625.GH6466@burratino>
	<AANLkTikkXdDepdeOY4MZvgfCEgX69Tx6d0-QS-g3bWK-@mail.gmail.com>
	<20101004205725.GJ6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 23:06:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2sEr-0005Ub-PA
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 23:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756297Ab0JDVGT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Oct 2010 17:06:19 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43043 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab0JDVGT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 17:06:19 -0400
Received: by bwz11 with SMTP id 11so4008350bwz.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 14:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ayoVeLk4f44Tzdo7Ghr2cOS5ozcDteaIux+J+yETzKE=;
        b=j6qY8WSw1dioOPCxp2s/EfSNDv2ca8XJq/5ktbyp9v7QhnOoekYDmgyGU358S2ROYH
         fs5rcOkmrVBxPNICdrQM6vHp2iBgoYGf6aoh+iDJrHOjOaGhmGPqogEw2LO5sTlXZrg3
         /45O48UJSKoOroyXxSvaAg0PM9YxEbOaGICYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bzNVuNe0C4bei5SVAMBBibTaZuejHON8lBAFlxixnLbv8MRR7fNNCGFpzNszbZwZHx
         PJy3/OoRE9xacJJAMfBbJ/I8TorD//nCd5OfGc0LjDYnz87PbQrsLUK9x9GngoZzjeuY
         D5AgTNvjkrKJnofbf35lACRj9ksZXFPoJj65M=
Received: by 10.204.116.79 with SMTP id l15mr7520258bkq.158.1286226377650;
 Mon, 04 Oct 2010 14:06:17 -0700 (PDT)
Received: by 10.204.152.142 with HTTP; Mon, 4 Oct 2010 14:06:17 -0700 (PDT)
In-Reply-To: <20101004205725.GJ6466@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158118>

On Mon, Oct 4, 2010 at 11:57 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Felipe Contreras wrote:
>> On Mon, Oct 4, 2010 at 11:46 PM, Jonathan Nieder <jrnieder@gmail.com=
> wrote:
>>> git merge @{u}
>>
>> Interesting, I don't find anything like that in the documentation.
>
> The @{upstream} notation is documented in gitrevisions(7). =C2=A0But =
yes,
> a more prominent mention (maybe some examples?) would be nice.
>
>> Moreover, wouldn't it make sense to make 'git merge' =3D 'git merge
>> @{u}'?
>
> I think so, yes. :)

Great :)

> If I remember correctly, the current status is:
>
> =C2=A0- 'git remote' is for adding, removing, and pruning remotes
> =C2=A0- 'git fetch <remote>' and 'git fetch --all' are for updating t=
hem, and
> =C2=A0- 'git remote update' is for backward compatibility.

Oh, I thought 'git remote update' was newer. If 'git fetch --all' is
supposed to be used instead, then I guess 'git pull --all' makes
sense, but personally I would like it to error out if the merge is not
fast-forward.

Cheers.

--=20
=46elipe Contreras
