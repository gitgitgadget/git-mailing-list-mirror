From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [PATCH v4 0/7] customizable --color-words
Date: Sun, 18 Jan 2009 16:29:54 +0100
Message-ID: <adf1fd3d0901180729u3da69108i6140aa7f68bda972@mail.gmail.com>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de>
	 <1232209788-10408-1-git-send-email-trast@student.ethz.ch>
	 <adf1fd3d0901180705s260f0051wb4e3a978601618ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Teemu Likonen <tlikonen@iki.fi>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jan 18 16:31:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZcg-0003WE-An
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933808AbZARPaA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 18 Jan 2009 10:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933826AbZARP36
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:29:58 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:50481 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933551AbZARP35 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Jan 2009 10:29:57 -0500
Received: by bwz14 with SMTP id 14so7074763bwz.13
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 07:29:54 -0800 (PST)
Received: by 10.103.175.8 with SMTP id c8mr2097655mup.117.1232292594491; Sun, 
	18 Jan 2009 07:29:54 -0800 (PST)
In-Reply-To: <adf1fd3d0901180705s260f0051wb4e3a978601618ec@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106225>

2009/1/18 Santi B=E9jar <santi@agolina.net>:
> 2009/1/17 Thomas Rast <trast@student.ethz.ch>:
>> Johannes Schindelin wrote:
>>> Thomas, could you pick up the patches from my 'my-next' branch and
>>> maintain an "official" topic branch?
>>
>> I cherry-picked the three commits you had there, and rebuilt on top.
>> I pushed them to
>>
>>  git://repo.or.cz/git/trast.git tr/word-diff-p2
>>
>> again (js/word-diff-p1 again points directly at your half).
>
> I've tested tr/word-diff-p2 and I have not found any issues. I've eve=
n
> tested that nothing changed from the tradicional word diff to:
>
> git log -p --color-words=3D"[^[:space:]]+"
>
> for the whole git history.
>

What I tested is that the new code produces the same result for this
two commands:

git log -p --color-words=3D"[^[:space:]]+"
git log -p --color-words

The old code produced color codes before and after each word, while
the new only at the begining of the color and the end of the color. So
they cannot produce the same output but equivalent.

Santi
