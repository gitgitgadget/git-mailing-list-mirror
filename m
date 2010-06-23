From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: potential improvement to 'git log' with a range
Date: Wed, 23 Jun 2010 16:45:07 -0400
Message-ID: <AANLkTikcCQD9rFDscJNpLaRtX64occrXNHmrB-FdW69b@mail.gmail.com>
References: <w2j3abd05a91004091624mb2836ff4v118a1ae9ac5ca6e7@mail.gmail.com>
	<i2kfabb9a1e1004091633nc70f2f19hd16ea9704f0933b0@mail.gmail.com>
	<n2t3abd05a91004091713s4d081106qd74419425b25e8e@mail.gmail.com>
	<alpine.LFD.2.00.1004091807220.3558@i5.linux-foundation.org>
	<AANLkTinPrObdQh1vZLo0tlq2bZn7BXKvHWLktI2pR5LY@mail.gmail.com>
	<7vmxulebr2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Aghiles <aghilesk@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 23 22:45:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORWos-0005iY-Fz
	for gcvg-git-2@lo.gmane.org; Wed, 23 Jun 2010 22:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332Ab0FWUpK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jun 2010 16:45:10 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:34163 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab0FWUpI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jun 2010 16:45:08 -0400
Received: by iwn41 with SMTP id 41so48269iwn.19
        for <git@vger.kernel.org>; Wed, 23 Jun 2010 13:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=r6IAMazXDq3C/1PV1AmO1bLqrHfzSmLfnBp3WjeHOUw=;
        b=qdN1UG1AqlUWA3zZp7uw9w8Crbptu2iOO+U2hd9jImYT+xp8pl6G6WC0Lgw4BoWkBh
         91Y/1muZ2Gxqz1KleDGRm/AqM3RsME6Vneht0zCoGmHicKZsxqiXvl2luAzEkWOgQKZW
         4VAPUIdvebXPB9PiPK4n7xNHd/ASlNL1M0TfY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XgddZ7PaUtDlSZDc19eTF+HZc9imGySkuin/f82a77i9KavRwWQiHbKjHEkLJ3wgLS
         ZMCV8Sm3e8D2oV+I1LXgRpbBnvj8QEiHJOvlKR6jDCukcNsF8XI2GTAa5j2YFmw7D+Vx
         aLd3LN+WusnCWul/5UPVioeT8javb6/cxMP3Q=
Received: by 10.42.5.145 with SMTP id 17mr3169924icw.31.1277325908024; Wed, 23 
	Jun 2010 13:45:08 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Wed, 23 Jun 2010 13:45:07 -0700 (PDT)
In-Reply-To: <7vmxulebr2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149548>

On Wed, Jun 23, 2010 at 4:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> Speaking of which, I'd love a switch to "git show $merge_commit" which
>> does "git log $merge_commit^..$merge_commit^2" but I've been too lazy
>> to write it. 9/10 times that I use .., it's in this context. :-)
>
> Doesn't "git show -p --first-parent $merge" work for you?

I don't understand at all. Isn't -p redundant with git show? And how
is --first-parent $merge equivalent to
$merge_commit^..$merge_commit^2? I literally want a list of all the
commits brought in by the merge.

Confusedly yours,

j.
