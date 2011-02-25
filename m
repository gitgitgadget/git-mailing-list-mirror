From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 17/73] gettextize: git-branch "Deleted branch [...]"
 message
Date: Fri, 25 Feb 2011 01:54:29 -0600
Message-ID: <20110225075429.GF23037@elie>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-18-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 08:54:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PssVe-0001KS-4i
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 08:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916Ab1BYHyh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 02:54:37 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:38058 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755633Ab1BYHyg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 02:54:36 -0500
Received: by vxi39 with SMTP id 39so1167349vxi.19
        for <git@vger.kernel.org>; Thu, 24 Feb 2011 23:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=S1jTXKf9EAyIrQAYlJg4paaSaHbzNmdowz6dmkhbLWA=;
        b=G9pcPiRXrUQgZdWqhyVTtD1a880R/qU7G+Y9lSIDaxGeA4+MGBwvY1aqeee6Xs+9or
         V0Hn5eI7KRhFNgyXJR7YLZPV1J1eUMQeDWJrH5CDk7HUyGTIGJLEuoOx6spW54DyUjJB
         0CI5mSjME0m8lBFiCpjq2moEpbPgIDEkbLRO4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=I34d9ZdgXSlwzijbh6/ebEkqecvyv5MYqjbEW2hrh4ExFPI2liWguXBrceqB9S8v4k
         705RDUtAichw1doLtLVRJK0Lwku72/KfL+LCiRIC1nC6z2IFbIkP+TH1GnrOAXsXB5QE
         QY9uZVGjzLqq4G8gWzHogBKxsB4t9iWvj14L0=
Received: by 10.52.161.67 with SMTP id xq3mr3444354vdb.57.1298620475755;
        Thu, 24 Feb 2011 23:54:35 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id b26sm318864vby.13.2011.02.24.23.54.33
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Feb 2011 23:54:34 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1298418152-27789-18-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167881>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -214,7 +214,7 @@ static int delete_branches(int argc, const char *=
*argv, int force, int kinds)
>  			ret =3D 1;
>  		} else {
>  			struct strbuf buf =3D STRBUF_INIT;
> -			printf("Deleted %sbranch %s (was %s).\n", remote,
> +			printf(_("Deleted %sbranch %s (was %s).\n"), remote,

This patch might be might easier to read squashed with the previous
one (both for the sake of providing context to reviewers and avoiding
mixed-language output :)).
