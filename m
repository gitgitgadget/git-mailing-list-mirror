From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [EGIT] UTF-8 in author names in history views read as ISO-8859-1
Date: Thu, 27 Sep 2007 20:53:40 +0200
Message-ID: <200709272053.41795.robin.rosenberg.lists@dewire.com>
References: <fdel0j$na4$3@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?Jos=C3=A9_Fonseca?= <j_r_fonseca@yahoo.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:51:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaySd-0002w2-Bq
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 20:51:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188AbXI0Svg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2007 14:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755071AbXI0Svf
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 14:51:35 -0400
Received: from [83.140.172.130] ([83.140.172.130]:19299 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1754835AbXI0Svf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 14:51:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C48B3802872;
	Thu, 27 Sep 2007 20:43:16 +0200 (CEST)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11889-06; Thu, 27 Sep 2007 20:43:16 +0200 (CEST)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 7366B80264D;
	Thu, 27 Sep 2007 20:43:16 +0200 (CEST)
User-Agent: KMail/1.9.6
In-Reply-To: <fdel0j$na4$3@sea.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59308>

torsdag 27 september 2007 skrev Jos=C3=A9 Fonseca:
> Hi,
>=20
> First, thanks for the work on egit -- it is progressively becoming mo=
re=20
> and more useful.
>=20
> I found that spite UTF-8 being the default encoding, egit is interpre=
ting=20
> (or displaying) names as ISO-8859-1 in the history view.

Encoding is largeley neglected. Actually conversions are made because o=
ne
has to, but there is no consistency there. Git mostly neglect encodings=
 and
so does anything that attempt to be compatible with it. I have some pat=
ches
towards improvement. A problem is that conversion to or from UTF-8 and =
back
are not reversible, especially when the input is invalid for the conver=
sion. This
*will* happen when dealing with git repos that contain non-ascii commen=
ts or
file names.

> BTW, something I really miss from egit is "Team > Compare With > HEAD=
=20
> revision" or something like that.

Coming.. but no plan on when as for most ideas that I have. Lack of tim=
e means
most things come in small pieces that can be completed in an hour or tw=
o. OTOH
some things become clear and simple over time when not rushing them. Th=
is is
probably one of the simple features. Actually it's a good way to get st=
arted with
hacking the plugin ;]

> Keep up the good work!

Thanks

-- robin
