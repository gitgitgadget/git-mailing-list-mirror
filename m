From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 15:55:13 +0100
Message-ID: <adf1fd3d0811030655k9a6d48fh9fb046b3a741f4c7@mail.gmail.com>
References: <200811031439.12111.brian.foster@innova-card.com>
	 <adf1fd3d0811030620x1bc53db3y2afb26242e9906ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brian Foster" <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 15:56:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx0r5-00043i-7V
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 15:56:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755805AbYKCOzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 09:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755060AbYKCOzQ
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 09:55:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:49158 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753217AbYKCOzP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 09:55:15 -0500
Received: by ug-out-1314.google.com with SMTP id 39so1734013ugf.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 06:55:13 -0800 (PST)
Received: by 10.103.251.2 with SMTP id d2mr90983mus.88.1225724113275;
        Mon, 03 Nov 2008 06:55:13 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Mon, 3 Nov 2008 06:55:13 -0800 (PST)
In-Reply-To: <adf1fd3d0811030620x1bc53db3y2afb26242e9906ac@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99950>

On Mon, Nov 3, 2008 at 3:20 PM, Santi B=E9jar <santi@agolina.net> wrote=
:
> On Mon, Nov 3, 2008 at 2:39 PM, Brian Foster
> <brian.foster@innova-card.com> wrote:
>>
>> Hello,
>>
>>  A colleague and I recently wanted to examine the
>>  history in a broad sense without worrying too much
>>  about the individual commits.  What we (think we)
>>  wanted is a 'gitk --all' history graph showing only
>>  "named" historical points; i.e., tags and branch
>>  HEADs, perhaps with an indication of whether or not
>>  it's a "linear" change sequence that leads from one
>>  to another.  That is, hypothetically, if the history
>>  looks something like (where 'A' &tc has a name as
>>  per above, and '*' does not):
>>
>>     A--->*--->*--->C--->D--->*----->E
>>      \                   \         /
>>       \->*-->B            \->*--->*--->F
>>
>>  What we wanted to see is something like:
>>
>>     A------>C--->D--->E
>>      \       \       /
>>       \->B    \-----/--->F
>>
>>  Is there some way of doing something similar to that
>>  (git v1.6.0.2)?  In addition to 'gitk', we also (rather
>>  quickly!) tried both 'qgit' and 'giggle', but without
>>  any apparent success.
>
> Not in git.git but you can use the script at the bottom (also attache=
d
> in case it is whitespace damage).
> It could be much faster if "git log" stops when finding a tag/branch.
>

Just to add that it would be great if gitk's "List references" showed
them in this way (possibly with a toggle to show them in alphabetical
order).

Santi
