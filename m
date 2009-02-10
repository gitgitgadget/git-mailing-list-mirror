From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH] builtin-branch: highlight current remote branches with an 
	asterisk
Date: Tue, 10 Feb 2009 09:02:02 +0100
Message-ID: <adf1fd3d0902100002k5d787e2ewe9012b42f943a6a3@mail.gmail.com>
References: <1234222326-55818-1-git-send-email-jaysoffian@gmail.com>
	 <20090210075214.GC1320@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 10 09:03:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWnaf-0007MC-6v
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 09:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752116AbZBJICH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Feb 2009 03:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbZBJICF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 03:02:05 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:35215 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbZBJICE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 03:02:04 -0500
Received: by bwz5 with SMTP id 5so2300731bwz.13
        for <git@vger.kernel.org>; Tue, 10 Feb 2009 00:02:03 -0800 (PST)
Received: by 10.103.2.14 with SMTP id e14mr741852mui.94.1234252922777; Tue, 10 
	Feb 2009 00:02:02 -0800 (PST)
In-Reply-To: <20090210075214.GC1320@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109188>

2009/2/10 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.02.09 18:32:06 -0500, Jay Soffian wrote:
>> Teach git branch -{r,a} how to interpret remote HEADs and highlight =
the
>> corresponding remote branch with an asterisk, instead of showing lit=
eral
>> "<remote_name>/HEAD".
>
> Hm, what's the use case for having such a marker? And since only "git
> clone" sets up origin/HEAD, while "git remote add foo git://..." won'=
t
> create foo/HEAD,

git remote add -f ... would create it.

> you would get that marker for origin only. Also, the
> origin/HEAD symref isn't updated, so it doesn't tell you which branch
> is "active" in the remote repository now, but which one was active wh=
en
> you cloned the repo.

Maybe there should be a way to update it afterwards.

Santi
