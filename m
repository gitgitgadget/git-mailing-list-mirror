From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 15:34:54 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803231534050.4353@racer.site>
References: <47E64F71.3020204@jwatt.org>  <alpine.LSU.1.00.0803231401340.4353@racer.site>  <47E658D3.1060104@jwatt.org>  <51419b2c0803230645l5b07bbf5h9cbf9b6f47373efa@mail.gmail.com>  <47E6612A.5020408@jwatt.org> <51419b2c0803230706w5ff88fc7oc7e8e34ab8afa1fd@mail.gmail.com>
 <47E668E1.80804@jwatt.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jonathan Watt <jwatt@jwatt.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 15:35:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdRIR-00054f-W1
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 15:35:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757604AbYCWOe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 10:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757412AbYCWOe6
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 10:34:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:50116 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757309AbYCWOe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 10:34:58 -0400
Received: (qmail invoked by alias); 23 Mar 2008 14:34:56 -0000
Received: from host86-148-26-43.range86-148.btcentralplus.com (EHLO racer.home) [86.148.26.43]
  by mail.gmx.net (mp008) with SMTP; 23 Mar 2008 15:34:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/YzJPrz9/u47An9HiKa85YItcVFE6x6bgG+h+jN
	cy9//yLO2oLAiF
X-X-Sender: gene099@racer.site
In-Reply-To: <47E668E1.80804@jwatt.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77910>

Hi,

On Sun, 23 Mar 2008, Jonathan Watt wrote:

> Elijah Newren wrote:
>
> > So, it sounds like we're both saying that in your case, you'd like the 
> > HEAD become detached and track the sha1 that it previously pointed to 
> > before your push rather than continuing to track the updated branch.
> 
> Yes, indeed. From my novice perspective it seems like that's absolutely 
> what should happen, since that's where the working copy came from. 
> Certainly I see no reason for git-push to leave the working 
> copy/revision relationship in a bad state.

This is a horrible idea.

If you want to push into non-bare repositories, then please, please, 
please read the tutorials on that subject.

Thanks,
Dscho
