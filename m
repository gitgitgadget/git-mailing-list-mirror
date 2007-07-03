From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH] Make '!' aliases more useful
Date: Tue, 3 Jul 2007 09:07:10 +0200
Message-ID: <81b0412b0707030007o328f0b35hfa758e1f3b2ef289@mail.gmail.com>
References: <Pine.LNX.4.64.0707012249590.4438@racer.site>
	 <20070702145549.GB4720@thunk.org>
	 <Pine.LNX.4.64.0707021654450.4071@racer.site>
	 <20070702160810.GD4720@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: "Theodore Tso" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Jul 03 09:07:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5cTl-0004co-3K
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 09:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753683AbXGCHHO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Jul 2007 03:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbXGCHHO
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jul 2007 03:07:14 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:40177 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852AbXGCHHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2007 03:07:12 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1719207wxd
        for <git@vger.kernel.org>; Tue, 03 Jul 2007 00:07:11 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=drW80r+Z7wMkz++ev7ZNWFqovRWD6h2sXLvQQmqWOzh1ljJ6S1Z4vQC+ArNFrtdvm2KuDJCM5yJC7Cad0yIQRc9e71r1jOmZRtVkrunY4M4sgkmeTFT5SGaVZ3KLi70C/uCepUM6yLLxo72WInYiOY9Sqf/Cyb4nrixMsZJ02hQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jLEAcXaMGRXQiWxrpMrvE7z0HE3kE+m0ibasngrEfrgKbRsL01CvRtKbXt2zUU94t4iwWqWCUZbnMm9csCdgPOINkhBu6p3HBStb8TcyJIzrtzZZgph45I57Ia6XG0L6rGi9FFcoyXUW75R0kkqqDuaeuPQUld78owGJ40MogGg=
Received: by 10.78.201.2 with SMTP id y2mr3330834huf.1183446430320;
        Tue, 03 Jul 2007 00:07:10 -0700 (PDT)
Received: by 10.78.100.16 with HTTP; Tue, 3 Jul 2007 00:07:10 -0700 (PDT)
In-Reply-To: <20070702160810.GD4720@thunk.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51464>

On 7/2/07, Theodore Tso <tytso@mit.edu> wrote:
> On Mon, Jul 02, 2007 at 04:55:24PM +0100, Johannes Schindelin wrote:
> > > But what if you don't want the argument passed at the end of the
> > > alias, but somewhere else?  I suspect the better answer would be to
> > > support $* and $1, $2, $3, et. al interpolation, no?  It was on my
> > > list of things to do when I had a spare moment, but I never got around
> > > to it.
> >
> > There is a point where you do not want to complicate git, but rather write
> > a script. This is such a point IMHO.
>
> Such a point exists, I agree, but I would draw after $* and $1/$2/$3
> interpolation.  There is a lot more value that gets added with
> positional arguments support, and it makes git aliases more usable on
> platforms such as Windows where scripting capability is much more
> limited.

I don't think it is _possible_ to make it work on Windows properly: you have
to quote the arguments with whitespaces as there is nothing like argv there
(windows programs don't use command line, so it does not exist).
As the quoting is implemented in the programs the rules are all different
and mostly suboptimal.
