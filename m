From: "Santi Bejar" <santi@agolina.net>
Subject: Re: Gitk and --no-walk don't play together
Date: Mon, 8 Sep 2008 20:53:41 +0200
Message-ID: <adf1fd3d0809081153o5ed8f2d8i94c5b23a2f28858@mail.gmail.com>
References: <alpine.LNX.1.10.0809081223360.1621@fbirervta.pbzchgretzou.qr>
	 <adf1fd3d0809080934s67b2a8b1w19aeb3d8e5f8b4ab@mail.gmail.com>
	 <alpine.LNX.1.10.0809081310260.1621@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jan Engelhardt" <jengelh@medozas.de>
X-From: git-owner@vger.kernel.org Mon Sep 08 21:01:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kclzh-0002LJ-5M
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 21:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbYIHTAm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Sep 2008 15:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753216AbYIHTAl
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 15:00:41 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:37006 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbYIHTAl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Sep 2008 15:00:41 -0400
Received: by yx-out-2324.google.com with SMTP id 8so905946yxm.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 12:00:39 -0700 (PDT)
Received: by 10.103.198.20 with SMTP id a20mr10488821muq.56.1220900021218;
        Mon, 08 Sep 2008 11:53:41 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Mon, 8 Sep 2008 11:53:41 -0700 (PDT)
In-Reply-To: <alpine.LNX.1.10.0809081310260.1621@fbirervta.pbzchgretzou.qr>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95290>

On Mon, Sep 8, 2008 at 7:25 PM, Jan Engelhardt <jengelh@medozas.de> wro=
te:
>
> On Monday 2008-09-08 12:34, Santi Bejar wrote:
>>
>>> in an attempt to only show only the tags in the graph, gitk barfs:
>>
>>Use the "List references" in the file menu.
>
> Nope, the intention was to have gitk display something like
>
> * Linux 2.6.26
> |
> * Linux 2.6.25
>
> without any intermediate commits.
>

I think the only option is to generate a graft file specifying 2.6.25
as parent  of 2.6.26.

I have an script that generates it. It gives an overview of the
branches/tags, where the parents of a branch/tag are the independent
branches/tags that are antecesors (search for git-overview in the
list). But currently it has a very bad performance, it could be added
to git itself like the other history simplifications, but I don=B4t
know.

Santi
