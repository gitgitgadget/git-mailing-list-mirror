From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Coping with the pull-before-you-push model
Date: Mon, 13 Sep 2010 22:59:54 -0700
Message-ID: <AANLkTik_9q--ZkwXLFwWDWP5CM5jN1ynqtFgezuApp+A@mail.gmail.com>
References: <4C8866F9.1040705@workspacewhiz.com> <AANLkTikY55ZJvSTqyFKLqwABqnJZuODz3yrc7CFvQf0K@mail.gmail.com>
 <4C88F2A9.2080306@workspacewhiz.com> <AANLkTikdV3W1d7uNokKRRiT4FeznL1uM=Y9SQLDqgAic@mail.gmail.com>
 <20100910141527.GA6936@sigill.intra.peff.net> <4C8EFE62.7080908@workspacewhiz.com>
 <20100914052451.GA15839@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 08:00:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvOZH-0006mr-3t
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 08:00:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab0INGA1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 02:00:27 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61677 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab0INGA0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 02:00:26 -0400
Received: by wwd20 with SMTP id 20so818031wwd.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2010 23:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=TGjvOGUQrXmQl8Iuf6nRuPcpqFFL1S04rs+dMQPOeNE=;
        b=KBT8hsh0hcqOxiYAhAU6tRMPh6EagyHKGfseLamVZtB7x0Yif7tInSVoGHx+FBBFuZ
         Mpl0s5MCBEwv73VC0DpyzwRvp9p5Doidterp+koSC5WIRlaGBQ0/7hGvOsTSzRQMHxKe
         Rkm0oqzv4F5SCCSV2WzBpomMJ+Y55RZzT1Cbs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Yqj1aIny9oMcocpUs2y6yzWbgBoX1OQHaGRvYEx7WHrlgY1NUHt833UaUNpM/yQRKT
         j4xtmkWOy0z3x8D9TTEk55l2TNcHJ8VAU263iH/pgEPu9ixD1zr/Pl/t9+D7aEX14/4B
         X6knAXzyuUXqIjXwPUeWedLlAjTxZJA8fpY40=
Received: by 10.216.23.4 with SMTP id u4mr5139297weu.96.1284444015318; Mon, 13
 Sep 2010 23:00:15 -0700 (PDT)
Received: by 10.216.49.72 with HTTP; Mon, 13 Sep 2010 22:59:54 -0700 (PDT)
In-Reply-To: <20100914052451.GA15839@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156163>

On Mon, Sep 13, 2010 at 10:24 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 13, 2010 at 10:47:30PM -0600, Joshua Jensen wrote:
>> >Bear in mind that you can still shift to a maintainer model, but ke=
ep
>> >the maintainer automated. That is, you can queue up "to-pull" heads=
, and
>> >then have an automated process pull them one by one and do some bas=
ic QA
>> >(does it merge, does it build, does it pass automated tests, etc). =
Which
>> >is not that different from what many shops do in the non-maintainer
>> >model, except that when you break the build, the maintainer process
>> >notices _before_ publishing the merged tip, so everybody won't try =
to
>> >build on your broken crap.
>>
>> Do you know of any existing software that does this? =A0This may be
>> ideal in the short term.
>
> I think that Avery Pennarun's gitbuilder may do what you want:
>
> =A0http://github.com/apenwarr/gitbuilder/
>
> but I've never used it.

gitbuilder doesn't do this.

However, it does let you automatically do user-defined things for each
branch, and it stores the result for each one.  So it would be a
pretty short trip from there to auto-merging when a branch is ready.

Have fun,

Avery
