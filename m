From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 18:37:01 -0500
Message-ID: <CAMP44s1MZPJ3ei0YmDLosqKam4De+ofefaaf6R_4PSzVBrg1Yg@mail.gmail.com>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
	<7vzjvxfck2.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
	<7vbo8dfbbr.fsf@alter.siamese.dyndns.org>
	<CAMP44s0u0WPNneM-GoiqCkWTC-CT_Xa2z3on=smRiFJdd9ffeQ@mail.gmail.com>
	<7v38tpfa7u.fsf@alter.siamese.dyndns.org>
	<CAMP44s32KkJY3OxifDEmqp0ZkhQiRQCVwxYvSNGgqTnwC3DLEw@mail.gmail.com>
	<7vmwrxdtoh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 15 01:37:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcOmN-0005uY-IP
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 01:37:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538Ab3ENXhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 19:37:05 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:35298 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab3ENXhE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 19:37:04 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so519807lab.8
        for <git@vger.kernel.org>; Tue, 14 May 2013 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=dt+cr4gA8YQtykxnLK5foJRG5Stxe02qYuHrdkALH3o=;
        b=Ajr1lG42zzCpFe+5i/0uzDbHqmg/UJZW2BCwv5WyqaItyWYF1J/eoXXD7hDjUH8/M+
         94Ea6ULFpwFaLwavJScB2hqm3REAvQDUzR6wFsX+Ekdx5qAwdWWNbf3YxenIhAFq06wk
         DxaiaDfUG5uaXPuNvlvMEIpBxU/ueUobHtTJxqNiJmLvSmPuAKq3QJQs+MSgUbaNRGdk
         qRQRqPeW18QgSWtb8nEzVR42BEgnFrNK0IzvYdZBoPULJIZYBqufIP8X/ENRyt4qwdVG
         xpS7cUV8IJQLp057/SoMMCjlwsptD3jjV2YvggzxzM58AQ6jfDj+mwazmebpquNnDf/I
         alzw==
X-Received: by 10.112.63.169 with SMTP id h9mr1620620lbs.135.1368574621945;
 Tue, 14 May 2013 16:37:01 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 14 May 2013 16:37:01 -0700 (PDT)
In-Reply-To: <7vmwrxdtoh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224373>

On Tue, May 14, 2013 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> ... After all, this is in the contrib area,
>> so if there's a time for a possible future maintainer of a core part
>> of git to make mistakes, it would be now.
>
> That sounds reasonable.
>
> Incidentally, before I had to stop working in order to respond to
> your endless arguments, I already queued the 8 patches to 'master'
> (also remote-bzr one is in below that).

Cool. But FTR, the "endless arguments" come from both sides.

> I had no time checking other topics in flight nor merging the result
> up to 'next' and 'pu' yet, and it will take a while for the result
> to be published, but we'll see these in 1.8.3.

Well, the priority is 1.8.3.

Cheers.

-- 
Felipe Contreras
