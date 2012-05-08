From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Index format v5
Date: Tue, 8 May 2012 21:25:50 +0700
Message-ID: <CACsJy8CUC8AXYvDEH75NGC_r3HwLoaiq0qxn2EAC0Aq4VXVMag@mail.gmail.com>
References: <CALgYhfMKdbv8TiT4ALDSvD3pSXHEPLWHM09DxYnRmRdBWRjh8Q@mail.gmail.com>
 <4FA7E703.7040408@alum.mit.edu> <20120508141137.GA3937@tgummerer.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	trast@student.ethz.ch, gitster@pobox.com, peff@peff.net,
	spearce@spearce.org, davidbarr@google.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 16:26:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRlMw-0005Oc-8t
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 16:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394Ab2EHO0W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 10:26:22 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:64728 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755233Ab2EHO0V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2012 10:26:21 -0400
Received: by wgbdr13 with SMTP id dr13so5976101wgb.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 07:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=U+a8UuFIQvAcGSrJRe7rs/HP6YV1esvQkVFRKJcqWt8=;
        b=ScLmLVeWJtMfrYBofLJkQmsU96eNHSTUFCXehrqlGzo8ERak+V0ERdJC+42fJXxXkN
         1BL8oXnM01nLgcq89psFya3vDZzviif+zmYpSPU9hZ8yjeCxbrOg/rRAkG/Sdeio9yOm
         xZklC1Y8vfhOybTD91KD4CyZ/Pz/+w0dDHhz6O/0KquivfJpq2KoLpFsj2b1L4fCq/NP
         c5fh2JXuzi6YR2RAEXRGOdqgLmeMJjkWaUFCvtU1MbiaE+94XJd12fUgYIJa8Sj0kE32
         9RXKtNXuYYA8Wq3DQvNRDxetGBJ7cFFt296+2mmA/mQC45+ZDbmwzKQQz7z4YxrJZn/K
         CRFQ==
Received: by 10.216.193.80 with SMTP id j58mr860330wen.96.1336487180293; Tue,
 08 May 2012 07:26:20 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Tue, 8 May 2012 07:25:50 -0700 (PDT)
In-Reply-To: <20120508141137.GA3937@tgummerer.surfnet.iacbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197369>

On Tue, May 8, 2012 at 9:11 PM, Thomas Gummerer <t.gummerer@gmail.com> =
wrote:
>> * "160-bit object name for the object that would result from writing
>> =C2=A0 this span of index as a tree." =C2=A0Is this always valid?
>
> No, this is only valid if the entry count is not -1. It's clarified
> now.

=2E.and..

> The entry_count in the index is only valid, if the cache-tree is vali=
d,
> which is not always the case.

I think your trees are the cache-trees already. For invalid
cache-trees, you can just use all-zero sha-1 as the indicator. Then
entry_count can go away.
--=20
Duy
