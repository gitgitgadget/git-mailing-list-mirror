From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [Q] Abbreviated history graph?
Date: Mon, 3 Nov 2008 17:08:00 +0100
Message-ID: <adf1fd3d0811030808r6d795b54g9fd5b25ce5fe3cdb@mail.gmail.com>
References: <200811031439.12111.brian.foster@innova-card.com>
	 <adf1fd3d0811030620x1bc53db3y2afb26242e9906ac@mail.gmail.com>
	 <200811031646.20404.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brian Foster" <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Mon Nov 03 17:09:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kx200-0004UZ-8B
	for gcvg-git-2@gmane.org; Mon, 03 Nov 2008 17:09:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbYKCQIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Nov 2008 11:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754727AbYKCQIF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 11:08:05 -0500
Received: from gv-out-0910.google.com ([216.239.58.189]:48766 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754439AbYKCQID convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Nov 2008 11:08:03 -0500
Received: by gv-out-0910.google.com with SMTP id e6so273268gvc.37
        for <git@vger.kernel.org>; Mon, 03 Nov 2008 08:08:01 -0800 (PST)
Received: by 10.103.172.9 with SMTP id z9mr121276muo.122.1225728481021;
        Mon, 03 Nov 2008 08:08:01 -0800 (PST)
Received: by 10.103.179.20 with HTTP; Mon, 3 Nov 2008 08:08:00 -0800 (PST)
In-Reply-To: <200811031646.20404.brian.foster@innova-card.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99956>

On Mon, Nov 3, 2008 at 4:46 PM, Brian Foster
<brian.foster@innova-card.com> wrote:
> On Monday 03 November 2008 15:20:30 Santi B=E9jar wrote:
>>[ ... ]
>> >  Is there some way of doing something similar [ the example ]
>> >  (git v1.6.0.2)?  In addition to 'gitk', we also (rather
>> >  quickly!) tried both 'qgit' and 'giggle', but without
>> >  any apparent success.
>>
>> Not in git.git but you can use the script at the bottom [ ... ].
>
> Santi,
>
>   Thanks.  Unfortunately, neither I nor my colleague can try
>  it at the moment:  It uses  `git log --pretty=3Dformat:%d'
>  which is very new (added c.9-Sept) and not in the versions
>  of git we are currently using.  End result is the tempfile
>  is always empty, and hence `gitk' shows everything.


Ups! So you could get the same information with the uglier (and slower)=
:

$ git log --reverse --pretty=3Dshort --decorate | grep ^commit

but then you should change "NF>=3D2" with "NF>=3D3", or use an older on=
e I
sent to the list (search for git-overview).

Santi
