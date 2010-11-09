From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: first para of man gitignore should refer to 'git rm --cached'
Date: Wed, 10 Nov 2010 00:50:21 +0530
Message-ID: <AANLkTimwNtih94GENv=RqTCYtTWC7koLV_=WTX-B3MDu@mail.gmail.com>
References: <AANLkTim=QCcJDb0600Je-jePvXSXfFMe7FAQ0WMhZKn7@mail.gmail.com>
	<20101107191425.GA32302@kytes>
	<AANLkTinznLY3M4z7k-WeeFhGSR1xWHXj_zOrwMvZDfLQ@mail.gmail.com>
	<7vbp5zpo2d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 20:20:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFtkB-0000Hp-9H
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 20:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753997Ab0KITU1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 14:20:27 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:55296 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925Ab0KITUW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 14:20:22 -0500
Received: by ewy7 with SMTP id 7so3825066ewy.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=sjzY3RTmxHSz9MzASNSo5/Waz30jUKuL6yV3eVmQhno=;
        b=pH9722T2KM/fcb6E9974pxjlg4a0Ec72swp2SkMVSkIgfKS21GP7MHavjzax9W+oBY
         UC1G/0xKfHjQrycWZTDE3A7krQfCY6XQkOQYYlMI9kO74ll4o5ulXH91nVv22+IDT0cG
         KicThuPMEi1p3RwkjDAtmsLEbDjz5cpi9FF00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=g63YlzylAW1MaRGUSS2+GBbZimTwc59PUFDQYRZcnXPCbjTNgOXZfcItPPY7Rnv4jp
         UFikVSi19+6G0A1UaODJrZbyBf337qDBuu221CIWSfcE0wnqG2AbE4JPkpTBKB2aBDF5
         JeOEIlbiLPdQhtYV+lSZqdXOu6hxfzf6shJwg=
Received: by 10.213.28.193 with SMTP id n1mr4005425ebc.16.1289330421488; Tue,
 09 Nov 2010 11:20:21 -0800 (PST)
Received: by 10.213.102.6 with HTTP; Tue, 9 Nov 2010 11:20:21 -0800 (PST)
In-Reply-To: <7vbp5zpo2d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161066>

On Tue, Nov 9, 2010 at 1:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>> I'm just saying that ignoring uncommitted changes to already tracked
>> files is *not* the most common question I see when it comes to
>> gitignore,...
>
> I actually think it is much more commonly asked around here than "I added
> paths that I do not want by mistake and I mistakenly thought adding it to
> gitignore would make git forget it".

I'm surprised.  That is something only advanced users are likely to
need, while the one I mentioned would appear to be a much more
neophyte mistake.

Perhaps it's the difference between the folks that come to #git and
those that come to the mailing list.

But case closed I guess...
