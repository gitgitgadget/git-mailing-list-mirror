From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree performance problems)
Date: Wed, 20 Apr 2005 22:11:10 +1000
Message-ID: <2cfc403205042005116484231c@mail.gmail.com>
References: <200504191250.10286.mason@suse.com>
	 <200504191708.23536.mason@suse.com>
	 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
	 <200504192049.21947.mason@suse.com>
	 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
	 <42660708.60109@zytor.com>
	 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
Reply-To: jon@zeta.org.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Wed Apr 20 14:15:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOE6T-0008VL-Q7
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 14:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261573AbVDTMSm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 08:18:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261546AbVDTMPF
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 08:15:05 -0400
Received: from rproxy.gmail.com ([64.233.170.203]:7119 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261573AbVDTMLP convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 08:11:15 -0400
Received: by rproxy.gmail.com with SMTP id z35so119366rne
        for <git@vger.kernel.org>; Wed, 20 Apr 2005 05:11:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HtahUshJn5acfQ8gl1v8tWzgUwnsSc0Xhsk88iq0y1Fyjuxbcaa1CJ0MYyJ3P5aMkkiiqPaxZJaarAX62YAOZ8r6oanXbsVWNlMj3b2RCILaSxvG1yCKhoWp4eTuFavVi6yennWFsNe0KN6GqUfTe6EkFSSchP+NAjGtA8BdIp0=
Received: by 10.38.75.59 with SMTP id x59mr787449rna;
        Wed, 20 Apr 2005 05:11:10 -0700 (PDT)
Received: by 10.38.104.32 with HTTP; Wed, 20 Apr 2005 05:11:10 -0700 (PDT)
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 4/20/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> I converted my git archives (kernel and git itself) to do the SHA1 hash
> _before_ the compression phase.
> 

Linus,
 
 Am I correct to understand that with this change, all the objects in
the database are still being compressed (so no net performance benefit
now), but by doing the SHA1 calculations before compression you are
keeping open the possibility that at some point in the future you may
use a different compression technique (including none at all) for some
or all of the objects?

jon.

[ reposted to list, because list post was bounced because of rich text
formatting ]
