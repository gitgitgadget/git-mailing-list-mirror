From: Thomas Koch <thomas@koch.ro>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Sun, 10 Feb 2013 13:16:00 +0100
Message-ID: <201302101316.02549.thomas@koch.ro>
References: <1359901085.24730.11.camel@t520> <510F9907.7010107@drmicha.warpmail.net> <1359980045.24730.32.camel@t520>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Robert Clausecker <fuzxxl@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 10 13:16:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4Vpl-0000lV-FX
	for gcvg-git-2@plane.gmane.org; Sun, 10 Feb 2013 13:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754173Ab3BJMQJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2013 07:16:09 -0500
Received: from koch.ro ([88.198.2.104]:57490 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753257Ab3BJMQI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2013 07:16:08 -0500
Received: from 123-16.2-85.cust.bluewin.ch ([85.2.16.123] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1U4VpD-0003If-Tn; Sun, 10 Feb 2013 13:16:03 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <1359980045.24730.32.camel@t520>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215902>

Robert Clausecker:
> I have a server that hosts a bare git repository. This git repository
> contains a branch production. Whenever somebody pushes to production =
a
> hook automatically puts a copy of the current production branch
> into /var/www/foo. I could of course use pull for that but it just do=
es
> not feels right. Why should I have a repository twice on the server?

Hallo Robert,

I've mostly the same requirement for a friend with a PHP webshop and st=
arted=20
to implement my own git_export with the additional feature that it trie=
s to=20
reuse already exported trees as hardlink targets instead of writing the=
 same=20
file again. (I'm aware of the dangers of hardlinks.)

https://github.com/thkoch2001/git_export_hardlinks

See also the current mailing list thread: "[Request] Git export with=20
hardlinks".

Beste Gr=FC=DFe,

Thomas Koch, http://www.koch.ro
