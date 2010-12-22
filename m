From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] attr.c: Use ALLOC_GROW instead of alloc_nr and xrealloc.
Date: Tue, 21 Dec 2010 23:04:35 -0200
Message-ID: <AANLkTinw-GeFp5BnBUK02_YU8=XoUw1uHprSg1Hja0sh@mail.gmail.com>
References: <3c6870c390110bd1bf5c5f59a99928afc86cf188.1292978127.git.tfransosi@gmail.com>
	<7v1v5a7hc4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 02:04:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVD8G-0002mU-1E
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 02:04:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab0LVBEh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 20:04:37 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:35614 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0LVBEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 20:04:37 -0500
Received: by bwz16 with SMTP id 16so5240024bwz.4
        for <git@vger.kernel.org>; Tue, 21 Dec 2010 17:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=n5mcy5Ub1xl3vz4ga67dICGn1DuJWnA+aikUoB7o+WE=;
        b=aAqDXrV3VLAmwTUnRB3Z/bUW9tJZuIVgyY8Z3eS+fx7OlC2oCNL3M1wIaK0Th86+rI
         R0BDvt5Rl15avstqRbWW9QYH2cYwYF+y1hmmK0mrMBMMNroXLZHnZpvORSWRIIk014G+
         JtwDTBRpJ0oB39BiTR8hVch9fZR/I7J+2PvFw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=VwLE/mh0riQKQ3sKCQq1wW/Kh1nXxKd5jzm/6hbjvyo4HE8OxqEyU+1VOriH4P3ZG9
         OfO9FM6BonCrpXK7vLFd32/MOm2IPVvwCTbWE4hTGoU/PZXyTJhpiiET5Md1oazz0Kv+
         si+Um1tzYfAedppnrpG0osEuMUSNCi9Cnsrlg=
Received: by 10.204.140.208 with SMTP id j16mr5346690bku.151.1292979875783;
 Tue, 21 Dec 2010 17:04:35 -0800 (PST)
Received: by 10.204.141.82 with HTTP; Tue, 21 Dec 2010 17:04:35 -0800 (PST)
In-Reply-To: <7v1v5a7hc4.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164065>

On Tue, Dec 21, 2010 at 10:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Instead of trickling these down, can you give a single patch to convert
> the remaining ones you have been finding with "git grep -e alloc_nr"?
>

$ git grep -w alloc_nr | grep -v cache.h | wc -l

Sorry, but I wouldn't feel comfortable fixing 19 files now. At least
not exactly now. Perhaps on the weekend.
