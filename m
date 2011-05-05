From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: How to fork a file (git cp ?)
Date: Thu, 5 May 2011 20:02:42 +0200
Message-ID: <BANLkTimD7byL=rgy79BWFT3vqKpzv9aNOQ@mail.gmail.com>
References: <4DC1934D.6070608@aldan.algebra.com>
	<4DC19955.7040503@kdbg.org>
	<7viptqdvrf.fsf@alter.siamese.dyndns.org>
	<4DC20461.4090703@aldan.algebra.com>
	<7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Mikhail T." <mi+thun@aldan.algebra.com>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 20:02:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QI2sy-000287-HU
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 20:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755499Ab1EESCo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2011 14:02:44 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:49843 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab1EESCn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2011 14:02:43 -0400
Received: by qyg14 with SMTP id 14so1836432qyg.19
        for <git@vger.kernel.org>; Thu, 05 May 2011 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wmyS2Oehn0XWB/50zQOAzerL54949rPfWzn+pCTlpWc=;
        b=C2MHI+yD+BwMmyFxZAdm+09Cawg9S62Gvw+dkcGMuhzfCHIkq6SmgsOVYLcSYsvtc/
         Xb5jBlZJxkH7Ui+K1p6PiUgE79EPmJCe77NnfBZVlI/KNaZotglJ42Lt0wqrUrAQbLfX
         G3LK1YDQder5q8rLakK/rn3cDv8a2tPjDcIBs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=slTrIMc0FqTrl91FEyfSrUP4VApmodrK2Ef8BMiyT33X8UGszUDodN4UKg4Pyw8iB1
         DuuClr+zsDykfewQ4enV0dQ6wEFLGjObEk8YNA8BwCnWybs/EE7fyvd5aDsuBvlsTcuh
         yW68WAKm6huga6w1ZmdQfDLf5hb5u5+QAAIBM=
Received: by 10.52.111.136 with SMTP id ii8mr3331086vdb.72.1304618562496; Thu,
 05 May 2011 11:02:42 -0700 (PDT)
Received: by 10.220.201.135 with HTTP; Thu, 5 May 2011 11:02:42 -0700 (PDT)
In-Reply-To: <7v1v0ddhbz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172862>

On Thu, May 5, 2011 at 4:14 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> "Mikhail T." <mi+thun@aldan.algebra.com> writes:
>
>> On 04.05.2011 17:02, Junio C Hamano wrote:
>>> Well, if you come from the mindset that a "file" has an identity (h=
ence
>>> there is a distinction between "This file used to be called A and a=
t one
>>> point was renamed to B which is the name we see today" and "Some ti=
me ago
>>> somebody created a file B with the same contents as A and then remo=
ved A
>>> at the same time"), "copy" would not make much sense. =A0What ident=
ity does
>>> a new file B gets when you create it by copying from A?
>> What I want is to signify something like: "This code was obtained fr=
om
>> that in file A."
>
> I think that is what exactly "blame -C -C" gives you.

Maybe Mikhail wanted to say that if there's a git-mv as a shortcut for
  "cp old new ; rm old; add new"
then there should be a git-cp as a shortcut for
  "cp old new; add new"

Just for convenience (and symmetry with git-mv).

He did write:
> "copy" -- of an individual file -- makes just as much sense as "move"=
 (rename).

--=20
Piotr Krukowiecki
