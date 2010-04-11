From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Take it easy on unallowed access to non-existent 
	repository
Date: Sun, 11 Apr 2010 19:57:53 +0200
Message-ID: <w2zfcaeb9bf1004111057m6062b984t40c62f25a8a9195a@mail.gmail.com>
References: <20100409001322.GB23501@coredump.intra.peff.net>
	 <1270983682-12215-1-git-send-email-pclouds@gmail.com>
	 <l2ifabb9a1e1004110845l7cc89b70y9878dad9e1537e8d@mail.gmail.com>
	 <y2tfcaeb9bf1004111049m9703af3bs3dc668ec29ae3136@mail.gmail.com>
	 <u2ifabb9a1e1004111052s12949555wa063f214d742e5ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 19:58:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O11Q0-0001tu-Ib
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 19:58:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706Ab0DKR54 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Apr 2010 13:57:56 -0400
Received: from mail-ew0-f220.google.com ([209.85.219.220]:47070 "EHLO
	mail-ew0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752639Ab0DKR5z (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Apr 2010 13:57:55 -0400
Received: by ewy20 with SMTP id 20so1716934ewy.1
        for <git@vger.kernel.org>; Sun, 11 Apr 2010 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=ApMbCdKPfynUEBaVrHX3lhgTo8RTQAfRk7UjFK8ia0I=;
        b=NirEYslASWJQgAVlVNnZLTzXlY7BjPuoqIpHXn0UWAR/ycvmZycKkPOScGpbL1NDMe
         xNZndLOf2HmAALyyEDzm//f5/bm2oUf6FPx9wqKfDcYrArDSV+EiDzLULRHuQXNA/Fd6
         0ATj+ffp1CyBgrxHR292t5oiKJkjwoEDpTQyQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=iqeIszygAsu6Le9VD0vCgOBCOU23PFZ22flk7TEH9b+hi1960cRMCpbCP/4oGcByoW
         hAtSOad2nodJ5KsiWqtWaH59h3vCakkHmn/GioA7B9t9csO3JpjHkJpFQipNtXkxpaKa
         5d1di2GjapJ5sLBEqA4qoFc582AIVpYun/5rQ=
Received: by 10.213.105.130 with HTTP; Sun, 11 Apr 2010 10:57:53 -0700 (PDT)
In-Reply-To: <u2ifabb9a1e1004111052s12949555wa063f214d742e5ec@mail.gmail.com>
Received: by 10.213.100.140 with SMTP id y12mr1907893ebn.11.1271008673547; 
	Sun, 11 Apr 2010 10:57:53 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144672>

On Sun, Apr 11, 2010 at 7:52 PM, Sverre Rabbelier <srabbelier@gmail.com> wrote:
> Heya,
>
> On Sun, Apr 11, 2010 at 19:49, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>> Gaah.. from a user point of view, correct. What do you suggest?
>
> Simple, add a reference to the "code":
>
> warning("broken repository setup code: early access to $GIT_DIR/config");

Thanks.
-- 
Duy
