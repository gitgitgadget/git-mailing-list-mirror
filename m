From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: hosting multiple project in single git repository
Date: Wed, 13 May 2009 13:58:28 -0400
Message-ID: <32541b130905131058i54dfa56ck8938aab96cb1d442@mail.gmail.com>
References: <4997275b0905131031q3c572854r4b0a899ca43063be@mail.gmail.com> 
	<4997275b0905131046s407e334ag6783a6365c89fe10@mail.gmail.com> 
	<4997275b0905131048t1b5c1427w85a2f96964ea16b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "S. M. Ibrahim (Lavlu)" <smibrahim@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 20:07:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4Ipz-0007BY-Kp
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 20:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760631AbZEMSFe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 14:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760507AbZEMSFe
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 14:05:34 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:49968 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759931AbZEMSFd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 14:05:33 -0400
Received: by gxk10 with SMTP id 10so1480592gxk.13
        for <git@vger.kernel.org>; Wed, 13 May 2009 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=PhrsI19B6FLCac/QZKI8flEWxhgZH2P2NbonROHeXIE=;
        b=DatMTxoQP/XTSJMuxFfUk3cfggGHHVMmpVV8qjkhP+dkeEGuJRLaQu3cErkbmh+pmn
         euTYgxoQHrcw0QJPhvK6M6h07XVGJpkZ10x5kvohZE83mUZQMwB9aPMUd2m0t/WeZse3
         oPlJ2zrWAgFA1oqFoo9C3uTHAbx2yAu69dJjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=rtIFxqNP3BORRAlHDg8asjiVx2J7UlYFHEVyCH9c5T7RX2FXmJ4jOpISe3bFHWDTCI
         xIRUagAhZTYnvnqVJHHi4sHj92R6SKbtwEWiu7cGX+QYxD/7qT6tvzZN+FTCkac+yvcv
         FdX0RpOcbfVLny04cftjA/B1TXGukd1l4iqlQ=
Received: by 10.150.230.1 with SMTP id c1mr1576851ybh.256.1242237528065; Wed, 
	13 May 2009 10:58:48 -0700 (PDT)
In-Reply-To: <4997275b0905131048t1b5c1427w85a2f96964ea16b6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119079>

On Wed, May 13, 2009 at 1:48 PM, S. M. Ibrahim (Lavlu)
<smibrahim@gmail.com> wrote:
> in our company we are moving all our subversion repository to git.
> git-svn is working really nice. but facing a problem. we have one svn
> repository where we hosted two projects and both the projects are
> under development. project a is trunk and project b is branch/xxxx .
> and project b was copied from trunk . we have plan to merge this two
> project in future. what is the best way to maintain this two project
> in git ? should we make to different git repository .

If they both branched from the same place and they might be merged
back together someday, then keeping them in the same repository seems
rather harmless.  And you can always split the repositories later if
you want.  Similarly, you can check out the same repository in two
different local directories on two different branches and it's
essentially equivalent to having two repositories in the first place.

What problems are you having with the setup as it is now?

Have fun,

Avery
