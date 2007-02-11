From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 18:51:05 -0500
Message-ID: <9e4733910702111551t3935fb88yf19e3ea608094687@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:51:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOTQ-000210-1r
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:51:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929AbXBKXvI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932931AbXBKXvI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:51:08 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:58819 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932929AbXBKXvG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:51:06 -0500
Received: by wr-out-0506.google.com with SMTP id 68so1463384wri
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 15:51:05 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CLwbkqsiMv+R8Scqe7z2mH3OqakDdvC86DHjB69/bOGeT69eqWL8xEVM226Axd/BtxQat9Kp/bosfgj7NssiG28xH2/+yOPOHWpVtTD8vmVtMYy5tA5FKPSV2WLx2B2AMDiazcUY9Ex/ojuvjjn3l+IMcJAuJudC+ycfuhxSDac=
Received: by 10.114.161.11 with SMTP id j11mr6577556wae.1171237865249;
        Sun, 11 Feb 2007 15:51:05 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 15:51:05 -0800 (PST)
In-Reply-To: <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39336>

On 2/11/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > > remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
> > > 100% (63/63) done
> > > fatal: pack: not a valid SHA1
> > > New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
> >
> > What version of git is this?  That looks like we're assuming the word
> > pack was an object, but I'm not sure why we would do such a thing...
>
> jonsmirl@jonsmirl:/usr/local/bin$ git --version
> git version 1.5.0.rc2.g53551-dirty
>

I just whacked my git tree, cloned a new copy and installed it. Still
get the same errors.

jonsmirl@jonsmirl:/extra$ rm -rf wireless-dev
gjonsmirl@jonsmirl:/extra$ cg clone
git://git2.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
Initialized empty Git repository in .git/
Fetching pack (head and objects)...
remote: Generating pack...
remote: Done counting 404120 objects.
remote: Deltifying 404120 objects.
remote:  100% (404120/404120) done
Indexing 404120 objects.
remote: Total 404120, written 404120 (delta 320324), reused 365290
(delta 282572)
 100% (404120/404120) done
Resolving 320324 deltas.
 100% (320324/320324) done
fatal: pack: not a valid SHA1
Fetching tags... v2.6.12 v2.6.12-rc2 v2.6.12-rc3 v2.6.12-rc4
v2.6.12-rc5 v2.6.12-rc6 v2.6.13 v2.6.13-rc1 v2.6.13-rc2 v2.6.13-rc3
v2.6.13-rc4 v2.6.13-rc5 v2.6.13-rc6 v2.6.13-rc7 v2.6.14 v2.6.14-rc1
v2.6.14-rc2 v2.6.14-rc3 v2.6.14-rc4 v2.6.14-rc5 v2.6.15 v2.6.15-rc1
v2.6.15-rc2 v2.6.15-rc3 v2.6.15-rc4 v2.6.15-rc5 v2.6.15-rc6
v2.6.15-rc7 v2.6.16 v2.6.16-rc1 v2.6.16-rc2 v2.6.16-rc3 v2.6.16-rc4
v2.6.16-rc5 v2.6.16-rc6 v2.6.17 v2.6.17-rc1 v2.6.17-rc2 v2.6.17-rc3
v2.6.17-rc4 v2.6.17-rc5 v2.6.17-rc6 v2.6.18 v2.6.18-rc1 v2.6.18-rc2
v2.6.18-rc3 v2.6.18-rc4 v2.6.18-rc5 v2.6.18-rc6 v2.6.18-rc7 v2.6.19
v2.6.19-rc1 v2.6.19-rc2 v2.6.19-rc3 v2.6.19-rc4 v2.6.19-rc5
v2.6.19-rc6 v2.6.20-rc1 v2.6.20-rc2 v2.6.20-rc3 v2.6.20-rc4
v2.6.20-rc5 v2.6.20-rc6
remote: Generating pack...
remote: Done counting 63 objects.
remote: Deltifying 63 objects.
remote:  100% (63/63) done
Indexing 63 objects.
remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
 100% (63/63) done
fatal: pack: not a valid SHA1
New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
Cloned to wireless-dev/ (origin
git://git2.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
available as branch "origin")
jonsmirl@jonsmirl:/extra$ git --version
git version 1.5.0.rc4.g1843e
jonsmirl@jonsmirl:/extra$ cg --version
cogito-0.18.2 (cogito-0.18rc1-gb6a6e87)


-- 
Jon Smirl
jonsmirl@gmail.com
