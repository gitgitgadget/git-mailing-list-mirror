From: "Mike Dalessio" <mike.dalessio@gmail.com>
Subject: Re: Git-aware Issue Tracking?
Date: Wed, 20 Aug 2008 16:22:29 -0400
Message-ID: <618c07250808201322r7422116bw2b6bb106412b50dc@mail.gmail.com>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com>
	 <20080819175931.GH20947@spearce.org>
	 <200808192121.30372.robin.rosenberg.lists@dewire.com>
	 <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org>
	 <20080820152305.GJ10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	"Marek Zawirski" <marek.zawirski@gmail.com>,
	"Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 20 22:23:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVuDO-0003hp-Fs
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 22:23:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754131AbYHTUWb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 16:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbYHTUWb
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 16:22:31 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:51845 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753823AbYHTUWa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 16:22:30 -0400
Received: by gxk9 with SMTP id 9so117659gxk.13
        for <git@vger.kernel.org>; Wed, 20 Aug 2008 13:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mBFzCLfYytDw681JXCHN3TuST3fdhLrgu2xg/h1U2to=;
        b=VB87JhZ0+GkO7qWBQj9y7jIsvnmnuLQCQffzztZcjtxV428Kj2XpXbgPfZM0SxAUdC
         HNHMnUYpCPWhv+p3xI46+MujjMv9Tw/a/nvraryQG4W95Ld/Guq7vn9W40OfjrosuBXo
         VwAzN6ZA330FTkwk8rZgturEYFEeFN4vU7OGg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rufav0O4mtMnT8mhvL+aEAmFAIqFAOrLl559sJk8DB3EBlNVp/XuEhBQIWcg6VQ6zp
         lp+ODWnhwSzmgFEMkTnbfUngU3QifvH2983BZ0HqhVrdSjcUgtskaepN+vVqazaTYfto
         SdIHElmmphoGo2h7C6p+/uZqKvophJjohjiRw=
Received: by 10.151.13.7 with SMTP id q7mr702858ybi.52.1219263749283;
        Wed, 20 Aug 2008 13:22:29 -0700 (PDT)
Received: by 10.150.58.3 with HTTP; Wed, 20 Aug 2008 13:22:29 -0700 (PDT)
In-Reply-To: <20080820152305.GJ10544@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93033>

On Wed, Aug 20, 2008 at 11:23 AM, Petr Baudis <pasky@suse.cz> wrote:
> I have been thinking about issue tracking for some of my projects too,
> but I'm wondering, does anyone have a comprehensive picture of the state
> of the Git-supporting issue tracking tools, especially those that keep
> the tracked issues in a Git repository as well?

I haven't played with it, but this looks like it's along the lines of
what you're discussing:

     http://github.com/jwiegley/git-issues/tree/master

It apparently uses an unchecked-out branch in the project to manage its data,
which is stored in a hash directory structure similar to .git/objects.
