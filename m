From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Fri, 3 Sep 2010 11:23:41 +0100
Message-ID: <AANLkTi=r21khJLMvwH7h2M_Yqv8QFAD-L2RX8NrbEjoc@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
	<alpine.LFD.2.00.1009021233190.19366@xanadu.home>
	<4C7FDA32.5050009@gmail.com>
	<alpine.LFD.2.00.1009021326290.19366@xanadu.home>
	<AANLkTi=Q7EfeUDB6PuSa88PDtaBZSMMuaMqh8hU25ECb@mail.gmail.com>
	<20100902192910.GJ32601@spearce.org>
	<m3y6bjnadu.fsf@localhost.localdomain>
	<AANLkTikSHXivniUk-1KU30Ws23ebnbDhOmjKmpmVH-Y9@mail.gmail.com>
	<alpine.LFD.2.00.1009021931340.19366@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jakub Narebski <jnareb@gmail.com>, git <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 12:23:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrTR0-0005SE-Cn
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 12:23:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab0ICKXo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Sep 2010 06:23:44 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58234 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154Ab0ICKXn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Sep 2010 06:23:43 -0400
Received: by vws3 with SMTP id 3so1233987vws.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 03:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Md6Z5FfBiDN8OlARy3HtRWTX6JUUClHgj8OnDKFL3QI=;
        b=agH8ytfD55JplRELCfgsFgvCamVT9+b4DdQuNGVTuF4uDpUfhBXHRQFPUV5/41mznM
         p5wHv3v2hq8LRuxdmXfiAXrd6sLTXKZOX9OM67VH0RxpoK8GpZaSMh0Wuqn6vY/eHefv
         WdeXIVF9MTz+NsNnNwUi5VCOLbaaguvx1ay50=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=F3itACeNfa0zXnYx/9bWSZkV6nOgMtJuGHvZPoSQEiImBboUqXNcXj/nXND595kQVn
         CIQmhFNlbL6cdSLv7o0va3WNzTUsJnklwTgohNnlBIRVEJ2XZ0kqW60nBURZK8xR8GM+
         t3ujXWwELoQADbSgm731peOnr1r1ecIU/ggDE=
Received: by 10.220.75.200 with SMTP id z8mr408389vcj.197.1283509422243; Fri,
 03 Sep 2010 03:23:42 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Fri, 3 Sep 2010 03:23:41 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1009021931340.19366@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155239>

very quick reply am off out

On Fri, Sep 3, 2010 at 1:29 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> sooo.... taking a wild guess, here: if you were to parse the .idx file
>> and extract the list of object-refs, and then pass that to "git
>> pack-objects --window=0 --delta=0", would you end up with the exact
>> same pack file, because you'd forced git pack-objects to only return
>> that specific list of object-refs?
>
> If you do this i.e. turn off delta compression, then the 615 MB
> repository above will turn itself into a multi-gigabyte pack!

 sorry nicolas, i believe you may have misunderstood.  first obtain
.idx which will return a delta-compressed list of objects, yes?  then
use --window=0 --delta=0 with exact same list, surely you will end up
with the exact same list which you gave to the *previous* command,
yes?

$ git pack-objects
>> .pack and .idx
$ mv .pack .pack2
$ extract_pack_objects_from_idx.sh .idx > foo
$ git pack-objects --window=0 --delta=0 < foo
$ diff .pack .pack2

so no, of _course_ not just ask --window=0 --delta=0 for the very
first run: if that's what i'd said, that would indeed be dumb.

l.
