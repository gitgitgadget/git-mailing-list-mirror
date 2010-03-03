From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Which VCS besides git?
Date: Wed, 3 Mar 2010 02:41:16 +0100
Message-ID: <201003030241.16959.jnareb@gmail.com>
References: <201003021455.52483.karlis.repsons@gmail.com> <m3y6ialn3z.fsf@localhost.localdomain> <201003021622.22196.karlis.repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?utf-8?q?K=C4=81rlis_Repsons?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 03 02:41:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmdae-00034L-Qk
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 02:41:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229Ab0CCBl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 20:41:26 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:43657 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755033Ab0CCBlZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 20:41:25 -0500
Received: by fxm19 with SMTP id 19so1037767fxm.21
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 17:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2r5Gk9m91vxQBebnadLsvGsOSxZuUWj2X9viitd61zc=;
        b=gtBSuzDH39kSlRLyreyFU7QQNmgZmKOJOVrNXcnQVHF0+LrZ1L9xNHul+T1paambVr
         uXFhbcWiEKOQLvX1rYRS1UhTVyBGNihqRLknA2MQJmcGvhYHXGso6hhsRsg0TFj9tsPy
         gk+QbZnmND3V0m2M/uFU12pK0P6rp+ni/XCWk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=rtG/DwchZpq6aY6kZ84k199y9suFvD1MjmGh336izZAASmdudknlsPQO4QttKHA1nq
         yO3i+H9Stn309H9wA63x5UDMX9mZYQFtyJSza9uo4xb0RQ6hURcj7G7J2Qv1cUs7SxqV
         5rTNbuk4MJzYiShVn14E62wW678kvZg7lFv50=
Received: by 10.102.214.19 with SMTP id m19mr5454811mug.96.1267580483777;
        Tue, 02 Mar 2010 17:41:23 -0800 (PST)
Received: from ?192.168.1.13? (abvb141.neoplus.adsl.tpnet.pl [83.8.199.141])
        by mx.google.com with ESMTPS id j10sm894917mue.56.2010.03.02.17.41.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 17:41:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <201003021622.22196.karlis.repsons@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141431>

K=C4=81rlis Repsons wrote:
> On Tuesday 02 March 2010 16:12:22 Jakub Narebski wrote:
> > K=C4=81rlis Repsons <karlis.repsons@gmail.com> writes:

> > > which VCS besides git provide chaining of commits with help of so=
me
> > > cryptographic hash function, warning about or not allowing commit=
s to be
> > > deleted on an equivalent of pull action, so that all added pieces=
 of data
> > > can be retained securely on client side?
> >=20
> > Could you rephrase your request in more clear way?
>
> On top of what you wrote already, I'd like to know which VCS have imm=
utable=20
> history, which can all be stored (say, gradually accumulated) on clie=
ntside? I=20
> hope, that explained the idea...

As I wrote, all VCS which use cryptographic hash function (digest) for
commit identifier have immutable history.

All distributed VCS (DVCS) store whole[*] history with checkout.  There
isn't (beside _social_ reasons) any distinction between different repos=
:
there is no client - server model (so no "clientside"), but rather peer
2 peer model.  See http://en.wikipedia.org/wiki/List_of_revision_contro=
l_software#Distributed_model
(from OSS ones I'd say Git, Mercurial, Bazaar, Darcs, Monotone count).


[*] well, with possibly some exceptions, like shallow clone, or selecti=
ng
    branches to clone.

--=20
Jakub Narebski
Poland
