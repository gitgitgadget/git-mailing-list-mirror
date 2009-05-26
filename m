From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] speed: reuse char instead of recreation in loop
Date: Tue, 26 May 2009 13:54:03 +0200
Message-ID: <20090526115403.GA4246@cuci.nl>
References: <pan.2009.05.25.19.44.10@fedoraproject.org> <20090525201602.GA18471@atjola.homenet> <pan.2009.05.25.20.40.20@fedoraproject.org> <alpine.LNX.2.00.0905251733240.2147@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Spura <tomspur@fedoraproject.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue May 26 13:54:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8vEX-0003rr-SD
	for gcvg-git-2@gmane.org; Tue, 26 May 2009 13:54:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbZEZLyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2009 07:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754735AbZEZLyI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 May 2009 07:54:08 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:41962 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754663AbZEZLyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2009 07:54:07 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 5678B5420; Tue, 26 May 2009 13:54:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0905251733240.2147@iabervon.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120002>

Daniel Barkalow wrote:
>On Mon, 25 May 2009, Thomas Spura wrote:
>> Am Mon, 25 May 2009 22:16:02 +0200 schrieb Bj?rn Steinbrink:
>> > On 2009.05.25 19:44:10 +0000, Thomas Spura wrote:
>> >> Move a char and a char * outside of a for loop for speed improvements

>> > I doubt that this makes any difference at all.

>> With ints, the loop costs about 40% of speed. Without recreation, it 
>> should be always faster.

>optimizations in this code for it to make, but, in general, letting 
>variables in loops go out of scope (in C) only improves optimization 
>possibilities.

Quite.  The proposed patch is more likely to slow down the code than to
speed it up.
-- 
Sincerely,
           Stephen R. van den Berg.

E Pluribus Unix.
