From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: Re: [PATCH/RFC 10/10] gitweb: Create links leading to
	'blame_incremental' using JavaScript
Date: Sat, 25 Jul 2009 12:46:22 +0200
Message-ID: <20090725104622.GA7337@auto.tuwien.ac.at>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com> <1248475450-5668-11-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 12:46:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUem8-0006QU-7M
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 12:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbZGYKqZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Jul 2009 06:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752452AbZGYKqZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 06:46:25 -0400
Received: from odin.auto.tuwien.ac.at ([128.130.60.3]:50639 "EHLO
	mail.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZGYKqY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 06:46:24 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id BC2351303975;
	Sat, 25 Jul 2009 12:46:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at odin.auto.tuwien.ac.at
Received: from mail.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (odin.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hR7zC7hf2RHs; Sat, 25 Jul 2009 12:46:22 +0200 (CEST)
Received: from thor.localdomain (thor.auto.tuwien.ac.at [128.130.60.15])
	by mail.auto.tuwien.ac.at (Postfix) with ESMTP id A847E1000092;
	Sat, 25 Jul 2009 12:46:22 +0200 (CEST)
Received: by thor.localdomain (Postfix, from userid 3001)
	id 9FE096800645; Sat, 25 Jul 2009 12:46:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1248475450-5668-11-git-send-email-jnareb@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124001>

On Sat, Jul 25, 2009 at 12:44:10AM +0200, Jakub Narebski wrote:
> TODO list:
> * Perhaps put fixLinks() function in separate file gitweb.js.
>   Should gitweb use single JavaScript file, or should it be split int=
o
>   more than one file?

The same question can be asked for gitweb itself:

Why is it a single perl file and not splited in many different
modules?

mfg Martin K=F6gler
