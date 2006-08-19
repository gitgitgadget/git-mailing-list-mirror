From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Recover from a bad push in StGit
Date: Sat, 19 Aug 2006 02:11:28 +0200
Organization: Dewire
Message-ID: <200608190211.29625.robin.rosenberg.lists@dewire.com>
References: <200608190030.47257.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Sat Aug 19 02:14:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEER9-0006Cu-Gb
	for gcvg-git@gmane.org; Sat, 19 Aug 2006 02:11:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWHSALg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 Aug 2006 20:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751600AbWHSALg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Aug 2006 20:11:36 -0400
Received: from [83.140.172.130] ([83.140.172.130]:26970 "EHLO
	torino.dewire.com") by vger.kernel.org with ESMTP id S1751598AbWHSALf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Aug 2006 20:11:35 -0400
Received: from localhost (localhost [127.0.0.1])
	by torino.dewire.com (Postfix) with ESMTP id 1B32180284A
	for <git@vger.kernel.org>; Sat, 19 Aug 2006 02:09:22 +0200 (CEST)
Received: from torino.dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 23231-07 for <git@vger.kernel.org>; Sat, 19 Aug 2006 02:09:21 +0200 (CEST)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by torino.dewire.com (Postfix) with ESMTP id CB15F802664
	for <git@vger.kernel.org>; Sat, 19 Aug 2006 02:09:21 +0200 (CEST)
To: git <git@vger.kernel.org>
User-Agent: KMail/1.9.4
In-Reply-To: <200608190030.47257.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25702>

l=F6rdag 19 augusti 2006 00:30 skrev Robin Rosenberg:
> Hi,
>
> I recently did some reordering of patches and goofed up (not totally,=
 but
> anyway). I pushed a number of patches and forgot one in the middle
> resulting in a merge  conflict. Pop won't work since I have local cha=
nges
> from the conflict and I don't want to resolve the conflict either sin=
ce I
> didn't mean to push the patch at that point.
>
> Is there a simple way of undoing a bad push?
It was so simple

	stg status --reset;stg pop

does the job. Sorry about the noise.

>
> In this case I had a fresh export do help me out so I could just dele=
te the
> patches and re-import them again, but what if I didn't?
>

-- robin
