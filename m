From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] rerere.txt: Document forget subcommand
Date: Tue, 15 Jun 2010 12:45:19 -0400
Message-ID: <AANLkTinfDixTH_l_1quVg68oz4E0AeuuyyOAVrJ2liVz@mail.gmail.com>
References: <AANLkTik50ayTQUnft4oD0Paqf-AuFWxGNdx_zZlHKFPg@mail.gmail.com>
	<ebd2b2b5bb3352c6204f181416a7a521f8c6abf7.1276582759.git.git@drmicha.warpmail.net>
	<7vr5k86ylg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 15 18:45:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OOZGT-0006TA-IC
	for gcvg-git-2@lo.gmane.org; Tue, 15 Jun 2010 18:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab0FOQpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jun 2010 12:45:24 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:60525 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751643Ab0FOQpU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jun 2010 12:45:20 -0400
Received: by iwn9 with SMTP id 9so4705057iwn.19
        for <git@vger.kernel.org>; Tue, 15 Jun 2010 09:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Ff/HAnufRiwxcdtnze9bhuFScVVJGEUhTlRinJjE5gE=;
        b=BFwmzt6uQeVbh5YEgutv2kJ2ustgE0Ra6Ruk8BgjeR31AgaZoYeo9LA5cmo2LSwDRX
         H93aEoxKzHEdHotDXeRBUdTSU2pck87lGymYUrmFEX2JuNiVJCEuJHYTYWs1V8mD2uAL
         uOfBiUk1EUZIDqXNJgIX2GIDdYvsKVnKXHNEs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iToMztyctIfcFk7z2On75AVWo7Kh32Jark8HVNXiJ5/LSt3ZaUX+EZDzYDXkmz9dRM
         AyyYnOwlr34QTn8WZk/I5GMY2n/I3tsDbwgQfndXOHKjfjx/COuPMvGISHwUaUvlkbKn
         cU1etkWG7GiLJ3FVtQo+KZ5E2/zeJJfOBaBLE=
Received: by 10.231.59.9 with SMTP id j9mr8480715ibh.31.1276620319784; Tue, 15 
	Jun 2010 09:45:19 -0700 (PDT)
Received: by 10.231.120.19 with HTTP; Tue, 15 Jun 2010 09:45:19 -0700 (PDT)
In-Reply-To: <7vr5k86ylg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149206>

On Tue, Jun 15, 2010 at 12:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> +'forget' <pathspec>::
>> +
>> +This resets the conflict resolutions which rerere has recorded for <pathspec>.
>> +
>
> This description is not _incorrect_ per-se, but it does not convey one
> important aspect of the subcommand; unlike "clear" and "gc", "forget" only
> works in the context of the _current_ conflict resolution, just like
> "diff" and "status".
>
> Perhaps s/for <pathspec>/for the current conflict in <pathspec>/ would be
> a sufficient improvement?

Also, pathspec is optional.

j.
