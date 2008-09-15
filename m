From: "Anatol Pomozov" <anatol.pomozov@gmail.com>
Subject: Re: Diff-tree does not work for initial commit
Date: Mon, 15 Sep 2008 14:48:15 -0700
Message-ID: <3665a1a00809151448l5a4449e4w3caa9986bc5dd26b@mail.gmail.com>
References: <3665a1a00809151301p7d8e6387g3cacfb879b45da2f@mail.gmail.com>
	 <48CECA42.1050209@drmicha.warpmail.net>
	 <7vprn59lkd.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Michael J Gruber" <git@drmicha.warpmail.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 23:49:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfLwi-0005Q9-Vq
	for gcvg-git-2@gmane.org; Mon, 15 Sep 2008 23:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754375AbYIOVsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2008 17:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbYIOVsR
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Sep 2008 17:48:17 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:20034 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754087AbYIOVsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2008 17:48:16 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1493491waf.23
        for <git@vger.kernel.org>; Mon, 15 Sep 2008 14:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gWsqf+thMEtALsswKE/7l8a30tbwwtEONoZfO2G37kE=;
        b=SAKr/EQro6uQfM+DvCvCyliC0OaCICT1Gxmh+qo0KgXKirhDw8O/wiNSIV8ixoTQAQ
         OI5NNrEXP7TuoUn9SvPvnASKWnDKhW6VvtAeNwf3w8vB5qbJf/hetubPKEAPl0Q4Pkh4
         8N0DQkRWMQwteGKbgd909bqoOyFH5ORgRm8O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=rUS+X6wRCNUBHyOVgULciWvW6cfja0JHiKUXUN0RwHHQPNmZBjk6Qdg6l4p2p3OQBV
         7wGvQBe5O+a6azQaSsn44vDZVOLJzm89LwSW3nWaxrzVd7be6Wa+Aoarwubk3QuuI3EF
         yCu+B5UPByfZduBmlzG6cEt0HIq0CZUqo4Pqk=
Received: by 10.114.135.1 with SMTP id i1mr146890wad.5.1221515295798;
        Mon, 15 Sep 2008 14:48:15 -0700 (PDT)
Received: by 10.115.78.6 with HTTP; Mon, 15 Sep 2008 14:48:15 -0700 (PDT)
In-Reply-To: <7vprn59lkd.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95947>

On Mon, Sep 15, 2008 at 1:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The initial commit has no parent, so diff-tree does not know which tree
>> to compare to.
>
> --root?

Oops my bad.

I overlooked this part of the manual. Thanks Junio.

Taking back my words about bug.

-- 
anatol
