From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's in git.git (stable) and announcing GIT 1.5.0 preview
Date: Tue, 26 Dec 2006 20:02:08 +0100
Message-ID: <200612262002.08862.jnareb@gmail.com>
References: <7v3b73gx43.fsf@assigned-by-dhcp.cox.net> <emr01i$hcb$1@sea.gmane.org> <20061226132204.GB6558@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 26 19:59:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzHWX-0004WD-La
	for gcvg-git@gmane.org; Tue, 26 Dec 2006 19:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932740AbWLZS7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 26 Dec 2006 13:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932754AbWLZS7W
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Dec 2006 13:59:22 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:11904 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740AbWLZS7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Dec 2006 13:59:21 -0500
Received: by ug-out-1314.google.com with SMTP id 44so3715220uga
        for <git@vger.kernel.org>; Tue, 26 Dec 2006 10:59:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=t1ulnjzF0OFqE++fJbn+NnfbZw3ghlakmHyneyzwQfbLbQUo/JcNFrtaueTpzcp6Tx1YcnJ3+QIMib33u66xcQUMGP3OR/29rbpTHL5Bio95l7XJ5GCsizaC6tg2Ag6SvuypfjLtbWFE7spsqAe1EqJDni79QEPPNzO1BdJk3JM=
Received: by 10.67.117.2 with SMTP id u2mr19115822ugm.1167159560063;
        Tue, 26 Dec 2006 10:59:20 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id z40sm18422440ugc.2006.12.26.10.59.19;
        Tue, 26 Dec 2006 10:59:19 -0800 (PST)
To: Robert Fitzsimons <robfitz@273k.net>
User-Agent: KMail/1.9.3
In-Reply-To: <20061226132204.GB6558@localhost>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35425>

Robert Fitzsimons wrote:
>>> =A0 =A0 =A0 gitweb: Allow search to be disabled from the config fil=
e.
>>=20
>> Hmmmm... IIRC this did not removed the search form. Besides it is no=
t like
>> the basic search is expensive...
>=20
> I just double checked.  The search feature is enabled by default, whe=
n
> the feature is disable the search form isn't shown.
>=20
> I don't mind if this change is reverted.

I'm sorry. My mistake. And it is turned on by default, and not overrida=
ble
by default (checking overridable feature is one call to git-repo-config=
,
at least now), and I have nothing against this feature.

--=20
Jakub Narebski
Poland
