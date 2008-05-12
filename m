From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Mon, 12 May 2008 03:16:56 -0700 (PDT)
Message-ID: <m3d4nr4ykr.fsf@localhost.localdomain>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com>
	<bd6139dc0805120238n1f990b4dwcd0e133ff146ed1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>,
	"David Symonds" <dsymonds@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Mon May 12 12:17:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvV6L-00010h-LV
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 12:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757913AbYELKRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 May 2008 06:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756348AbYELKRA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 May 2008 06:17:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:63242 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756095AbYELKQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 May 2008 06:16:59 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1046168nfc.21
        for <git@vger.kernel.org>; Mon, 12 May 2008 03:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=SzGVs6jUzIDWbOiVm+RZiEy5UPoSrqkWrR0ugQ9uLgM=;
        b=LKsEhpvKnwYascMe3FdAwfySvLm9oVIahh5GswhmuDzXr8x4pR7+Rn9LNmuM9e2vD7bF+kLxnT19wolrIKLV0U07fp2RG/ECzODWg2nzAX5T/xCXYrIc6FuGTydREnRedimkRtttO/bNs29OgRC8A/yzMdL8oSIWeyr5nJuooOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=HWnjfo273+8ciMrzHTzazKIrNNlt9QPpB1vNqNP3WSd/R2Px6/5UueBrs6L4XHevJnjQGLokP5HHi8gsRUnltLW5ioYvd1J6XJWuoShYxC858nE/qpDPJKj1p8sVZX9/HmHBQoWBPL0AQu211UluQquPpXnGOlaRa2IOjoHRh8w=
Received: by 10.210.142.6 with SMTP id p6mr6973207ebd.102.1210587417231;
        Mon, 12 May 2008 03:16:57 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.115])
        by mx.google.com with ESMTPS id y37sm2430983iky.8.2008.05.12.03.16.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 May 2008 03:16:56 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m4CAGrxg011117;
	Mon, 12 May 2008 12:16:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m4CAGKr9011110;
	Mon, 12 May 2008 12:16:20 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <bd6139dc0805120238n1f990b4dwcd0e133ff146ed1d@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81850>

"Sverre Rabbelier" <srabbelier@gmail.com> writes:

> On Thu, May 8, 2008 at 5:51 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > Heya,
> >
> > I've been busy to write up some use cases for 'git statistics' (a new
> > command that I will be implementing this summer during Google Summer
> > of Code). For more details on my proposal please see
> > http://alturin.googlepages.com/gsoc2008 (a pdf of the use cases is
> > hosted there as well for those who prefer pdf). I would like to ask
> > for comments on the current use cases; is anything missing, or should
> > a particular use case be removed/merged? Please let me know.
> 
> Heya,
> 
> I haven't had replies to this e-mail so far, did it get lost in the
> list noise?

One comment: did you take a look at 'owners.sh' script posted some
time ago by (IIRC) spearce to check who "owns" egit/jgit and relevant
git code?  This is one interesting, and useful, statistics.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
