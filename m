From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 20:31:11 +0200
Message-ID: <200610232031.12399.jnareb@gmail.com>
References: <45357CC3.4040507@utoronto.ca> <200610232021.55625.jnareb@gmail.com> <1161628001.27312.8.camel@charis.lan.vernstok.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	James Henstridge <james@jamesh.id.au>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 20:31:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc4Zj-0002k2-Rx
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 20:31:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWJWSa7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 14:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWJWSa7
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 14:30:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:55469 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965001AbWJWSa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 14:30:58 -0400
Received: by ug-out-1314.google.com with SMTP id q2so1466845uge
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 11:30:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MTPpfSrlH0x+AlXjMuCRobLEure2+P3ME07fphNA+VAj4g9eKFFANRRzAGUEf3N7Z/JrgogyOEdFmP8v+PgkEy8lv/v7508weJugpF90JVKIVyffCDoovc/OKz1spr7m6MaivtezZnq6Kk/Q7Xj3384ZkTj3b2aSk/ErbySNGpM=
Received: by 10.66.220.17 with SMTP id s17mr7839943ugg;
        Mon, 23 Oct 2006 11:30:56 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id e33sm337182ugd.2006.10.23.11.30.54;
        Mon, 23 Oct 2006 11:30:55 -0700 (PDT)
To: Jelmer Vernooij <jelmer@samba.org>
User-Agent: KMail/1.9.3
In-Reply-To: <1161628001.27312.8.camel@charis.lan.vernstok.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29855>

Jelmer Vernooij wrote:
>> By the way, I wonder if accidentally identical revisions
>> (see example for accidental clean merge on revctrl.org)
>> would get the same revision id in bzr. In git they would.

> They won't. The revision id is made up of the committers email address,
> a timestamp and a bunch of random data. It wouldn't be hard to switch
> using checksums as revids instead, but I don't think there are any plans
> in that direction.

The place for timestamp and commiter info is in the revision metadata
(in commit object in git). Not in revision id. Unless you think that
"accidentally the same" doesn't happen...
-- 
Jakub Narebski
Poland
