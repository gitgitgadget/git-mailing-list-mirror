From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: relative objects/info/alternates
Date: Fri, 14 Dec 2007 06:13:09 -0800 (PST)
Message-ID: <m3bq8tqs9c.fsf@roke.D-201>
References: <20071214140613.GA13259@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 15:13:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3BIV-0004p8-C8
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 15:13:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbXLNONQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 09:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbXLNONP
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 09:13:15 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:47947 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192AbXLNONO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 09:13:14 -0500
Received: by nf-out-0910.google.com with SMTP id g13so934763nfb.21
        for <git@vger.kernel.org>; Fri, 14 Dec 2007 06:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=oDQI3K3gX4QE4t+nUSvEp4CD4ue8sUnKcRHrYcYxTKo=;
        b=ImO1CcbgCdL5kxO/ywe1stoDzBIfV4OHOVSg4Y7fwg5dZBTqhGNAG2QIuGchwr5LWBL+hyRW/NbM14jazl9uQVZ0y9M/sVFEfx+tR86gzyLIAzoAlQ3MAGpCPQ1700SmvYDqHEhqH1MFAGCt3KRgrkpU6Yr/a2SVTr2f2EDzDEo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=DZHPESC7BnfRKtTAYsm9QEwDFsxrfSozkg+D1goZ853h19ZCVcW3voqs1tsKBTJf9VH6otHYji7hv0kct9SzUT7aTU7oRZDlmqad+DHurVwlMaU909lMUGhDWUebCJuR5oAmU0YlUZWy3a+NgmYmo/lpnj+FlSLCLwTmBMTS11E=
Received: by 10.82.152.16 with SMTP id z16mr8739174bud.17.1197641592641;
        Fri, 14 Dec 2007 06:13:12 -0800 (PST)
Received: from roke.D-201 ( [83.8.223.189])
        by mx.google.com with ESMTPS id g28sm12395254fkg.2007.12.14.06.13.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 14 Dec 2007 06:13:09 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBEED57W005523;
	Fri, 14 Dec 2007 15:13:05 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBEED4KS005519;
	Fri, 14 Dec 2007 15:13:04 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20071214140613.GA13259@bit.office.eurotux.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68308>

Luciano Rocha <luciano@eurotux.com> writes:

> Can I use relative $GIT_DIR/objects/info/alternates? Will the git
> commands work anywhere inside the working-copy despice the alternate
> being relative to the root of it?

>From the information in repository layout documentation:

  objects/info/alternates::
        This file records paths to alternate object stores that
        this object store borrows objects from, one pathname per
        line. Note that not only native Git tools use it locally,
        but the HTTP fetcher also tries to use it remotely; this
        will usually work if you have relative paths (relative
        to the object database, not to the repository!) in your
        alternates file, but it will not work if you use absolute
        paths unless the absolute path in filesystem and web URL
        is the same. See also 'objects/info/http-alternates'.

it looks like you can have relative paths in alternates.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
