X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Submodules in GIT
Date: Sun, 3 Dec 2006 02:31:05 +0100
Message-ID: <200612030231.05900.jnareb@gmail.com>
References: <20061120215116.GA20736@admingilde.org> <eksmrf$c33$1@sea.gmane.org> <200612030224.50592.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Sun, 3 Dec 2006 01:29:21 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=gUWP+v99JgCVqEB/mfaM0ohWNqJgazQ/k/KFPWrvFSKfKIsJ/tPtPyP8l6Og+5JiRFI6exjfNhx8c69l6muZkpIIc5YPOWzWQ+tt4QsIr7EBctMPwqQy39E4t6ITFEBUuZuDO8K8UPU1tEzn6Pjfcu50Ui2fgOXoeoc/18UcWTg=
User-Agent: KMail/1.9.3
In-Reply-To: <200612030224.50592.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33077>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqgAK-0003Ai-Qs for gcvg-git@gmane.org; Sun, 03 Dec
 2006 02:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1758558AbWLCB3J convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006 20:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758563AbWLCB3J
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 20:29:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:60593 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1758558AbWLCB3H
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 20:29:07 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2710401uga for
 <git@vger.kernel.org>; Sat, 02 Dec 2006 17:29:03 -0800 (PST)
Received: by 10.67.27.3 with SMTP id e3mr9640826ugj.1165109343707; Sat, 02
 Dec 2006 17:29:03 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id k28sm19303394ugd.2006.12.02.17.29.03; Sat, 02 Dec
 2006 17:29:03 -0800 (PST)
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org

Dnia niedziela 3. grudnia 2006 02:24, Robin Rosenberg napisa=B3:
> l=F6rdag 02 december 2006 21:16 skrev Jakub Narebski:
> > The problem with submodule as separate git repository is that if yo=
u
> > move submodule (subproject) somewhere else in the repository (or ju=
st
> > rename it), you have to update alternates file... and this happens =
not
> > only on move itself, but also on checkout and reset. But that can b=
e
> > managed by having in alternates all possible places the submodule e=
nds
> > into. I don't know if it is truly a problem.
>=20
> A nasty problem with separate repositories for submodules is that whe=
n you=20
> screw up and git complains about everything you try do do, you previo=
usly=20
> could do rm -rf *; git reset --hard and retry whatever you were tryin=
g to do.=20
> With separate repositories your submodules will be resting in /dev/nu=
ll,=20
> unless you're very, very careful.=20

Actually, rm -rf * is not needed for "git reset --hard" or
"git checkout -f" to succeed.

--=20
Jakub Narebski
