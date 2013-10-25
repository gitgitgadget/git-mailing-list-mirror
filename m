From: Jeremy Rosen <jeremy.rosen@openwide.fr>
Subject: Setting per-repository configuration for git
Date: Fri, 25 Oct 2013 09:12:35 +0200 (CEST)
Message-ID: <834511791.9670586.1382685155770.JavaMail.root@openwide.fr>
References: <884520645.9668515.1382684531443.JavaMail.root@openwide.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 25 09:12:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZbZZ-0003A1-59
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 09:12:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492Ab3JYHMh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Oct 2013 03:12:37 -0400
Received: from zimbra3.corp.accelance.fr ([213.162.49.233]:35075 "EHLO
	zimbra3.corp.accelance.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182Ab3JYHMh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Oct 2013 03:12:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id 5A87A6B555
	for <git@vger.kernel.org>; Fri, 25 Oct 2013 09:12:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra3.corp.accelance.fr
Received: from zimbra3.corp.accelance.fr ([127.0.0.1])
	by localhost (zimbra3.corp.accelance.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s4eHmzxodsHy for <git@vger.kernel.org>;
	Fri, 25 Oct 2013 09:12:35 +0200 (CEST)
Received: from zimbra2.corp.accelance.fr (zimbra2.corp.accelance.fr [213.162.49.232])
	by zimbra3.corp.accelance.fr (Postfix) with ESMTP id D71406B42F
	for <git@vger.kernel.org>; Fri, 25 Oct 2013 09:12:35 +0200 (CEST)
In-Reply-To: <884520645.9668515.1382684531443.JavaMail.root@openwide.fr>
X-Originating-IP: [213.162.49.238]
X-Mailer: Zimbra 7.2.2_GA_2852 (ZimbraWebClient - GC30 (Linux)/7.2.2_GA_2852)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236690>

Hello everybody

I am looking into the git configuration mechanism and there seem to=20
be a "hole" in use cases I'm trying to figure out...


git configurations can be saved at various places

* /etc/gitconfig : system-wide configuration
* ~/.gitconfig : user-wide configuration
* .git/config : repository-wide configuration

however I can't find a way to have the repository's configuration=20
saved and transmited with the repository in a way similar to how
=2Egitignore is transmitted...

Saving some configuration information within a repository is not=20
unknown in git. .gitignore does it, and submodule configuration=20
does it to.

I think it's important to have a way to have configuration options
be saved in a repository (and overridable with .git/config which=20
is local-repository only) because a lot of configurationoptions
 are meant to express repository policies (triangular workflows,
merge vs rebase, mail vs push) and it would make sense to have
them transmitted that way.

Knowing how mature git is I can only assume that this has already
been discussed and that there is a good reason not to do it. Is it
because of hooks ? would it break something I don't see in git ?

git (the project) shouldn't enforce policies on repositories, but
I think it makes sense for repositories to have a way to set default
policies on their clone...

Thx

Cordialement=20

J=C3=A9r=C3=A9my Rosen=20
+33 (0)1 42 68 28 04

fight key loggers : write some perl using vim=20


Open Wide Ingenierie

23, rue Daviel
75012 Paris - France
www.openwide.fr
