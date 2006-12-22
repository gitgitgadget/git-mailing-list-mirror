From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable)
Date: Fri, 22 Dec 2006 21:56:20 +0100
Message-ID: <200612222156.21215.jnareb@gmail.com>
References: <7vodpw46zj.fsf@assigned-by-dhcp.cox.net> <emhdir$he9$1@sea.gmane.org> <7vejqrznwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 21:53:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxrOg-0001x7-PO
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 21:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674AbWLVUxk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 22 Dec 2006 15:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752700AbWLVUxk
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 15:53:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:63901 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbWLVUxj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 15:53:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3080323uga
        for <git@vger.kernel.org>; Fri, 22 Dec 2006 12:53:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=uAXL8JmBytG7ENphr0U8Trnz5HOs4/R+utxBm9uNeTzQgQg0B7bssBn2x34UssrWdhcrOcqkjZLSFlk8YTZ8ilK4CZ8INbBReHA1SZRRmmvV9ojITVwG3utVg4ZU5sczdtnc4a7L1BumW73+p1TEFKd2BC7N61/VkHnTL4KCxYc=
Received: by 10.67.92.1 with SMTP id u1mr12903516ugl.1166820817645;
        Fri, 22 Dec 2006 12:53:37 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107])
        by mx.google.com with ESMTP id c1sm2057656ugf.2006.12.22.12.53.37;
        Fri, 22 Dec 2006 12:53:37 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
User-Agent: KMail/1.9.3
In-Reply-To: <7vejqrznwo.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35216>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
>> <opublikowany i wys=C5=82any>
>>
>> Junio C Hamano wrote:
>>
>>> Possibilities:
>>>=20
>>> =C2=A0(1) Forget about that "protection" business. =C2=A0If you do =
not
>>> =C2=A0 =C2=A0 =C2=A0want mistakes, use 'branch.*.merge' but otherwi=
se we will
>>> =C2=A0 =C2=A0 =C2=A0continue to follow the good old "first set of b=
ranches"
>>> =C2=A0 =C2=A0 =C2=A0rule.
>>
>> What about marking default branch to merge explicitely using
>> "Merge:" in remotes/<repo>, or remote.<name>.merge?
>=20
> Sorry, how is that an improvement over the current branch.*.merge?
> and how would that help not breaking existing setups?

I meant that in addition to forgetting about "protection" business.
This would be intermediate improvement over old behavior, marking
clearly which is default branch to merge (with first branch still
being default, and perhaps error out if there is _only_ wildcard
Pull:/fetch line/variable; the branches marked with + are ineligible
as candidate for merge with "first branch being default branch to
merge" default).

Perhaps make "protection" business optional, default to on for
new users?
--=20
Jakub Narebski
Poland
