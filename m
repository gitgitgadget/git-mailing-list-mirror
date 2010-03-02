From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Which VCS besides git?
Date: Tue, 02 Mar 2010 08:12:22 -0800 (PST)
Message-ID: <m3y6ialn3z.fsf@localhost.localdomain>
References: <201003021455.52483.karlis.repsons@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: =?iso-8859-4?q?K=E0rlis_Repsons?= <karlis.repsons@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 02 17:12:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmUhz-0007FD-Si
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 17:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753902Ab0CBQM0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 11:12:26 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:56090 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753619Ab0CBQMZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 11:12:25 -0500
Received: by fg-out-1718.google.com with SMTP id 19so107427fgg.1
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 08:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=UrQcrFyNWp0tdQ1FDPQCn/FBDi58NXUFyZfusEyMg3g=;
        b=DBEKp0O+lKlFZ3O+TmjNJaS17txKyX9kku02PQRG15tbjvzB3A6kaqVbAuETttYmUR
         WpLkOG8LFuCLvIv9+qg7MV7yekNs57MbLkrZcCZfMo3RucGg/6xY+lYypsWJKGhIoaLi
         Pwfeqb51a0FvNknqdULWSVGhEJNLiZGDQWzfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Kkvr4HyN+YjNe1NxjscpmCbHTcYbB/ozXGIdmtLpDk3liMFpg64h/NFNAxsMvqMXdF
         jogP9PRqRIoJHelcJ4Bb5ztjnlgkee0i73KQu8QwrQPuWnokNZcFGCViLFOPbiKhSQVa
         EsfWHLB8mSh6puPBp+QCeZ8IeLEnnkQJyNB8s=
Received: by 10.87.62.1 with SMTP id p1mr9994254fgk.42.1267546343880;
        Tue, 02 Mar 2010 08:12:23 -0800 (PST)
Received: from localhost.localdomain (abvb141.neoplus.adsl.tpnet.pl [83.8.199.141])
        by mx.google.com with ESMTPS id d6sm10735643fga.7.2010.03.02.08.12.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 08:12:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o22GBtAr015575;
	Tue, 2 Mar 2010 17:12:05 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o22GBiSY015571;
	Tue, 2 Mar 2010 17:11:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201003021455.52483.karlis.repsons@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141404>

K=E0rlis Repsons <karlis.repsons@gmail.com> writes:

> which VCS besides git provide chaining of commits with help of some=20
> cryptographic hash function, warning about or not allowing commits to=
 be=20
> deleted on an equivalent of pull action, so that all added pieces of =
data can=20
> be retained securely on client side?

Could you rephrase your request in more clear way?

If you want to know which VCS beside Git use cryptographic hash
function over commit info and commit parentage as commit id, then both
Monotone (from which Git borrowed this idea) and Mercurial use it.

Bazaar, if I understand it correctly, and from what I remember, uses
some UUID which includes commit digest as a commit identifier, but I
don't know if Bazaar have immutable history.

In Subversion you can change svn:log (or something like that)
property, i.e. change commit message, after the fact; I don't think
there is any check for that.  CVS doesn't support changesets, so it is
out of question.

I don't know about Darcs, or BitKeeper, or ClearCase, or Perforce.
--=20
Jakub Narebski
Poland
ShadeHawk on #git
