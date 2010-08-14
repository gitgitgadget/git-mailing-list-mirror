From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 3/9] stash: introduce is_stash_ref and assert_stash_ref functions.
Date: Sat, 14 Aug 2010 10:26:36 +1000
Message-ID: <AANLkTi=wZSjUvK1SV91xwStb3Pr0u6ytMsaBFN42N2dR@mail.gmail.com>
References: <1281242771-24764-1-git-send-email-jon.seymour@gmail.com>
	<1281398688-21008-4-git-send-email-jon.seymour@gmail.com>
	<7v39ujnxpa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, j6t@kdbg.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 02:26:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ok4aB-0007RD-DX
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 02:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932266Ab0HNA0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Aug 2010 20:26:38 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37410 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756459Ab0HNA0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Aug 2010 20:26:37 -0400
Received: by qyk29 with SMTP id 29so220057qyk.19
        for <git@vger.kernel.org>; Fri, 13 Aug 2010 17:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=n2TwNU1tLYq5Nz1x9jgvUYHELb0sEG9rgh9irvuUIPA=;
        b=RDcom7R/ZsQy//o6Ust+9sEmqKPfH3voGj5XcDZ4MNajgF/lozLAbu5R+zkgUmELuc
         E5U3EAp+MJ4BNuDs0nsuktraXXS6Bw8I9RD0HaSkIhbDA9klBuVfgVo/t9MBvGKZeR2y
         90502EWCRNlHPQZyQeh5XFxOtx2fhBGEhdYuQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=SNI4pCRsiFo5soFQ2Sw+7T1+zgFXjZMDxnkMjdZSZzfQ/8kc0bGwyqxPg9qKlUe9ul
         bcMifqrw3XuT7QjFSam4SUw2E/NH4YYalN6q7Xw4w//Of7nU8RPKy2ysqjyTNzstp/Z+
         AFI/MUu6hRfQvBeAkaDw7W8SpMX8ETteaT+9M=
Received: by 10.229.81.85 with SMTP id w21mr1743609qck.148.1281745596536; Fri,
 13 Aug 2010 17:26:36 -0700 (PDT)
Received: by 10.229.231.199 with HTTP; Fri, 13 Aug 2010 17:26:36 -0700 (PDT)
In-Reply-To: <7v39ujnxpa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153535>

| Apologies - missed the list in my first reply.


On Fri, Aug 13, 2010 at 10:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
> I have to wonder what these functions would do when given more than one
> args, but I cannot (yet) see the users of this function, which may be
> doing their own sanity checking to avoid that situation, so...
>
>

I did wonder about that myself, but with insufficient curiosity to
actually write a test. I'll fix...

jon.
