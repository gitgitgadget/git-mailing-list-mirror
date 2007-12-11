From: "Daniel Berlin" <dberlin@dberlin.org>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 12:53:30 -0500
Message-ID: <4aca3dc20712110953h13e3c33ftb310609bbac6a0a8@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.99999.0712111245260.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 18:54:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29Ir-000412-7P
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 18:53:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753353AbXLKRxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 12:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753223AbXLKRxf
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 12:53:35 -0500
Received: from nz-out-0506.google.com ([64.233.162.234]:40243 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbXLKRxe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 12:53:34 -0500
Received: by nz-out-0506.google.com with SMTP id s18so1249312nze
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 09:53:32 -0800 (PST)
Received: by 10.142.215.5 with SMTP id n5mr1996508wfg.1197395610185;
        Tue, 11 Dec 2007 09:53:30 -0800 (PST)
Received: by 10.142.217.1 with HTTP; Tue, 11 Dec 2007 09:53:30 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712111245260.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67893>

On 12/11/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 11 Dec 2007, Daniel Berlin wrote:
>
> > On the gcc repository (which is now a 234 meg pack for me), git
> > annotate ChangeLog takes > 800 meg of memory (I stopped it at about
> > 1.6 gig, since it started swapping my machine).
> > I assume it will run out of memory.  I stopped it after 2 minutes.
>
> And I bet this is the exact same issue as the repack one.
>
> Do you still have the 2.1GB pack around?  I bet annotate would eat much
> less memory in that case.

I do not, but i could remake it in a few days if it would help
