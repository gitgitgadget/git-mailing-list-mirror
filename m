From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [BUG] Problem with "stgit push" causing data loss
Date: Sun, 21 Jan 2007 22:42:18 +0000
Message-ID: <b0943d9e0701211442q503396ack2bf2d088325fc4a0@mail.gmail.com>
References: <20070120150113.GB4665@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "GIT list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 21 23:42:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8lOI-0007DY-Az
	for gcvg-git@gmane.org; Sun, 21 Jan 2007 23:42:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbXAUWmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 17:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751739AbXAUWmT
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 17:42:19 -0500
Received: from nz-out-0506.google.com ([64.233.162.224]:27368 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736AbXAUWmS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 17:42:18 -0500
Received: by nz-out-0506.google.com with SMTP id s1so778460nze
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 14:42:18 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=op2xlie1zM9zEW3yO/CbvHyGwiyc6M6J2k3l+u+IlOduNNw20BdPjtUEukNHJM6rQEMdNVlspioualLY7Up8BE1oZZDcQA68zlRiG2z6M863d2fDEfurrrFPofHGbcYxt71sO19A2DlgflghjZtAJb4oboIwfOhCr7/fb3H3rGw=
Received: by 10.65.211.1 with SMTP id n1mr6356553qbq.1169419338194;
        Sun, 21 Jan 2007 14:42:18 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Sun, 21 Jan 2007 14:42:18 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070120150113.GB4665@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37355>

On 20/01/07, Yann Dirson <ydirson@altern.org> wrote:
> Well, "data loss" is a bit strong, since the data is still available
> to find using git-lost-found.
>
> I first tried to reproduce with a simple test-case, but could not, so
> here is my way to reproduce it, on a clone of the stgit official
> workspace.

I tried to somehow emulate this without the fold script but didn't
manage to trigger the bug. I'll try with your script tomorrow but
first:

Do you use the latest HEAD in the StGIT repository? I'm asking because
the line numbers reported in your backtrace are different from mine. I
also made some changes in this area in the past couple of weeks which
might have fixed or broken things.

-- 
Catalin
