From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What's cooking in git.git (topics)
Date: Mon, 30 Jun 2008 08:58:07 -0700 (PDT)
Message-ID: <m3myl2hq45.fsf@localhost.localdomain>
References: <7vlk4snpj3.fsf@gitster.siamese.dyndns.org>
	<7vd4pf7h9y.fsf@gitster.siamese.dyndns.org>
	<7vwsnjl21c.fsf@gitster.siamese.dyndns.org>
	<7vhcehzdeg.fsf@gitster.siamese.dyndns.org>
	<7vbq4j748l.fsf@gitster.siamese.dyndns.org>
	<7vr6d8apjx.fsf@gitster.siamese.dyndns.org>
	<7vhcdyfe9u.fsf@gitster.siamese.dyndns.org>
	<7vabjm1a0q.fsf@gitster.siamese.dyndns.org>
	<7vr6crj0jk.fsf@gitster.siamese.dyndns.org>
	<7vmyn4hr8f.fsf@gitster.siamese.dyndns.org>
	<7vmymsjz6x.fsf@gitster.siamese.dyndns.org>
	<7vabijxhk4.fsf@gitster.siamese.dyndns.org>
	<7vwslhg8qe.fsf@gitster.siamese.dyndns.org>
	<7vhccfiksy.fsf@gitster.siamese.dyndns.org>
	<7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
	<7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
	<7v3anb19n7.fsf@gitster.siamese.dyndns.org>
	<7vwskjazql.fsf@gitster.siamese.dyndns.org>
	<7vk5ggipuw.fsf@gitster.siamese.dyndns.org>
	<7vej6l3lp7.fsf@gitster.siamese.dyndns.org>
	<7vod5kd3im.fsf@gitster.siamese.dyndns.org>
	<7v3amv1e8n.fsf@gitster.siamese.dyndns.org>
	<1214834970.3382.4.camel@gaara.bos.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-15?q?Kristian_H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 17:59:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDLmZ-0002nt-DO
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 17:59:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754442AbYF3P6O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 11:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752612AbYF3P6O
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 11:58:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:6702 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbYF3P6N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 11:58:13 -0400
Received: by ug-out-1314.google.com with SMTP id h2so269531ugf.16
        for <git@vger.kernel.org>; Mon, 30 Jun 2008 08:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        bh=bxjlkouszicf11diH7hMO85NB+HndJj6QwjP64KozyE=;
        b=IRGgJdhJhL5N2rBnrTiwNUpfcd1V31Lfrq5VrqU0BntV/mMMrbRHGRCLD32zSthDMO
         UYg+6v7xC6ucOFfydG8zXbm41XRjfMYhROe/brk/b8pmIiJJYLLY4tKCpNTrjRpV+Av1
         8ZgKlvVFGZ6v7PLd9JipCNemRE18iZe/DRUxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding:date;
        b=EFvan5gcAKAFGuadEaG8HoKGM9RpujiEiV/HScAj9FheJ6yCmwVkIc/kjZ0X+Ggkte
         iL+SOFffL2kvoyvz+YtqW0t8zYDjevcn9m79VMvxZRHYHyj/5fuABdaYwEwSZXaZsRam
         3RGsXegynTthAD9TMrwSP0IOnRkPzGl1eV35Q=
Received: by 10.67.116.9 with SMTP id t9mr3858585ugm.65.1214841489554;
        Mon, 30 Jun 2008 08:58:09 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.122])
        by mx.google.com with ESMTPS id 32sm363609ugd.53.2008.06.30.08.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 30 Jun 2008 08:58:07 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5UFw539020661;
	Mon, 30 Jun 2008 17:58:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5UFw3hj020658;
	Mon, 30 Jun 2008 17:58:03 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1214834970.3382.4.camel@gaara.bos.redhat.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86916>

Kristian H=F8gsberg <krh@redhat.com> writes:

>=20
> A small detail I've suggested scheduling for 1.6 before is removing (=
or
> rather, stop creating) the empty .git/branches directory.  How does t=
hat
> sound?

Perhaps also stop creating .git/description (remove
'templates/this--description' file), now that it is mentioned in
gitweb/README and/or gitweb/INSTALL?

(Do you want a patch?)
--=20
Jakub Narebski
Poland
ShadeHawk on #git
