From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: an error when using 'git send-email'
Date: Sun, 20 Feb 2011 17:44:27 +0100
Message-ID: <20110220164427.GA1439@jpl.local>
References: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yongqiang Yang <xiaoqiangnk@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 17:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrCOw-0004Gl-1S
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 17:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab1BTQof convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 11:44:35 -0500
Received: from smtprelay-h31.telenor.se ([213.150.131.4]:33232 "EHLO
	smtprelay-h31.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab1BTQof (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Feb 2011 11:44:35 -0500
Received: from ipb2.telenor.se (ipb2.telenor.se [195.54.127.165])
	by smtprelay-h31.telenor.se (Postfix) with ESMTP id 91C11EBDAE
	for <git@vger.kernel.org>; Sun, 20 Feb 2011 17:44:29 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AuUQAG/TYE1T46eEPGdsb2JhbACIaY5+jkkMAQEBATUvuR+DHYJBBJJe
X-IronPort-AV: E=Sophos;i="4.62,195,1297033200"; 
   d="scan'208";a="174279494"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb2.telenor.se with ESMTP; 20 Feb 2011 17:44:29 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id D9031422AF; Sun, 20 Feb 2011 17:44:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167426>

On Friday, February 18, 2011 at 12:45 CET,
     Yongqiang Yang <xiaoqiangnk@gmail.com> wrote:

> When I use git 'send-email', I get an error "Command unknown:  'AUTH'
> at /usr/bin/git-send-email line 775, <STDIN> line 1".
> Is there anyone meet the same error?

You seem to have configured a username and password for SMTP
authentication, yet the server Git connects to doesn't support
authentication.

Make sure the SMTP server you've configured Git to use
(sendemail.smtpserver configuration variable) is the right one.
If so, clear the smtpemail.smtpuser and smtpemail.smtppass
variables as you obviously can't use them with the server.

=46or testing purposes there are options to "git send-email" to
override the values set in the configuration files. Those might
be more convenient to use when testing out new configurations.

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
