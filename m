From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Document clone of clone loosing branches?
Date: Sun, 15 Jun 2008 01:40:45 -0700 (PDT)
Message-ID: <m3od63ozuf.fsf@localhost.localdomain>
References: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
X-From: git-owner@vger.kernel.org Sun Jun 15 10:41:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7nny-00086G-PO
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 10:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756443AbYFOIkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 04:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756326AbYFOIkt
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 04:40:49 -0400
Received: from hu-out-0506.google.com ([72.14.214.235]:41333 "EHLO
	hu-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533AbYFOIks (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 04:40:48 -0400
Received: by hu-out-0506.google.com with SMTP id 28so5891730hub.21
        for <git@vger.kernel.org>; Sun, 15 Jun 2008 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=MI1u/N8YzLCAFp+Ommc1vL3p5p1KpbyZjn7S3LATTt4=;
        b=WuE3AWe57PtJrxV5Gr6rdd+RQOt7VoOdtUMGWz3N8H8HbI9ToZWKGbzNSMTRZMKbiD
         3lTSvNqJBK3OMrt2WeSOjKHKwyTUezVYbzgQoaG/A3eNWCCsh13vB+DzFPXHUm6PMzbb
         66YeMuun2DGjSHbo5mN8A4D8ZkFvhLb83cFyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=tKRghW30zAwVTwEbrDwOklu0QqeF8qlHokiO/gUOq8XHopFzRTrRCb5TfZtHwx5fno
         fDj5EHu2pORfCaaBbL00cY66lLsvdHn3XZn0RjEB4j13iwmC74kgJ+4XDV7BaPwGE4dO
         mX/Xbk7Uj+MNUFqmiWLb92UmdX1EsQLXBu86Q=
Received: by 10.210.21.6 with SMTP id 6mr4841862ebu.3.1213519246270;
        Sun, 15 Jun 2008 01:40:46 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.239.84])
        by mx.google.com with ESMTPS id b36sm6654413ika.5.2008.06.15.01.40.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Jun 2008 01:40:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5F8efXt030909;
	Sun, 15 Jun 2008 10:40:41 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5F8eehA030906;
	Sun, 15 Jun 2008 10:40:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85071>

Vaclav Hanzl <hanzl@noel.feld.cvut.cz> writes:

> I wander whether man git-clone is correct when it says "creates
> remote-tracking branches for each branch in the cloned repository".
> 
> IMHO remote-tracking branches in the original repository _are_
> branches and they are _not_ cloned (when using git-clone with no
> options) - maybe this is worth noting very explicitly?

It probably should read "for each _regular_ branch in the cloned
repository".

And of course if you are creating bare clone it does mirror regular
branches (1:1 mapping) instead of remote-tracking branches (mappping
from refs/heads/* into refs/remotes/origin/* namespace).

[...]
> Is it just my failure to read those few hundred man pages carefully
> enough (I did my best :-) ), or something worth fixing in man
> git-clone and tutorials?

Even if it is just your failure it would be worh correcting
(enhancing) documentation to make it more clear.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
