From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] repack vs re-clone
Date: Mon, 11 Feb 2008 20:51:26 +0100
Message-ID: <200802112051.27271.jnareb@gmail.com>
References: <e5bfff550802100025k616ccff5ib2917d283eeb0ff0@mail.gmail.com> <m3myq7e3ie.fsf@localhost.localdomain> <e5bfff550802111120x24338cd6n6eb1f6db55fe487f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "git mailing list" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 20:53:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOehs-0002PU-SI
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 20:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758289AbYBKTvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 14:51:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758821AbYBKTvk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 14:51:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:53818 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758289AbYBKTvj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 14:51:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so361667ugc.16
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 11:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=sjk0O4W5Poj7MxgiJy4vG+3LUWYCoaze5pc8lVusNtw=;
        b=ENCFaONqFyYm+618S1ZzLwF9wfKiIyYkEgoxE6xPDOykKAJgmu3VfPbRC/P+SQ2QL3PYNPic9YKr8QFwO8lTomxOwvxQ7LJK3297/m30jInZt1wyVOdQzisj5NTFU7tXmzKNXpF4ZKsfAJwzmFZKymB2xksk/DI1plNKzv4Gnk8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=oLY3bAPRqpPuu2YmNL+oUyGDBclIOXW33NaLUyw5e92JWaciYV0CIkv/qqftugQrc3+uns1dHRldalKbNlDkCwquRtPzvCMPXksXtCrp6LQxjFw+E37AcdgqAeUs2hjxnHKyfdO998mR3ejWaRU9H2wo7b4D+0dWXVd1TUVJjvg=
Received: by 10.78.176.20 with SMTP id y20mr757963hue.36.1202759497420;
        Mon, 11 Feb 2008 11:51:37 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.220.23])
        by mx.google.com with ESMTPS id h1sm40463606nfh.20.2008.02.11.11.51.35
        (version=SSLv3 cipher=OTHER);
        Mon, 11 Feb 2008 11:51:36 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <e5bfff550802111120x24338cd6n6eb1f6db55fe487f@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73574>

Marco Costalba wrote:
> On Feb 11, 2008 7:45 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> > "Marco Costalba" <mcostalba@gmail.com> writes:
> >
> > > So it happens to be just faster to re-clone the whole thing by upstream.
> >
> > So what you are doing is passing the work, unnecessary work I'd say,
> > to some poor server. Not nice.
> 
> To a poor net bandwidth I would say because cloning from zero just
> downloads the packages.

Cloning from zero over http, https and rsync (and ftp) just downloads
the packfiles. Cloning over git or ssh if I understand correctly[*1*]
generates single pack for transfer. And that generates load for server.

[*1*] If I undersnad correctly from discussions here on git mailing
      list, the pack transfer protocol currently can transfer only
      _single_ pack; proposed multi-pack extension didn't get
      implemented.
-- 
Jakub Narebski
Poland
