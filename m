From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH] help.c: Pull cmd_version out of this file.
Date: Wed, 27 Oct 2010 14:06:50 -0200
Message-ID: <AANLkTinxG-=EKeNH3--34Ya4w0E=i_bdmJ7iv2em8C+8@mail.gmail.com>
References: <2ae543604216146b742253584d8393c5e3179697.1283114573.git.tfransosi@gmail.com>
	<20100830023812.GA4010@burratino>
	<20100830024020.GB4010@burratino>
	<AANLkTimDjRz=JmiVn+ybQ5ewaj=7N5tp48fUArD5vG_H@mail.gmail.com>
	<7v1v9e803a.fsf@alter.siamese.dyndns.org>
	<AANLkTinHJHzcoFFjv-TaQ+DYVyqn46fqA802m8Lq5anp@mail.gmail.com>
	<20100902043500.GF29713@burratino>
	<7vvd6o14zz.fsf@alter.siamese.dyndns.org>
	<AANLkTimX2NhXGdK0vVMaw-Fm6fpg4i5pbOZGA8Cc-+ui@mail.gmail.com>
	<20101027151832.GA10614@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 27 18:07:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PB8Wh-0007q5-UO
	for gcvg-git-2@lo.gmane.org; Wed, 27 Oct 2010 18:07:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760894Ab0J0QGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Oct 2010 12:06:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51084 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758267Ab0J0QGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Oct 2010 12:06:52 -0400
Received: by bwz11 with SMTP id 11so724018bwz.19
        for <git@vger.kernel.org>; Wed, 27 Oct 2010 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=t1p01mzl5YNyDrAxNRykKDydUutY0LJ/7qJc83O9Lfk=;
        b=Ve/JlP07Trh2xE1OeMfdMFX9UmEdeKW3ksjkSXC0EtgB7Od2Im78EZvRVeBTnkfg6a
         oFRVMXgMqRLjJqsHpcEm2h0xfq0paxxHX2jzenVVNZGR15A3ptCgVhGRkqoTiB3Mqy4M
         JcyccND/JZ9EGm5s5caYz1aD93PF+LmTNBaSs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=lPi9RR9jGBn0lq8wfCyozRUgftWyypVlgCItbzuJhKrf/5zYUm7kEmnpzeBH0yxVnV
         WwBLSch1PSX6yJrMUVXGJBoNBPQNsxI8T0SjoFPJAGCsoGcE1nfekWHa+u8hxQIrxQN+
         wAC2nx5aulMe0OlWwH09etHyZDuenvZmIGV2E=
Received: by 10.204.102.78 with SMTP id f14mr937205bko.30.1288195610617; Wed,
 27 Oct 2010 09:06:50 -0700 (PDT)
Received: by 10.204.69.206 with HTTP; Wed, 27 Oct 2010 09:06:50 -0700 (PDT)
In-Reply-To: <20101027151832.GA10614@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160093>

On Wed, Oct 27, 2010 at 1:18 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Thiago Farina wrote:
>
>> What happened to this patch? I can't see it on any branch (master, pu, maint).
>
> I thought there was some discussion about another binary in
> /usr/lib/git-core being a bad thing?
>

I don't recall, why it's a bad thing?
