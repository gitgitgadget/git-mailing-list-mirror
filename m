From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Broken umlaut in my name, again
Date: Mon, 6 Apr 2009 14:46:43 +0200
Message-ID: <adf1fd3d0904060546j6c2fbba9r75829f2bd383458b@mail.gmail.com>
References: <20090331153039.GA1520@atjola.homenet>
	 <20090406114618.GF20356@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Marius Storm-Olsen <marius@trolltech.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 06 14:49:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqoFR-0000Fo-GH
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 14:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbZDFMqr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Apr 2009 08:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754308AbZDFMqr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 08:46:47 -0400
Received: from mu-out-0910.google.com ([209.85.134.189]:13862 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbZDFMqq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Apr 2009 08:46:46 -0400
Received: by mu-out-0910.google.com with SMTP id g7so756713muf.1
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 05:46:44 -0700 (PDT)
Received: by 10.103.138.16 with SMTP id q16mr1996238mun.7.1239022003993; Mon, 
	06 Apr 2009 05:46:43 -0700 (PDT)
In-Reply-To: <20090406114618.GF20356@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115814>

2009/4/6 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.03.31 17:30:39 +0200, Bj=F6rn Steinbrink wrote:
>> While it makes no sense to map some email address to an empty one, d=
oing
>> things the other way around can be useful. For example when using
>> filter-branch with an env-filter that employs a mailmap to fix up an
>> import that created such broken commits with empty email addresses.
>>
>> Signed-off-by: Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>
>
> The umlaut (=F6) in my name is broken in the commit that made it into
> git.git --> 5288dd58356e53d61e2b3804fc7d8d23c3a46ab3
>
> Last time this happened when I used format-patch -s instead of commit=
 -s
> IIRC. But since then, I pay attention to do the sign-off via commit -=
s,
> yet my name is broken again. What did I do wrong this time?

I don't see nothing wrong in your mails. It appears to be a double
conversion to UTF-8 between the mail and the commit.

But I always use format-patch -s without problems, what was your
problem with format-patch?

Santi
