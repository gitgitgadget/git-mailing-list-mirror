From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: getting list of objects for packing
Date: Fri, 31 Oct 2008 15:48:52 -0500
Message-ID: <JhY9the71dfsAJuojZF2S4BG-SEkshM7XxIWGPBeY9M@cipher.nrlssc.navy.mil>
References: <TtAUShKh7lOR5rkf1iyWwpMOWoYpT8Mnw-t3Wemdy3tTCd0XiQHdag@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0810311625450.13034@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 21:50:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw0wb-0006kO-2V
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 21:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219AbYJaUs4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 16:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069AbYJaUs4
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 16:48:56 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:50435 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbYJaUs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 16:48:56 -0400
Received: by mail.nrlssc.navy.mil id m9VKmrLp017155; Fri, 31 Oct 2008 15:48:53 -0500
In-Reply-To: <alpine.LFD.2.00.0810311625450.13034@xanadu.home>
X-OriginalArrivalTime: 31 Oct 2008 20:48:53.0282 (UTC) FILETIME=[15C23020:01C93B9A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99641>

Nicolas Pitre wrote:
> On Fri, 31 Oct 2008, Brandon Casey wrote:

>>   -The sed statement is stripping off anything after the sha1. Any way to
>>    get rev-list to print out just the sha1 so that sed is not necessary?
> 
> If you strip the data after the SHA1 when pipping into pack-objects then 
> you'll have horrible delta compression results.  The path names after 
> each SHA1 is used to sort objects when trying to find best matches for 
> delta compression. So you should preserve those and feed it back 
> especially with those packs that you still want delta compression for.

Ah, I'll have to rethink my script then. Thanks!

-brandon
