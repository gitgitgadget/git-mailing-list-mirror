From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: noob user, want checkins to all be forced to LF terminated
 lines
Date: Sat, 31 Jul 2010 15:38:20 -0500
Message-ID: <20100731203820.GA1773@burratino>
References: <i308gl$v6p$1@dough.gmane.org>
 <20100731044957.GA8920@burratino>
 <i30bg7$50k$1@dough.gmane.org>
 <20100731054437.GD14425@burratino>
 <i30g2s$dpt$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Sat Jul 31 22:39:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfIqJ-00052X-Sb
	for gcvg-git-2@lo.gmane.org; Sat, 31 Jul 2010 22:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab0GaUjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 31 Jul 2010 16:39:35 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:49849 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752540Ab0GaUje (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jul 2010 16:39:34 -0400
Received: by yxg6 with SMTP id 6so962536yxg.19
        for <git@vger.kernel.org>; Sat, 31 Jul 2010 13:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4gX37GpN6OgZJ7geygPuITEjMMc+25m7uY8IaKuUmsc=;
        b=bCwthU/SpRY85OKDXC0Gk3fGS/ZP+Cj6UYThErG7P4FP1BZK952h2A7whUU8bY/eL8
         hbGS32k6vKnvIpBJ0ist6iR3MyC+uexMe9lHe87PLNWiTUOKi0lrGtGXqOc9gEaWc3CG
         Kiateu4g1bvIuKugRM7Zmsn82s2/rvAeaappg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VvY+Um7t+HOzI6/W5a8yZgdefKR8Do2mp7gJuMj0OUwfvPFqSGeOQZVSeMRSkuAMUQ
         9ZepuZnMjEchlWMPseg1OnxcAFVUXB3rohyTqWgcUpVVfZYCZRyv3bKf+OxzC73gVb3Q
         3WJStkIgQYDGqobPuyYGww6jeJam/Fgt7r6pk=
Received: by 10.101.69.4 with SMTP id w4mr4237205ank.5.1280608773308;
        Sat, 31 Jul 2010 13:39:33 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id c19sm6213294ana.2.2010.07.31.13.39.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 31 Jul 2010 13:39:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <i30g2s$dpt$1@dough.gmane.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152337>

Walter Bright wrote:

> Why would "git clone" even exist if copying the directory works?

As Ilari said, it works remotely.  It=E2=80=99s even faster than just c=
opying
the directory (since it has to do less reading), and it only copies
the repository, not the work tree or .git/config, which may or may not
be what you want.

More importantly, the reason I mentioned it was this: if you clone
to make your first backup, you are more likely (when appropriate) to
use "git fetch" instead of rsync to update the backup afterwards.
And for that operation, "git fetch" is much more efficient.

Anyway, feel free to ignore this advice.  "cp -a" works fine already
and is sometimes just the right thing to do.

Jonathan
