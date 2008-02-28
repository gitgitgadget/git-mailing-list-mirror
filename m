From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Google Summer of Code 2008
Date: Thu, 28 Feb 2008 14:59:53 +0100
Message-ID: <2c6b72b30802280559o4eda2d36m1cb85e5ea7a863f0@mail.gmail.com>
References: <200802262356.28971.jnareb@gmail.com>
	 <alpine.LSU.1.00.0802262337390.22527@racer.site>
	 <20080228063621.GR8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 15:01:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUjJI-0006j9-OQ
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 15:00:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649AbYB1N7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 08:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbYB1N7z
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 08:59:55 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:38976 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbYB1N7y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 08:59:54 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2158524rvb.1
        for <git@vger.kernel.org>; Thu, 28 Feb 2008 05:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=UMxjPJqXIkuNfR3rKu/MO+G8ZLIgjjbYFrZ9AazBWyc=;
        b=tc2xj6VBLRHxMKsAMH6rEeg55Ys3PYf2Bj/4tlLbUjPpk75QsDB5vxIiB7JfHI66H70/bwi51wm1+dkPWD0eXrMVShl1b8IbbOCpG0j+/i0yjNKjrNKS4aogdRbUz7TPdLwODmeAxF3JagsvWWeUBIAf8y+LQZgMVuZ+/3LpxoM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HMnH8HLUtap55Zkm+gwAKnaWROZMsrcDdvD2ZG/fY38Aof/E2++QJ1P6vhgvF1ewzItMpSp8g9EbaajL9hBwbNkBgf+JYiOFbPDwZu+m5oMr+EFzQs9i3iI/Gpd3XvEPz+bA8s8XtN6qoIA6tQ0bq812t0+fJV2dUuJHfDcp83w=
Received: by 10.141.156.19 with SMTP id i19mr5460189rvo.25.1204207193410;
        Thu, 28 Feb 2008 05:59:53 -0800 (PST)
Received: by 10.141.163.17 with HTTP; Thu, 28 Feb 2008 05:59:53 -0800 (PST)
In-Reply-To: <20080228063621.GR8410@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75399>

Hello,

On Thu, Feb 28, 2008 at 7:36 AM, Shawn O. Pearce <spearce@spearce.org> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  > On Tue, 26 Feb 2008, Jakub Narebski wrote:
>  > As for projects, I imagine that Gitorrent, further builtinification and
>  > Windows support would be good candidates.
>
>  Yea, Gitorrent would be cool.  Especially since send-pack is
>  somewhat heavy on the server's resources and there are some very
>  popular projects offered in git format (hello Linux kernel!).

I will take this opportunity to add a few comments and promote a page.
To help improve chances of success for such a project, perhaps a
"community" edition of the protocol is in order. I have been planning
(and still are) to do a review of the protocol specification with input
from the mailing list. Basically, I am thinking to break the current RFC
document into self-contained chunks: a formal introduction + goals,
meta file and tracker part, and finally repository serialization and peer
wire.

In preparation, I started to populate pages at:

  http://gittorrent.googlecode.com/

If there is interest I will try to find time to restart this process.

-- 
Jonas Fonseca
