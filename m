From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 15:31:23 -0500
Message-ID: <9e4733910712111231x1bbe181ew4f90fc5bb0e87039@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	 <alpine.LFD.0.99999.0712111403080.555@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Daniel Berlin" <dberlin@dberlin.org>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:32:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Bld-0007Ww-7c
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754564AbXLKUb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754273AbXLKUbZ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:31:25 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:58886 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754126AbXLKUbY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:31:24 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2159508rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 12:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=YQmIUDt9d+6OwgBHjCMu4u4ipRXd22aRiyou73F0TZY=;
        b=f2sdd+6yBJAeDEswJhma6gkSkKV/7PrQ0QQfNNMGNoech28suM34eXznpWOUpoygBaNb0oqmhRNKK+0J/2Pa4V9IceZoxOtu6iJIvIJjSEeFD3xNVsQ30wYDlHXw3QnjIPwqAbWhVnNVSLvzLV7zR4idQNWqpmsUq8JydoiQF/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=waWfVRnbEwuPMSGo9eBIC7Xfwi/1/JWBNKSJ4uWml1HH7fE10mN4IFuKqhA4zPDunanPYAdBxr3tHNlUHVP2akJZdnNujqwDZN6gRJYyZrne2wzLche/jj14INfVMaelKBr5iLrOY69AqPbjt4bxwnYXql5dOEPnFxG/Z0QruKk=
Received: by 10.140.164.1 with SMTP id m1mr739708rve.1197405083781;
        Tue, 11 Dec 2007 12:31:23 -0800 (PST)
Received: by 10.140.166.14 with HTTP; Tue, 11 Dec 2007 12:31:23 -0800 (PST)
In-Reply-To: <alpine.LFD.0.99999.0712111403080.555@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67934>

On 12/11/07, Nicolas Pitre <nico@cam.org> wrote:
> On Tue, 11 Dec 2007, Linus Torvalds wrote:
>
> > That said, I'll see if I can speed up "git blame" on the gcc repository.
> > It _is_ a fundamentally much more expensive operation than it is for
> > systems that do single-file things.
>
> It has no excuse for eating up to 1.6GB or RAM though.  That's plainly
> wrong.

 git blame gcc/ChangeLog
It needs 2.25GB of RAM to run without swapping

That is pretty close to the same number the repack needs.

-- 
Jon Smirl
jonsmirl@gmail.com
