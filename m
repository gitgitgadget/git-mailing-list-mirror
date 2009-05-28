From: Eric Raible <raible@gmail.com>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 22:52:37 -0700
Message-ID: <279b37b20905272252i3d98b6bv698ff636d61ee058@mail.gmail.com>
References: <m3y6siboij.fsf@localhost.localdomain>
	 <alpine.LFD.2.01.0905270942580.3435@localhost.localdomain>
	 <alpine.LFD.2.00.0905271312220.3906@xanadu.home>
	 <20090527215314.GA10362@coredump.intra.peff.net>
	 <alpine.LFD.2.01.0905271457310.3435@localhost.localdomain>
	 <f95910c20905271609u63d04965oa38b8af34d7704c1@mail.gmail.com>
	 <alpine.LFD.2.01.0905271825520.3435@localhost.localdomain>
	 <alpine.LFD.2.00.0905272312370.3906@xanadu.home>
	 <loom.20090528T041831-21@post.gmane.org>
	 <20090528043019.GA30527@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 28 07:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9YXn-0007ok-Ai
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 07:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759153AbZE1Fwh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 May 2009 01:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758574AbZE1Fwh
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 01:52:37 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:13605 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbZE1Fwg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 May 2009 01:52:36 -0400
Received: by qw-out-2122.google.com with SMTP id 5so3292451qwd.37
        for <git@vger.kernel.org>; Wed, 27 May 2009 22:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3LTKHLXGPGsivUH8CVQgfGPk8P4hUI/qVO/hkVMVSZg=;
        b=TDR7cvGjYSXNjhB7+Usx8qAsojgg4ORqEUvI6PDhol+YQMqkCAuc5LRLCAEvbjRn3C
         5S7Vl1Xt/hBEjeVChO5P6EZmXI9YKuYciAgKUg9u/5MCZD6ad0ef4qJQV4d0FbuM8x5K
         02ti6+UiLwMNv6Z/atP8+O40Aj/C+1bCoWaWo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jUnMbZx1b/F/lx7O5FUBjYFtnsPCDlA7SZIXPnHuhrjAOL8ZnPCCExv2qteZwQDOQr
         fwOCQJinrGYL7rPUOYCgVtAdkXcUxhVlZ4a/Hpm1hWlUQV9YrfyWrawhTNfxq05ncBgH
         VnW3D3GGuhzGiutqFJOeFS6Yx+ebMULwmkWaQ=
Received: by 10.220.77.79 with SMTP id f15mr1053396vck.2.1243489957271; Wed, 
	27 May 2009 22:52:37 -0700 (PDT)
In-Reply-To: <20090528043019.GA30527@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120151>

On Wed, May 27, 2009 at 9:30 PM, Shawn O. Pearce <spearce@spearce.org> =
wrote:
> Eric Raible <raible@gmail.com> wrote:
>> Nicolas Pitre <nico <at> cam.org> writes:
>> > On Wed, 27 May 2009, Linus Torvalds wrote:
>> >
>> > > +pack.packDeltaLimit::
>> > > + The default maximum size of objects that we try to delta.
>> >
>> > The option name feels a bit wrong here, like if it meant the max n=
umber
>> > of deltas in a pack. =A0Nothing better comes to my mind at the mom=
ent
>> > though.
>>
>> pack.maxDeltaSize sounds weird when said aloud.
>> How about pack.deltaMaxSize?
>
> That sounds like, how big should a delta be? =A0E.g. set it to 200
> and any delta instruction stream over 200 bytes would be discarded,
> causing the whole object to be stored instead. =A0Which is obviously
> somewhat silly, but that's the way I'd read that option...
>
> --
> Shawn.

You're right, that _is_ a strange color for the bike shed...
