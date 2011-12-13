From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: migrating from svn: How to clean up history?
Date: Tue, 13 Dec 2011 07:12:21 -0800 (PST)
Message-ID: <m362hkh5em.fsf@localhost.localdomain>
References: <4EE766D5.5040702@goebel-consult.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hartmut Goebel <h.goebel@goebel-consult.de>
X-From: git-owner@vger.kernel.org Tue Dec 13 16:12:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaU1u-0007bu-7j
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 16:12:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746Ab1LMPMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 10:12:25 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56719 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753212Ab1LMPMZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 10:12:25 -0500
Received: by eekc4 with SMTP id c4so2166181eek.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=UdRrXW6lOPclxwKMEPx93xl9R8CwANj3IvEu4epXSbk=;
        b=B0FbIvDkaEZ/2JubvdIxGpntq8O7rase0tiV3qgKe0drlC6vwiHSlWLEhUpva9SOxK
         WzTrExIKGkvQulTZasDrgQXjcJuOPHFf/QTlXs621pcHQKbNPNFksV9cNJaWWFBO7EDw
         VZM5TjzNQvRmyb1uz6UWSrQRSSYlOJBzBVBN4=
Received: by 10.14.9.165 with SMTP id 37mr2555832eet.173.1323789142207;
        Tue, 13 Dec 2011 07:12:22 -0800 (PST)
Received: from localhost.localdomain (abvm99.neoplus.adsl.tpnet.pl. [83.8.210.99])
        by mx.google.com with ESMTPS id 58sm90114278eet.11.2011.12.13.07.12.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 07:12:21 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id pBDFCYAK020094;
	Tue, 13 Dec 2011 16:12:34 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id pBDFCXlE020090;
	Tue, 13 Dec 2011 16:12:33 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4EE766D5.5040702@goebel-consult.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187029>

Hartmut Goebel <h.goebel@goebel-consult.de> writes:

> I'm one of the developers of www.pyinstaller.org, a tool for
> bundling/packagin Python scripts and al required modules into a single
> executable for easy distribution. We are in the process of migrating
> from Subversion to git.
> 
> Our SVN-Repo contains some stuff we do not want or do not need in the
> git repo. How can we clean this up?
> 
> 1) Useless commits e.g. tagging -> I want to remove these
> 2) copy or move mistakes -> I want to "correct" the copy
[...]

> Any hints how to to this clean-up?

You can try "gitsvnparse" command from 'reposurgeon' tool to
automatically correct some conversion mistakes, and use this tool to
do further fixes

  http://www.catb.org/esr/dvcs-migration-guide.html
  http://www.catb.org/~esr/reposurgeon/

HTH
-- 
Jakub Narebski
