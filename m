From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Any tricks for speeding up cvsps?
Date: Fri, 08 Feb 2008 04:24:35 -0800 (PST)
Message-ID: <m3ir0zhc09.fsf@localhost.localdomain>
References: <47AC1FDC.9000502@glidos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Gardiner <osronline@glidos.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 13:25:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNSIB-0007xq-BT
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 13:25:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757641AbYBHMYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 07:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754526AbYBHMYp
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 07:24:45 -0500
Received: from wa-out-1112.google.com ([209.85.146.183]:11931 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757471AbYBHMYo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 07:24:44 -0500
Received: by wa-out-1112.google.com with SMTP id v27so414782wah.23
        for <git@vger.kernel.org>; Fri, 08 Feb 2008 04:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=iSKemZLKfoYU7sdWcVZq99hfqx+E6r2GDUQiV2VwSRk=;
        b=JTJjdpvzNE0IU6OqbdAPXGpVfjRJvS2qjOYvdV3Kj91YdegBtHj1LqIoqwhj+IwNXJU/YyrO1CUReCgOUAER7uNjtxg2vi3IBNCw2rdztKw2kZpgjhLSPmlWSPjcFucZUNann6fyo7XSxsSZ0C1Avq0lz4pZ9plsdZuu0BvLiDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=KQ6CKb9sK8+lhz3brqc0RiDPP+wSMK6UY31iQN94adULZh8ar6Et/m5Z+qqKN69JEwEIUP7cHE4ppOjj9v6DDF9tSFXCfbtqn34pBZFFXVua5T2YjDCzTX0VoOwvJZ6vJ6B7PBTvk4Bg90ZUhy3ylPKQOcxXJzqa0zeMb4dOLB4=
Received: by 10.115.108.1 with SMTP id k1mr1566873wam.141.1202473478647;
        Fri, 08 Feb 2008 04:24:38 -0800 (PST)
Received: from localhost.localdomain ( [83.8.242.186])
        by mx.google.com with ESMTPS id h7sm463859nfh.24.2008.02.08.04.24.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 08 Feb 2008 04:24:36 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m18COOpL027981;
	Fri, 8 Feb 2008 13:24:24 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m18CONuS027978;
	Fri, 8 Feb 2008 13:24:23 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <47AC1FDC.9000502@glidos.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73083>

Paul Gardiner <osronline@glidos.net> writes:

> I'm trying to convert a huge cvs repository. I've left cvsps running
> for days. First attempt, stderr filled my disc with warnings about
> tags that couldn't be associated with any one commit, without
> producing anything from stdout. I'm now redirecting stderr to
> /dev/null, but it still just sits there producing nothing.  Is
> git-cvsimport infeasible for large repositories, or are there tricks
> I might use?

Please check other tools to import from CVS; they are mentioned
on the

  http://git.or.cz/gitwiki/InterfacesFrontendsAndTools

wiki page ("Interaction with other Revision Control Systems" section)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
