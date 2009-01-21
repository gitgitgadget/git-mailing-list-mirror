From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: CR codes from git commands
Date: Wed, 21 Jan 2009 06:42:43 -0800
Message-ID: <18807.13411.984420.252378@hungover.brentg.com>
References: <18805.64312.289059.660023@hungover.brentg.com>
	<alpine.DEB.1.00.0901201757520.5159@intel-tinevez-2-302>
	<18806.44057.477379.215492@hungover.brentg.com>
	<alpine.DEB.1.00.0901210930370.7929@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 21 15:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPeJd-0006Lw-Nn
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 15:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755004AbZAUOmw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 09:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754203AbZAUOmw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 09:42:52 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:34533 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755AbZAUOmu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 09:42:50 -0500
Received: by rv-out-0506.google.com with SMTP id k40so3642178rvb.1
        for <git@vger.kernel.org>; Wed, 21 Jan 2009 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:mime-version
         :content-type:content-transfer-encoding:message-id:date:to:cc
         :subject:in-reply-to:references:x-mailer;
        bh=njdl9dYK3EcsUdbC2kPgTiFrHQ9Xm9Ljkp2D10fpBHs=;
        b=oCw7t+pnm/Pz7rTOkfdV4/9XwxF6xFM2fjUuhpvGISbXPt+0VWTbf9TXbzHBREQADi
         uCtbfDUUvxE5JVQcAfVzetKXzUVzcTT/lO6R9ryXpHkTYbNF9GOU124/M7Yb0P6nbJBi
         VAqDRTVeFk+qgEydPiSTLKCzytI0UYIB9Cx9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:mime-version:content-type:content-transfer-encoding:message-id
         :date:to:cc:subject:in-reply-to:references:x-mailer;
        b=rsM1Onoyu02TN8XtmejP2GsibEi7ku0qQoTvF03/NnC6fRyFAbN3CGw8QxJCjaldDf
         XLrOTbRoHLlvVo2IzaP6uWAimM/DLdetI1oH95vJodXBUP/mu6q84GPhjKkIwz8PHbF+
         wl+mAtqhH9hz2PlUeRa8z7399wKxrjosFbCEM=
Received: by 10.141.52.3 with SMTP id e3mr390332rvk.157.1232548969469;
        Wed, 21 Jan 2009 06:42:49 -0800 (PST)
Received: from hungover.brentg.com.thisisbogus.com ([76.14.208.3])
        by mx.google.com with ESMTPS id l31sm15504863rvb.2.2009.01.21.06.42.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Jan 2009 06:42:48 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901210930370.7929@racer>
X-Mailer: VM viewmail-606 under 23.0.60.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106613>


Johannes Schindelin writes:
 > Hi,
 > 
 > is there a special reason you un-Cc:ed the list?

No, my mistake.  CCing the mailing list now. I was foiled into
thinking that the reply operation in my email client meant reply-all,
but instead it was set to reply-to-sender-only. Now fixed.

 > 
 > On Tue, 20 Jan 2009, Brent Goodrick wrote:
 > 
 > > Johannes Schindelin writes:
 > > 
 > >  > On Tue, 20 Jan 2009, Brent Goodrick wrote:
 > >  > 
 > >  > > I am considering converting from CVS over to using git. I'm 
 > >  > > currently using git version 1.5.6.5 on Debian Linux "testing".
 > >  > 
 > >  > First of all, 1.5.6.5 is from last August, so chances are that the 
 > >  > behavior you complain about was fixed in the meantime.  We're at 
 > >  > 1.6.1 at the moment.
 > > 
 > > Yes, I thought that was a good point, so I rebuilt from the source 
 > > tarball git version 1.6.1 and retried my script and got the same 
 > > behavior.
 > > 
 > >  > The only place I can think about where a CR is output is when showing 
 > >  > the progress of downloading.
 > >  > 
 > >  > Usually, our code checks if stdout is a tty, and does not show 
 > >  > progress.
 > >  >
 > >  > As a work-around, piping into cat should work, though.
 > > 
 > > Actually only redirecting stderr and then piping to cat seems to work, 
 > > e.g.,:
 > > 
 > >   get pull 2>&1 | cat
 > > 
 > > 
 > > I don't mind seeing the progress lines, I just don't want git to emit 
 > > any CR codes at all.
 > > 
 > > How about a config option to just turn off any tty-detecting logic 
 > > entirely, so that I don't have to wrap git with a lot of silly scripts 
 > > that set environment variables and redirect stdout and stderr and piped 
 > > into "cat"?
 > 
 > Nope, the config option is not needed.  This is just a Plain Old Bug which 
 > needs fixing, that's all.
 > 
 > Let's see what I can do today.

Thanks.  The fix should be to arrange it so that I can set something
so that a bare call such as (but just "git pull"):

  git pull

will emit no CR codes at all, ever, regardless of if there is a tty.
Even if it is an env var, but a config setting would be ok too.

Thanks,
Brent
