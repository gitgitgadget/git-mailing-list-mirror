From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: Gittorent .. avahi ?
Date: Tue, 3 Apr 2007 14:25:26 -0400
Message-ID: <2c6b72b30704031125o4335aeefg88ccee163fa27142@mail.gmail.com>
References: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Srijak Rijal" <srijak@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 20:26:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYni8-0000Nf-E8
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 20:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbXDCSZ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 14:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161093AbXDCSZ5
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 14:25:57 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:21947 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161095AbXDCSZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 14:25:56 -0400
Received: by wx-out-0506.google.com with SMTP id h31so1888485wxd
        for <git@vger.kernel.org>; Tue, 03 Apr 2007 11:25:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rIj72SwntFcV6axLGiVSRBWeJXQ1LaGldTyuvwFmtiyz08Z/HyebMJMlRunB7rQKJ1wMkglAm8FEi1iwyLY6ezsvdO7T4Jud+oT45CcQLAys0dPnA+pyB1E2AOGFah5Abkk0oPVd748th8Xk+Htxdp0ckJb5bREwIoB2Bx+rixM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G1b9URdxt9jRi3s+5tcNGy/lEywZ/ou3umalVjy/yclzbW37mmMO0dLmxNpiOXxg6dBuqvVPJELoz5g+oy98+1gcJ8fwb4kGVgkSKkOyf07HqVUgXE/BK7WR0HIbrmniMrzZ2D2n6+u6faKh/gyMboJUCnsmo5EeVhAONbzxn1c=
Received: by 10.114.126.1 with SMTP id y1mr2388352wac.1175624733922;
        Tue, 03 Apr 2007 11:25:33 -0700 (PDT)
Received: by 10.114.25.20 with HTTP; Tue, 3 Apr 2007 11:25:26 -0700 (PDT)
In-Reply-To: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43636>

Hello Srijak,

On 4/1/07, Srijak Rijal <srijak@gmail.com> wrote:
>  I hope to be able to implement the gittorrent client/ tracker during
> GoogleSoc (if chosen :) ). I have been reading up on various git docs
> and listserv messages to figure out what features I want in it in
> addition to the basics. I have been concentrating especially on how to
> minimise tracker load.

While the tracker is a very interesting part of GitTorrent, because it
has a lot of responsibility for 'advertising' new changes, I think the
client, in itself, would be a hard and big enough project. And as Sam
said the tracker can be reduced to a simple static file that is
regularly updated by a cron job or something like that. On the other
hand, having a tracker might ease the task of implementing a client.
Hmm, chickens and eggs... ;)

I made a report about GitTorrent from which you might be able to
get some info from or at least some overall motivations and
considerations. However, it is for the much simpler and stupid
'initial' proposal, before Sam stepped in and made especially the
core of the peer wire protocol more scalable. So 'caveat emptor'
(this especially goes for the more Git related parts).

You can find it at:

  http://jonas.nitro.dk/tmp/foo/gittorrent.html/node38.html

and the whole report at

  http://jonas.nitro.dk/tmp/foo/gittorrent.pdf

I really hope your project gets approved.
-- 
Jonas Fonseca (fonseca@diku.dk)
