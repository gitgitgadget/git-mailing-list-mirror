From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: stgit: patch import with fuzz
Date: Fri, 25 Jan 2008 02:00:22 -0800 (PST)
Message-ID: <m3ve5ifcnq.fsf@localhost.localdomain>
References: <9e4733910801241901t230898d2t90ce2a14152e1af1@mail.gmail.com>
	<20080125093849.GA6591@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?iso-8859-15?q?Karl_Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:01:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JILMq-0002u3-Ak
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 11:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYAYKA3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2008 05:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbYAYKA2
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 05:00:28 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:27659 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751295AbYAYKA1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2008 05:00:27 -0500
Received: by fk-out-0910.google.com with SMTP id z23so515706fkz.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 02:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        bh=FV17ITY/NL5s8eszAdQFZaNJdw4IjwTAJa/2Q7J+6TM=;
        b=mF5lfv90CguKEdVUKJ4ag8NMkc11Z8XnrChdarX6pN7oBHu4ZrQpE9x/WdtxcMPF1YtLvubEn7YYITE2mMpdSDv9LPAMfGWeId3qQmQUsxiyevgT5zPJPcDf1mUjapBbtWpQcT0Fb8Jf892ZdSYaz23T1JwhmgsxaoFnekEfrMs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:content-transfer-encoding:from:date;
        b=dSKFnw7HNQFoi0oFW2tNOBWFrhyfk89YEiJGVo/D0E0eeSBLBLp2n5syN8gmZ+hSTpvop8pgWrjpy1cqfDhojCW/+IGWHBOAPHH2OxSXTjCoWVhyOov8aFvf3QSySSfJgTj64EosrG0T7lVwyfv/28RoI9vpw2+eJlwKWi5IpJY=
Received: by 10.78.159.7 with SMTP id h7mr2456210hue.17.1201255223837;
        Fri, 25 Jan 2008 02:00:23 -0800 (PST)
Received: from localhost.localdomain ( [83.8.253.44])
        by mx.google.com with ESMTPS id k10sm3677420nfh.17.2008.01.25.02.00.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Jan 2008 02:00:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0PA0HGr003813;
	Fri, 25 Jan 2008 11:00:17 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0PA0FmQ003810;
	Fri, 25 Jan 2008 11:00:15 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <20080125093849.GA6591@diana.vm.bytemark.co.uk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71695>

Karl Hasselstr=F6m <kha@treskal.com> writes:

> On 2008-01-24 22:01:37 -0500, Jon Smirl wrote:
>=20
> > Is there a way to allow a patch import with fuzz?
>=20
> Not currently. And it appears that git doesn't have this power either

"git apply -C1 <patch>" doesn't do that Well, that isn't import per se)=
?=20

--=20
Jakub Narebski
Poland
ShadeHawk on #git
