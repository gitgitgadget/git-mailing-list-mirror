From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Wed, 10 Sep 2008 18:23:20 +0200
Message-ID: <200809101823.22072.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809100841080.3384@nehalem.linux-foundation.org> <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>,
	"Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Sep 10 18:25:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdSUk-0001wq-Ts
	for gcvg-git-2@gmane.org; Wed, 10 Sep 2008 18:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbYIJQXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2008 12:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYIJQXf
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Sep 2008 12:23:35 -0400
Received: from wx-out-0506.google.com ([66.249.82.238]:24767 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbYIJQXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2008 12:23:34 -0400
Received: by wx-out-0506.google.com with SMTP id h27so899612wxd.4
        for <git@vger.kernel.org>; Wed, 10 Sep 2008 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=2n1R6ZiLj1BHUa1K9DZ9bnrUPXWjNAvws8WUcd5BqCA=;
        b=q0Ss1aQfUbO3FwIUzxp7cCAhs+lKop2vlfSbxkBPz4CW7lIMei1huP8QlvUnluae5S
         bhsnEZi54r6yKOnuDFEp9LNMw2UKWFQffu0rRTEH/9o5zBSs6nZxnUb+BAUWk1+mFcZv
         uwC1jP5Qy82V9TkwT56g2UNRAnfbWkznPkrGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=t4RwIUbPq+TdHL96nKpzrpXcpdNX4FC03UjyYOyR5/v/CIlfKDyatAEg7YFEkdYcw4
         ERuT/UA+G4CAJYOlNaFNGazThv7agaNQS2qvCNqaB4QP/aXfCmphi1u6Lg6FM/2J3KWR
         e9GzdI3KugfgzJF+0gtfOLACpl9BF0jbs1e+E=
Received: by 10.86.57.9 with SMTP id f9mr1096792fga.66.1221063809999;
        Wed, 10 Sep 2008 09:23:29 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.133])
        by mx.google.com with ESMTPS id e20sm7622979fga.1.2008.09.10.09.23.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Sep 2008 09:23:28 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.1.10.0809100844040.3384@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95539>

Linus Torvalds wrote:
> On Wed, 10 Sep 2008, Linus Torvalds wrote:
> >
> > Sure. I don't use them either. But because I don't use them, it doesn't 
> > affect me. It also doesn't change the core git data structures in any way 
> > to introduce any new problems.
> 
> Btw, so far nobody has even _explained_ what the advantage of the origin 
> link is. It apparently has no effect for most things, and for other things 
> it has some (unspecified) effect when it can be resolved.
> 
> Apart from the "dotted line" in graphical history viewers, I haven't 
> actually heard any single concrete example of exactly what it would *do*.
> 
> And that dotted line really does sound like something you could do with 
> just the existing "hyperlink" functionality in the commit message.

As far as I understand (note: I'm neither for, nor against the proposal;
although I think it has thin chance to be accepted, especially soon),
it is for graphical history viewers, for git-cherry to make it more
precise (to detect duplicated/cherry-picked changes better), and in
the future possibly to help history-aware merge strategies. And probably
help patch management interfaces.

On the theoretical front it looks like extension/generalization of
a parent link, marking given commit do be derivative not only some
set of trees, or some line of history, but also on some changeset.

-- 
Jakub Narebski
Poland
