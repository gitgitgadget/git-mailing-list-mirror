From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH] tg-graph: print dependency graph like git log 
	--graph
Date: Tue, 19 May 2009 15:32:00 +0200
Message-ID: <36ca99e90905190632q656a5855qe7624902ef82a3da@mail.gmail.com>
References: <1242711875-25666-1-git-send-email-bert.wesarg@googlemail.com>
	 <20090519102742.GA28702@noris.de>
	 <36ca99e90905190337y63aeb98ag59ff37688f75ba96@mail.gmail.com>
	 <20090519110800.GB28702@noris.de>
	 <36ca99e90905190448k64ee18afw8abc49bd90ecb58f@mail.gmail.com>
	 <20090519131044.GD28702@noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	martin f krafft <madduck@debian.org>,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Adam Simpkins <adam@adamsimpkins.net>
To: Michael Radziej <mir@noris.de>
X-From: git-owner@vger.kernel.org Tue May 19 15:32:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6PQV-0005nO-7z
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 15:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbZESNcF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 May 2009 09:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753440AbZESNcD
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 09:32:03 -0400
Received: from mail-bw0-f174.google.com ([209.85.218.174]:33874 "EHLO
	mail-bw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZESNcB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 May 2009 09:32:01 -0400
Received: by bwz22 with SMTP id 22so3827033bwz.37
        for <git@vger.kernel.org>; Tue, 19 May 2009 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OEt6DH+0PXqhTcivtOxAml552x14QLG5Kdgxxv/DZRk=;
        b=BU4tyocz10tEdYsBAji3IMTk/tnrFAitANs3Edv6GU8ScaQxJH8Opb5+gvLRjORPW3
         y+zXML/OeAYe5RttHGZiaK4cYrDTwVLlv+cIbCgI52xLhChWFcZW70OegpUm0mGKUGS4
         7tYf2+yux3Pvo5ra05kjtbFa9HZvknA6EPi2U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=uhWA0EUYqs+MaUrd1u1+XDM7GSonpQQQeQS8cMn5WvypSNAG+/1toWje/znZcS6BPe
         iwIAYwp9E+BQFC/WGAzM5imHf8nJ25gw4xHMiR1+Pm7RSWMtYoHz3jTTlhvBO+eVy1vh
         jvHsT8oJkbzFtmgwIzNBI6OJpzZePjuY7W9SU=
Received: by 10.204.57.81 with SMTP id b17mr37979bkh.186.1242739921537; Tue, 
	19 May 2009 06:32:01 -0700 (PDT)
In-Reply-To: <20090519131044.GD28702@noris.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119526>

On Tue, May 19, 2009 at 15:10, Michael Radziej <mir@noris.de> wrote:
> On Tue, May 19, Bert Wesarg wrote:
>> And you see the error with all 3?
>
> Yes
>
>>
>> Can you send the output from 'tg summary --graphviz' too?
>
> # GraphViz output; pipe to:
> # =C2=A0 | dot -Tpng -o <ouput>
> # or
> # =C2=A0 | dot -Txlib
>
> digraph G {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0graph [
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rankdir =3D "T=
B"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0label=3D"TopGi=
t Layout\n\n\n"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fontsize =3D 1=
4
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0labelloc=3Dtop
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pad =3D "0.5,0=
=2E5"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0];
>
> \t"t/conflicts" -> "master";
> \t"t/python" -> "master";
> \t"t/tg-graph" -> "master";
> }
can you remove the '\t' and pipe the resulting file into this command
inside your topgit work dir:

cat "$file" | gvpr -f share/graph.gvpr

Bert

>
> Michael
