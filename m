From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH] Add new 'rebase' command.
Date: Sun, 21 Jan 2007 23:37:14 +0000
Message-ID: <b0943d9e0701211537oac61eceq48d45501193e6790@mail.gmail.com>
References: <20070120180329.22621.30534.stgit@gandelf.nowhere.earth>
	 <b0943d9e0701211500v2f54aa61k2592ba060131318@mail.gmail.com>
	 <20070121232618.GD4665@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 00:37:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H8mFT-0002Hc-Uo
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 00:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751794AbXAUXhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 21 Jan 2007 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbXAUXhQ
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jan 2007 18:37:16 -0500
Received: from nz-out-0506.google.com ([64.233.162.237]:39998 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbXAUXhP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jan 2007 18:37:15 -0500
Received: by nz-out-0506.google.com with SMTP id s1so785781nze
        for <git@vger.kernel.org>; Sun, 21 Jan 2007 15:37:14 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kr+dwKznve5DobcxFqjUzzsWX9/YbCy214zpemWRMLeXatYvXYFqVLQVe4z1zujBzqjr2i7YL7K5X4Mt6UEOudW40kH2a3sXf9w8g1LaKmxkNXS4ZqCZWatRRht47LHzOX7Z1yQpLeWqu0PHKX061UOpte3KwfTuGq7g6lOGDUc=
Received: by 10.65.236.14 with SMTP id n14mr6413722qbr.1169422634484;
        Sun, 21 Jan 2007 15:37:14 -0800 (PST)
Received: by 10.65.133.13 with HTTP; Sun, 21 Jan 2007 15:37:14 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070121232618.GD4665@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37364>

On 21/01/07, Yann Dirson <ydirson@altern.org> wrote:
> On Sun, Jan 21, 2007 at 11:00:57PM +0000, Catalin Marinas wrote:
> > I applied it but changed the patch a bit so that there is no need for
> > the --to option. I understood your point but I find it a bit strange
> > to have this mandatory option. Anyway, command line syntax doesn't
> > have to follow the natural language exactly :-).
>
> Well, I thought the natural next patch to this command would be,
> according to the discussions with Jakub, to make first "--to target"
> optional, as a natural replacement for "stg pull . <target>" when the
> target is the parent branch, and then possibly add the ability of
> running rebase from the target branch as also sugested by Jakub,
> leading to the natural "rebase [<stack>|--to <target>]" syntax.
>
> Although I'm not sure we'll do that in the near future, removing the
> need for --to would somewhat get in the way of this possibility.

I'll go through the other e-mails tomorrow (too late here) and either
add the option back or come with counter arguments :-)

-- 
Catalin
