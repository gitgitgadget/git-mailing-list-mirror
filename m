From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: RFE: "git bisect reverse"
Date: Tue, 26 May 2009 21:20:10 -0700
Message-ID: <4A1CBF7A.3090708@zytor.com>
References: <4A1C6B70.4050501@zytor.com> <4A1CACB2.7000702@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed May 27 06:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9Acm-0005L5-QD
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 06:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbZE0EUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 00:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750936AbZE0EUM
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 00:20:12 -0400
Received: from terminus.zytor.com ([198.137.202.10]:39423 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750926AbZE0EUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2009 00:20:11 -0400
Received: from mail.hos.anvin.org (c-98-210-181-100.hsd1.ca.comcast.net [98.210.181.100])
	(authenticated bits=0)
	by terminus.zytor.com (8.14.3/8.14.1) with ESMTP id n4R4KCTa027397
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 May 2009 21:20:13 -0700
Received: from tazenda.hos.anvin.org (tazenda.hos.anvin.org [172.27.0.16])
	by mail.hos.anvin.org (8.14.2/8.13.8) with ESMTP id n4R4KCte024244;
	Tue, 26 May 2009 21:20:12 -0700
Received: from tazenda.hos.anvin.org (localhost.localdomain [127.0.0.1])
	by tazenda.hos.anvin.org (8.14.3/8.13.6) with ESMTP id n4R4KAJA016733;
	Tue, 26 May 2009 21:20:11 -0700
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <4A1CACB2.7000702@vilain.net>
X-Virus-Scanned: ClamAV 0.94.2/9393/Tue May 26 03:17:55 2009 on terminus.zytor.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120026>

Sam Vilain wrote:
> 
> Oh, yes.  And another thing: 'git bisect run' / 'git bisect skip'
> doesn't do a very good job of skipping around broken commits (ie when
> the script returns 126).  It just seems to move to the next one; it
> would be much better IMHO to first try the commit 1/3rd of the way into
> the range, then if that fails, the commit 2/3rd of the way through it, etc.
> 

I posted about that last year:

http://marc.info/?l=git&i=48F3DCEB.1060803@zytor.com

At the time, git bisect was still done in the shell and it was deemed
too difficult.

	-hpa

-- 
H. Peter Anvin, Intel Open Source Technology Center
I work for Intel.  I don't speak on their behalf.
