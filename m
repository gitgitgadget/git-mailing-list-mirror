From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Sun, 18 Apr 2010 20:44:13 +0200
Message-ID: <m2pfabb9a1e1004181144x10f6a0f1x2e55bc025aba781b@mail.gmail.com>
References: <1271552047-sup-9523@kytes> <20100418025940.GA2249@progeny.tock> 
	<1271566767-sup-7167@kytes> <7vk4s4wqo5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:44:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZU0-0006lD-4z
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab0DRSof (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:44:35 -0400
Received: from mail-bw0-f225.google.com ([209.85.218.225]:63875 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751197Ab0DRSoe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:44:34 -0400
Received: by bwz25 with SMTP id 25so4737023bwz.28
        for <git@vger.kernel.org>; Sun, 18 Apr 2010 11:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=qxMO/rDgvMLaRddyUMhiBumOm5hqL0YeealjkgRKpK4=;
        b=X1RhmfzanaywHaJQMb8frL3/4OudwfsEsTwslfydsLwtrsHPDIFrAx5DsUtl35exIi
         hl3VMaY0UAdwDhVdRmAOf/2DXISRLzLTHTfrJY5jJ7p25wgMxjowC6i5TaElRNy4cLxS
         aAqeQ7+fFEJENIdbLq/jUjHodW0aemyPXcCVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=hfJu4cQZjjDdAW+TffxdsfcEbKAbOCzv2rJLrUgT2oK336gJuX9bfD6wUmAtyznR2v
         b2tsIwf4UZCgMk85EtKhiWrnvC0FJIfwzgI6JLp3Oh5ffmBDYQVVbWJalQMuuFk7976l
         eXZpPLmRrxo+dh+Hp63IcNZDMHUTHqiVr1KGw=
Received: by 10.103.168.14 with HTTP; Sun, 18 Apr 2010 11:44:13 -0700 (PDT)
In-Reply-To: <7vk4s4wqo5.fsf@alter.siamese.dyndns.org>
Received: by 10.102.254.24 with SMTP id b24mr2859383mui.5.1271616273081; Sun, 
	18 Apr 2010 11:44:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145236>

Heya,

On Sun, Apr 18, 2010 at 20:39, Junio C Hamano <gitster@pobox.com> wrote:
> Except that I'll further move rsync:// lower so that the curl family can
> stay together, both in the list (that appeared in your "fixup") and in the
> introductory text.

With that I think the entire series can be:

Acked-by: Sverre Rabbelier <srabbelier@gmail.com>

-- 
Cheers,

Sverre Rabbelier
