From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Displaying Current Git Aliases
Date: Thu, 25 Jun 2009 09:33:49 -0700 (PDT)
Message-ID: <m33a9oxogk.fsf@localhost.localdomain>
References: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Tim Visher <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 25 18:34:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJrtf-0006Fc-L4
	for gcvg-git-2@gmane.org; Thu, 25 Jun 2009 18:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbZFYQdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2009 12:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbZFYQdt
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jun 2009 12:33:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:50413 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752119AbZFYQds (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2009 12:33:48 -0400
Received: by fg-out-1718.google.com with SMTP id e21so317832fga.17
        for <git@vger.kernel.org>; Thu, 25 Jun 2009 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=JV6t5iINJFs+8MA19J77uuG+v3dMleOPNsIrMhJk5fo=;
        b=j1vzX+emedQ+MjWpv1pgp5Bo+NK1baVBy2RktK8CXYWwX9L3c2YvL3XJhIJ2XZyQTq
         4Otj2UEvXjkjDGR0BZClhWeZcHhJOlR15X6a47DagLqKDhuY0J6FQdy//veXzstEUUD6
         Mf8gOWTIZHlc+nC36PNrgppOPa+obaQiXapgw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=S3jqRlP99QZjIc3mtwqTaC3bzgcvGzqkbrhn+3Qs9FuYC6my+Hkmc33bEnTLeWLR3y
         NJFHh9tRIWX4mZHnOX9XcjeGw1ZCFIV4waoLnqAKJiTc8soPiZk8H0RXogbEs/s4aBQK
         54m6d8goJ61B5Y3jWmSjwIzd6I13o13hI5s38=
Received: by 10.86.93.17 with SMTP id q17mr2768985fgb.75.1245947630344;
        Thu, 25 Jun 2009 09:33:50 -0700 (PDT)
Received: from localhost.localdomain (abwu167.neoplus.adsl.tpnet.pl [83.8.244.167])
        by mx.google.com with ESMTPS id 12sm4480151fgg.14.2009.06.25.09.33.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Jun 2009 09:33:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5PGXnIS021219;
	Thu, 25 Jun 2009 18:33:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5PGXlTh021216;
	Thu, 25 Jun 2009 18:33:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <c115fd3c0906250859q661d2319i463d6eea7e9dbe54@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122220>

Tim Visher <tim.visher@gmail.com> writes:

> Can git display a list of all of your current aliases like bash's
> `alias` command?

In ~/.gitconfig:

  [alias]
        alias = config --get-regexp ^alias\\.

Then you can simply use "git alias" to get list of all of your current
aliases.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
