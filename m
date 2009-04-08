From: Ping Yin <pkufranky@gmail.com>
Subject: Re: Any way to edit the file in index directly?
Date: Wed, 8 Apr 2009 10:27:57 +0800
Message-ID: <46dff0320904071927l16d54c8bv9c219e681cc96bb2@mail.gmail.com>
References: <46dff0320904071803k68fddff4j226760392e0c5bcc@mail.gmail.com>
	 <20090408021041.GB18244@coredump.intra.peff.net>
	 <20090408021620.GC18244@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 08 04:30:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrNYS-0007Wp-Dw
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 04:30:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760749AbZDHC17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Apr 2009 22:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759014AbZDHC17
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Apr 2009 22:27:59 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:19144 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756852AbZDHC16 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Apr 2009 22:27:58 -0400
Received: by rv-out-0506.google.com with SMTP id f9so3035485rvb.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2009 19:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=trg0/F/VBf4LLpr1uyRb/wNvxiRC3FtmattPkHIJ9gg=;
        b=WNxeyuYe5ROt2zlkJULABiz7NmIN0VwPp4qUfPUxyJGmmseTH47mMwbdETUXMiiF2E
         c3bg4lrBTHlVlZLgakYTBQUTsD8J+pPckPcYOCgPQOe446z/4Zs6Z14NXawBR8Fi1hyx
         o7S3NP4vijUAKwB8uPTPmhvOiFVyNOn7KBkLU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fwn8Fb0n33HGMDp3CD1wZYZyvR53S2ev6KTOTEsQktiAo6y0O1ycVHbaGwGz5s32WD
         KFyGsTAWOpz6tzHZQLivX98J3DClAOsmQ8ShTvJXOcMwmtlR29BHCGHoLK/r1/sD6WvX
         tLT8fvdvArFjq4PVm6h5UGUOHuyDKhjXy0rJw=
Received: by 10.115.58.1 with SMTP id l1mr426122wak.191.1239157677199; Tue, 07 
	Apr 2009 19:27:57 -0700 (PDT)
In-Reply-To: <20090408021620.GC18244@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116022>

Ping Yin



On Wed, Apr 8, 2009 at 10:16 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 07, 2009 at 10:10:41PM -0400, Jeff King wrote:
>
>> On Wed, Apr 08, 2009 at 09:03:03AM +0800, Ping Yin wrote:
>>
>> > There seems to be a patch for this ( add -e?), but i forget where =
to
>> > find it.
>>
>> "add -p" has an "e"dit option for editing the patch. I don't recall =
any
>> way of directly editing the content.
>

> "add -p" has an "e"dit option for editing the patch. I don't recall a=
ny
> way of directly editing the content.

Sometimes by 'add -p', i can't get what i want (the patch will fail to
apply when exiting editor). And with 'add -p', i can't get a global
view of all changes together

> I'm not sure what you mean by "alongside".

By "aloneside" i mean i can open the index and worktree file in diff
mode side by side for easily editing.

> Hmm, actually maybe you are thinking of:
>
> =C2=A0http://article.gmane.org/gmane.comp.version-control.git/103389
>
> which I even reviewed, but it doesn't seem to have gone anywhere afte=
r
> that.
>

Thanks, That's what i want.
