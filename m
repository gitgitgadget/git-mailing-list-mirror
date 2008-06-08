From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH v3 20/23] Added the class NoGitRepositoryFoundException.
Date: Sun, 8 Jun 2008 23:05:26 +0200
Message-ID: <200806082305.30035.robin.rosenberg.lists@dewire.com>
References: <1211574872-23676-1-git-send-email-florianskarten@web.de> <200806060223.09332.robin.rosenberg.lists@dewire.com> <484C0548.8090309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Florian =?iso-8859-1?q?K=F6berle?= <FloriansKarten@web.de>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:32:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SVO-00074Z-NH
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:32:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822AbYFHVb4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 Jun 2008 17:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755832AbYFHVbz
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:31:55 -0400
Received: from [83.140.172.130] ([83.140.172.130]:3096 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755796AbYFHVbz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jun 2008 17:31:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 24FD0802890;
	Sun,  8 Jun 2008 23:31:53 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pGxuzzsZJ1Ws; Sun,  8 Jun 2008 23:31:52 +0200 (CEST)
Received: from [10.9.0.8] (unknown [10.9.0.8])
	by dewire.com (Postfix) with ESMTP id 662878006B6;
	Sun,  8 Jun 2008 23:31:52 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <484C0548.8090309@web.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84324>

s=F6ndagen den 8 juni 2008 18.14.00 skrev Florian K=F6berle:
> Robin Rosenberg wrote:
>  >> +		super(String.format("No repository found for file '%s'",
>  >> +				fileWeSearchedRepositoryFor));
>  >
>  > This is any odd patterrn. Usually we use + to concatenate strimgs.
>=20
> Hi Robin,
>=20
> I know two good reason why you should use formating functions over=20
> string concatenation via the plus sign:
>=20
> 1.) formated strings are better translatable. e.g.
> "The string '%s' is more then %s characters long"
[..]
> 2.) Whitespace mistakes are easier to see. e.g.
> (i + "coins") and ("%scoins", i)
>=20
> Sure you can make the mistake to provide not enough arguments, but=20
> that's not so worse:
> a.) Some IDEs, like Intellij IDEA warn you if you call a formating=20
> function with to few arguments.

I'm so ashamed... I used to like printf in C, but I've hardly used it i=
n Java. I
probably will use it more now. Seems Eclipse doesn't check (even GCC
does that).

-- robin
