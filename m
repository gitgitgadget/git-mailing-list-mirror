From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] Documentation: reset: describe new "--keep" option
Date: Mon, 8 Mar 2010 12:31:51 +0100
Message-ID: <c07716ae1003080331j16cc29d5j6f6c1d7e940d03b8@mail.gmail.com>
References: <20100305202537.25469.73470.chriscool@tuxfamily.org>
	 <20100306081034.GA4827@m62s10.vlinux.de>
	 <7v3a0b1afe.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Baumann <waste.manager@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 08 12:31:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NobBm-0001i8-L0
	for gcvg-git-2@lo.gmane.org; Mon, 08 Mar 2010 12:31:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225Ab0CHLby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Mar 2010 06:31:54 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:50491 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751043Ab0CHLbw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Mar 2010 06:31:52 -0500
Received: by fxm19 with SMTP id 19so6205464fxm.21
        for <git@vger.kernel.org>; Mon, 08 Mar 2010 03:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JtN3PC+gl/byVxKEbscSdzr8Mf3C2NX7rMYH9XBDgQ8=;
        b=heONEyy9muI9EAPyGB4BBSsFwb6Uft+EoDt3VGwIqnQWsPoHt19DxPqVVY/GJx5OVY
         CG2lfS4XnQ3fxxm0bzvNIr7EbYfBYT6yNnUbZ4VU2/sIpXXarzCVCWV+h8vWAZetMwvk
         t2HgDemlKE52YY/XB7KbV/lnEQ5sxUu+MFsKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d5UVgPzCic/Uf892FvEXrRFA35faZDDjRBXiQJcwyzluzHmioTuWjBBNBj3PsDuctU
         zY36h6Zgz4UICq8Ed/nygGtqofVGIKBMVb+z8j3uG+caQH9++GM76I0vJnUbzdIz7Dnc
         qI3AsTK6G5x3ivC034eBJnxajxWfcirwNzEIA=
Received: by 10.87.62.31 with SMTP id p31mr2466004fgk.21.1268047911231; Mon, 
	08 Mar 2010 03:31:51 -0800 (PST)
In-Reply-To: <7v3a0b1afe.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141761>

On Mon, Mar 8, 2010 at 9:31 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Peter Baumann <waste.manager@gmx.de> writes:
>
>> Huh? Keep changes (by not touching the worktree) and then aborting i=
f we
>> touch the worktree. Seems like a contradiction to me.
>
> Here is my try...
>
> =A0 =A0Reset the index to the given commit, keeping local changes in =
the working
> =A0 =A0tree since the current commit, while updating working tree fil=
es without
> =A0 =A0local changes to what appears in the given commit. =A0If a fil=
e that is
> =A0 =A0different between the current commit and the given commit has =
local
> =A0 =A0changes, reset is aborted.

I agree that it is better. I will post a patch with this change this
evening if you don't do it before.

Thanks,
Christian.
