From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: Pointers to setup an internal git repository with access
 control
Date: Tue, 30 Aug 2011 20:33:46 +0200
Message-ID: <20110830183346.GA14605@jpl.local>
References: <CAAZ43xZPsw2CnqOtb6wO7dRC1eMd0eweQ30w-wfzUHL5cqw=Yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 30 20:33:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyT8F-00073G-00
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 20:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755982Ab1H3Sdu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Aug 2011 14:33:50 -0400
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:42322 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754698Ab1H3Sdt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 14:33:49 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 447B2E9BB4
	for <git@vger.kernel.org>; Tue, 30 Aug 2011 20:33:48 +0200 (CEST)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ai4MALIsXU5T46eEPGdsb2JhbABCmE6PaQsBAQEBNzKBQAEBBAEyASMjBQsLNBIUDQsBDAoaE4dyArhphW1gBJ0dhw4
X-IronPort-AV: E=Sophos;i="4.68,303,1312149600"; 
   d="scan'208";a="215959544"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb1.telenor.se with ESMTP; 30 Aug 2011 20:33:48 +0200
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id C4972422CF; Tue, 30 Aug 2011 20:33:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAAZ43xZPsw2CnqOtb6wO7dRC1eMd0eweQ30w-wfzUHL5cqw=Yw@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180431>

On Tuesday, August 30, 2011 at 14:01 CEST,
     robert mena <robert.mena@gmail.com> wrote:

> I am trying to migrate from SVN to git and so I am looking for tools
> that help me create an interal repository.  I currently use SVN over
> HTTPS/Dav using the access.conf to be able to control which uses can
> read/write to the repos or given branches.
>=20
> Ideally I am looking for tools that enable me to do the same with git=
=2E

Gerrit Code Review (http://code.google.com/p/gerrit/) provides
branch-level ACLs for both reading and writing.

--=20
Magnus B=E4ck                   Opinions are my own and do not necessar=
ily
SW Configuration Manager      represent the ones of my employer, etc.
Sony Ericsson
