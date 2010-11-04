From: Yann Dirson <ydirson@free.fr>
Subject: Re: Test failures in pu: 4046, 950[012]
Date: Thu, 4 Nov 2010 22:49:01 +0100
Message-ID: <20101104214900.GD8911@home.lan>
References: <201010201148.51551.trast@student.ethz.ch>
 <7vvd4wvmv6.fsf@alter.siamese.dyndns.org>
 <201010201856.54756.trast@student.ethz.ch>
 <201011042237.01801.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nguy???n Th?i Ng???c Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Nov 04 22:49:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PE7gK-000828-IE
	for gcvg-git-2@lo.gmane.org; Thu, 04 Nov 2010 22:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209Ab0KDVtL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Nov 2010 17:49:11 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:42874 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753124Ab0KDVtK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Nov 2010 17:49:10 -0400
Received: from home.lan (unknown [81.57.214.146])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 4294DD4805C;
	Thu,  4 Nov 2010 22:49:02 +0100 (CET)
Received: from yann by home.lan with local (Exim 4.72)
	(envelope-from <ydirson@free.fr>)
	id 1PE7g5-0002Nr-2s; Thu, 04 Nov 2010 22:49:01 +0100
Content-Disposition: inline
In-Reply-To: <201011042237.01801.trast@student.ethz.ch>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160776>

On Thu, Nov 04, 2010 at 10:37:01PM +0100, Thomas Rast wrote:
> Failures as of yesterday (it alternates between next and pu, so today
> was next which was clean):
> 
> * 4046 has this valgrind failure:
> 
>   ==24237== Source and destination overlap in mempcpy(0x7feffed50, 0x7feffed50, 2)
>   ==24237==    at 0x4C228DB: mempcpy (mc_replace_strmem.c:802)
>   ==24237==    by 0x511AD6: copy_dirname (diffcore-rename.c:573)

This is the issue raised by Jonathan.  I have a fix for it although I
did not publish it since I'm working on a refactoring.  Posting it now.

-- 
Yann
