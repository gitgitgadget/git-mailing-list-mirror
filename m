From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH GSoC 1/3] gitweb: Create Gitweb::Config module
Date: Thu, 3 Jun 2010 17:04:14 +0000
Message-ID: <AANLkTikNzhIhrjbgF88EKf_FhJ6p_tzXHi0MaD-EMiLl@mail.gmail.com>
References: <1275573356-21466-1-git-send-email-pavan.sss1991@gmail.com>
	<20100603152030.GD20775@machine.or.cz>
	<AANLkTikUmFA658jzd27cu1NmjJsV8T9Hkrd7z2WNY3R7@mail.gmail.com>
	<201006031859.39278.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Petr Baudis <pasky@suse.cz>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 19:10:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKDwE-00009x-Qo
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 19:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab0FCRKd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jun 2010 13:10:33 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49545 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637Ab0FCRKd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Jun 2010 13:10:33 -0400
Received: by gye5 with SMTP id 5so268104gye.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 10:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FiNLsbrbx8uJlu0cqZPu94ckfwYVMCTPtdppbnx9Uvk=;
        b=RfH+IBhY/y0h5vSRkCKoa1pYD43SS/XdG0G+hNmYNDZX4BaQ1GSqL1RD4z24OSvVVp
         pu0037CWqkFRYHOcfXOaifEGcUPSQUcDqwojZH2Jd1NgFLFcKDwJKRVrW/mPLU6Je+ZC
         J/XyKgcqwyTfSlg2GuNtJBl/+KTmXjjBUJ8iI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MUP4twJzqWo57fifpSbjjIzyklteedwAY7/3irn9sSQzxeBScVr0KAUcyVYTN7lsdR
         vKv3ImO9kkYEaNxJ39endBNgQwMpSeMsAPhev+xjgsGiugUSRgnhC8tDcyzs3+ovg2sn
         EMRzcHKqvSM8g1eUKUIu67bIG8/qa1Jhx5XX4=
Received: by 10.42.7.130 with SMTP id e2mr296807ice.3.1275584654247; Thu, 03 
	Jun 2010 10:04:14 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 3 Jun 2010 10:04:14 -0700 (PDT)
In-Reply-To: <201006031859.39278.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148349>

On Thu, Jun 3, 2010 at 16:59, Jakub Narebski <jnareb@gmail.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> On Thu, Jun 3, 2010 at 15:20, Petr Baudis <pasky@suse.cz> wrote:
>>> On Thu, Jun 03, 2010 at 07:25:54PM +0530, Pavan Kumar Sunkara wrote=
:
>>>>
>>>> +our @ISA =3D qw(Exporter);
>>
>> This is also re-arranging deck chairs on the Titanic, but 'use base
>> qw(Exporter)' is nicer.
>
> Or simply 'use Exporter qw(import);', as Perl 5.8+ supports
> 'use Module LIST' form.

Ah yes, if the code is lucky enough to require 5.8 in the first place.
I didn't know whether gitweb was one of those things.
