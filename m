From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] git-verify-pack.txt: fix inconsistent spelling of "packfile"
Date: Wed, 20 May 2015 12:22:15 -0700
Message-ID: <xmqqmw0znjfc.fsf@gitster.dls.corp.google.com>
References: <1431845814-2541-1-git-send-email-ps@pks.im>
	<xmqqwq04745w.fsf@gitster.dls.corp.google.com>
	<20150519222427.GA994@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 20 21:22:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv9ZP-000217-F1
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 21:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbbETTWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 15:22:18 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36817 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbbETTWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 15:22:17 -0400
Received: by igbpi8 with SMTP id pi8so110966016igb.1
        for <git@vger.kernel.org>; Wed, 20 May 2015 12:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=9F/f9VFL6crT+DENy9V8rr5w3AIOE2UKefRJZYZ0J68=;
        b=cQtyJ2hQ9HsYvBbgUe87FG505HzGm5z2LUAJ3j0FsAkitX83KH4ONW4UXYzYH5QvC1
         icBM7DtMwOrdL08dQH35UjStyyd/wfON+Y0fn0vMZVNOrULwDPDl/MZXk1D6cAkI8H1a
         /KxQ45Jdbm8TumXFHOaEN5dDTW9ziA21s/+xBGkxGF+p34rgzhU1ezoYP47v5fECtJqo
         uTQI4933Qp5rTlJ/QQYYgMS5FmxIriMWZgk+7tU7UiW+V/lEjqKrOZalxoqvwa8/15Ch
         85hY3UIiiDVEu/6ck3zXKVq331Y6geJxe9p5sdh72UGL7eDxB8Zf4eQ9v5SLP0jnnbTb
         M04A==
X-Received: by 10.50.13.67 with SMTP id f3mr30164804igc.12.1432149736660;
        Wed, 20 May 2015 12:22:16 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id a74sm13006665ioe.36.2015.05.20.12.22.15
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 May 2015 12:22:16 -0700 (PDT)
In-Reply-To: <20150519222427.GA994@peff.net> (Jeff King's message of "Tue, 19
	May 2015 18:24:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269495>

Jeff King <peff@peff.net> writes:

> On Tue, May 19, 2015 at 12:34:03PM -0700, Junio C Hamano wrote:
>
>> A quick "git grep packfile" vs "git grep pack-file" inside
>> Documentation/ directory indicates that we seem to use 'packfile'
>> primarily in the lower-level technical documents that are not
>> end-user facing.  Almost half of them are in the release notes
>> that we won't bother "fixing", so it might make sense to go the
>> other way around, consistently using "pack-file" that may be more
>> familiar to end-users.
>> 
>> What do others think?
>
> If I saw "pack-file" (outside of this discussion) I would think it was
> wrong. That's just my opinion, of course.

OK, then let's go with these three patches.

Thanks for sanity checking.
