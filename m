From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH 3/3] git-parse-remote: remove unused functions
Date: Sat, 6 Jun 2009 23:03:47 +0200
Message-ID: <adf1fd3d0906061403sd13200co286e986c67135f4b@mail.gmail.com>
References: <1244231617-17754-3-git-send-email-santi@agolina.net>
	 <7v63f9cd4s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 06 23:03:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MD33V-0001SI-U2
	for gcvg-git-2@gmane.org; Sat, 06 Jun 2009 23:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752528AbZFFVDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Jun 2009 17:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752519AbZFFVDq
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jun 2009 17:03:46 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:51236 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207AbZFFVDp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Jun 2009 17:03:45 -0400
Received: by bwz9 with SMTP id 9so2235244bwz.37
        for <git@vger.kernel.org>; Sat, 06 Jun 2009 14:03:47 -0700 (PDT)
Received: by 10.204.72.15 with SMTP id k15mr4704878bkj.14.1244322227024; Sat, 
	06 Jun 2009 14:03:47 -0700 (PDT)
In-Reply-To: <7v63f9cd4s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120938>

2009/6/6 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> Signed-off-by: Santi B=E9jar <santi@agolina.net>
>> ---
>> =A0.gitignore =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =
=A01 -
>> =A0Documentation/git-parse-remote.txt | =A0 50 ---------
>> =A0git-parse-remote.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0204 -----=
-------------------------------
>> =A03 files changed, 0 insertions(+), 255 deletions(-)
>> =A0delete mode 100644 Documentation/git-parse-remote.txt
>
> I do not understand this patch.
>
> With this patch remove git-parse-remote from .gitignore (as if the en=
tire
> file is going away)

Ops, the .gitignore removal was a mistake.

> and its documentation (again as if the entire file is
> going away), so naturally I would have expected to see removal of the=
 file
> in the patch as well (and that means Makefile needs to be touched), b=
ut
> that is not what is happening.

I just wanted to remove the unused functions, and their documentation.
But I was removing the two functions that were documented, so I
removed all the file. Maybe I can just remove their documentation and
leave the rest of the file.

Santi
