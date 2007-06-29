From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: Applying patches in a directory that isn't a repository
Date: Fri, 29 Jun 2007 15:37:31 +0930
Message-ID: <93c3eada0706282307i7a22bd27w6ca10839d36ea4eb@mail.gmail.com>
References: <93c3eada0706280153w1898be80u7785ef2b2b1dd188@mail.gmail.com>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 29 08:07:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I49do-0000VD-Rw
	for gcvg-git@gmane.org; Fri, 29 Jun 2007 08:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751689AbXF2GHe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jun 2007 02:07:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbXF2GHe
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jun 2007 02:07:34 -0400
Received: from mu-out-0910.google.com ([209.85.134.190]:61302 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813AbXF2GHd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jun 2007 02:07:33 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1139814mue
        for <git@vger.kernel.org>; Thu, 28 Jun 2007 23:07:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q9lhVv6f78W6Vw03l/O8EX39uY0tDnOmz0Udhph3aQN4Cj9UKB2TmrNqQOYc1h5d6VEicUcFZSBOgNenX2SG+ypUY6Xa3YkRCtDv1ifABnqdCJeDn1lNSf6nvEB+HtIKLAnGdeqW5yvi9CAtujkIi3GZXR1ah6KXDFAYxHieVQ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=L2e7zUs1ugQakZ4Mxa1nSfl29ntAa+G/Wzc7pfEQMIFN8cpw2RwusT76Gr/F5A7A5rKHE3PSd2ianiPbWTgEVh/Y/m/6WJePUu4AMhszxOGoyVjn0k+/5Cz+QcZ7WyVi2zTlZuxB79K71iTf9uay0jXFF0kxbPgQVuuVrRhVNZY=
Received: by 10.82.112.16 with SMTP id k16mr5487192buc.1183097251555;
        Thu, 28 Jun 2007 23:07:31 -0700 (PDT)
Received: by 10.82.141.14 with HTTP; Thu, 28 Jun 2007 23:07:31 -0700 (PDT)
In-Reply-To: <93c3eada0706280153w1898be80u7785ef2b2b1dd188@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51149>

Hi,

I'm trying to use git for software distribution.

The system is a directory of about 450mb comprising binaries,
datafiles and scripts. The
full repository is about 1.1gb.   The users don't really need .git
except when we
login to pull upgrades for them. It would be nicer not to have the
.git directory and
just distribute patches which we would apply for our users.

But "git am" needs (AFAIK) a full repository. Is there a way to apply
a patch without
.git being present?

I can see the advantages of our users having the full repository, so maybe
we should just distribute by DVD (currently we use CDs) and forget
about it, but for
download purposes, 450mb is nicer than  1.1gb.

Cheers,
Geoff Russell
