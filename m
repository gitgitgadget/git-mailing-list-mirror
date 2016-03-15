From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 1/1] t9115: Skip pathnameencoding=cp932 under HFS
Date: Tue, 15 Mar 2016 01:59:54 +0000
Message-ID: <20160315015954.GB25295@dcvr.yhbt.net>
References: <20160208225806.GA3487@dcvr.yhbt.net>
 <1456597724-26497-1-git-send-email-tboegi@web.de>
 <20160228045945.GA14289@dcvr.yhbt.net>
 <56D333F1.9050905@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, k_satoda@f2.dion.ne.jp
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 15 03:00:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afeHB-0007IX-0Y
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 03:00:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933470AbcCOB74 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Mar 2016 21:59:56 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:59024 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933382AbcCOB7z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 21:59:55 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892FF63381A;
	Tue, 15 Mar 2016 01:59:54 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <56D333F1.9050905@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288828>

Torsten B=C3=B6gershausen <tboegi@web.de> wrote:
> On 28.02.16 05:59, Eric Wong wrote:
> > tboegi@web.de wrote:
> > Please keep lines wrapped at 80 cols or less.
> > (I need big fonts)
> OK
> >=20
> >> @@ -105,10 +105,10 @@ test_expect_success UTF8 'svn.pathnameencodi=
ng=3Dcp932 new file on dcommit' '
> >>  '
> > Why the extra 'o'?
> That shouldn't be there, sorry.
> Will send V2...

I just edited locally and pushed those out to Junio:

http://mid.gmane.org/20160315015726.GA25295@dcvr.yhbt.net
