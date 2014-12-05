From: =?ISO-8859-1?Q?S=E9rgio?= Basto <sergio@serjux.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 16:57:02 +0000
Message-ID: <1417798622.23238.6.camel@segulix>
References: <1417732931.20814.16.camel@segulix>
	 <1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	 <CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 17:57:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwwBs-0004qQ-Vj
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 17:57:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbaLEQ5I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 11:57:08 -0500
Received: from host1.easyho.st ([62.210.60.225]:47696 "EHLO host1.easyho.st"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750779AbaLEQ5I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Dec 2014 11:57:08 -0500
Received: from [194.65.5.235] (port=39220 helo=[10.134.132.194])
	by host1.easyho.st with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <sergio@serjux.com>)
	id 1XwwBj-0015ek-BP; Fri, 05 Dec 2014 16:57:04 +0000
In-Reply-To: <CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
X-Mailer: Evolution 3.10.4 (3.10.4-4.fc20) 
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host1.easyho.st
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - serjux.com
X-Get-Message-Sender-Via: host1.easyho.st: authenticated_id: sergio@serjux.com
X-From-Rewrite: unmodified, already matched
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260875>

Hi,
On Sex, 2014-12-05 at 17:52 +0700, Duy Nguyen wrote:=20
> On Fri, Dec 5, 2014 at 1:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > Actually, it's a user error. When you set --assume-unchanged, then =
you give
> > a promise to git that you do not change the files, and git does not=
 have to
> > check itself whether there is a change.
> >
> > But since you did not keep your promise, you get what you deserve. =
;-)


No, I marked with assume-unchanged *after* change the file , and not
before. Else don't see what is the point of assume-unchanged if you
really don't change the file.=20


> You are correct about the original idea behind --assume-unchanged. Bu=
t
> over the time I think we bend over a bit and sort of support these us=
e
> cases. For example, aecda37 (do not overwrite files marked "assume
> unchanged" - 2010-05-01). The change is one-liner, so I don't mind
> doing it.

I think is the right thing=20

Thanks,
--=20
S=E9rgio M. B.
