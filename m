From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Recover broken git repository?
Date: Tue, 14 Jul 2009 08:20:57 -0700 (PDT)
Message-ID: <m3eisjuw8d.fsf@localhost.localdomain>
References: <1247577632053-3255106.post@n2.nabble.com>
	<20090714145432.GA12928@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Florian Breitwieser <florian.bw@gmail.com>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Tue Jul 14 17:21:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQjop-0003B1-IN
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 17:21:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754900AbZGNPVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754828AbZGNPVI
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 11:21:08 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:43511 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754792AbZGNPVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 11:21:07 -0400
Received: by bwz28 with SMTP id 28so846263bwz.37
        for <git@vger.kernel.org>; Tue, 14 Jul 2009 08:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=O+Hh5FEZpgg9nKUKdEdO1xJWw60ovw97bE8hJc76nP8=;
        b=UG+hFhuGynUO9ti8yee1x83YzYQI4648I4OduX03rHY2+k7q2SxNKgcbvrgWWQYl8Y
         1/zxOKYMOQtmNP4VgVZLWerIT7Ft7YxL1jTfMtfUoNiPm2fwA4VrwLKmwnf5vkdfn5i9
         fO2CkS8AHxWjIQZhGPpWqZB+O67T99u/AfnMk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=uK8CE+TSQhEzQYMW6WBYn5QeL2iD8TZjtTkdBRLU3CVS/3+Q741sd2lr/DH8+w4MkE
         BN/d/kX3wsT+I5UrIglPg1mZi+kmiYBj+SYAnVhW0BvtRMz5xBFjEjworYfUaUIFvii1
         pzgBNKYYUqzqEgfidj7EJODouCVJDtbd0o8Zc=
Received: by 10.103.238.4 with SMTP id p4mr3403772mur.68.1247584858061;
        Tue, 14 Jul 2009 08:20:58 -0700 (PDT)
Received: from localhost.localdomain (abvk144.neoplus.adsl.tpnet.pl [83.8.208.144])
        by mx.google.com with ESMTPS id i5sm28208641mue.55.2009.07.14.08.20.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Jul 2009 08:20:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6EFKsQ0020864;
	Tue, 14 Jul 2009 17:20:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6EFKqVt020860;
	Tue, 14 Jul 2009 17:20:52 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20090714145432.GA12928@vidovic>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123255>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
> The 14/07/09, Florian Breitwieser wrote:
> 
> > I have problems with my git repository, attached below are the steps I tried
> > to resolve it. But now I am stuck. Is there any good way to recover?
> 
> You could git-format-patch your topics, clone a new repo and git-am the
> patches.

Better solution, if possible, would be to use git-fast-export /
git-fast-import pair.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
