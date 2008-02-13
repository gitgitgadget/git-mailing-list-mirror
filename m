From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH updated] Add "--dirstat" for some directory statistics
Date: Wed, 13 Feb 2008 15:07:52 +0100
Message-ID: <06C59F5E-422E-4510-9D8B-9FAA1D8C4F45@wincent.com>
References: <alpine.LFD.1.00.0802121308360.2920@woody.linux-foundation.org> <fou7pu$dpq$1@ger.gmane.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Abdelrazak Younes <younes@lyx.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 15:08:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPIHq-00047B-Ez
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 15:08:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754057AbYBMOH5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Feb 2008 09:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753951AbYBMOH5
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Feb 2008 09:07:57 -0500
Received: from wincent.com ([72.3.236.74]:50494 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753834AbYBMOH4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Feb 2008 09:07:56 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1DE7sCr018645;
	Wed, 13 Feb 2008 08:07:55 -0600
In-Reply-To: <fou7pu$dpq$1@ger.gmane.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73796>

El 13/2/2008, a las 8:55, Abdelrazak Younes escribi=F3:

> May I suggest this instead so to get rid of the cumulative option?
>
> 	   7.6% fs/afs
> 	   7.6% fs/fuse
> 	   7.6% fs/gfs2
> 	   5.1% fs/jffs2
> 	   5.1% fs/nfs
> 	   5.1% fs/nfsd
> 	   7.6% fs/reiserfs
> 	  15.3% fs/
> 	  61.5% fs
>
> A trailing slash would mean "no recursive, only this directory" and =20
> no trailing slash means well the opposite :-)

I think that's getting a little _too_ subtle.

Cheers,
Wincent
