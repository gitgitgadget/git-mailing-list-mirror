From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Re: Applicatioin of contribution for Git Chinese version
Date: Sat, 16 Apr 2011 18:07:57 -0500
Message-ID: <20110416230757.GA5606@elie>
References: <20110416223310.GA5149@elie>
 <559debc.6920e.12f5f0bdfc0.Coremail.cyrus_evans@163.com>
 <BANLkTi=29fvnLYVnsjpYXfaB20=H6D6fcg@mail.gmail.com>
 <6e8d0165.486.12f608bb3de.Coremail.cyrus@drupalgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git <git@vger.kernel.org>, Erik Faye-Lund <kusmabite@gmail.com>
To: Cyrus <cyrus@drupalgate.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 01:08:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBEb6-00053u-Mk
	for gcvg-git-2@lo.gmane.org; Sun, 17 Apr 2011 01:08:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759338Ab1DPXII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 16 Apr 2011 19:08:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:63073 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008Ab1DPXIE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2011 19:08:04 -0400
Received: by iyb14 with SMTP id 14so2988266iyb.19
        for <git@vger.kernel.org>; Sat, 16 Apr 2011 16:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Wt40frPOYx4dxRzkW94InB5TpfDDjyAg2POAzF4gn0s=;
        b=PzDFjomiJe+L1VyvPlvcCAtCdK4GnWKg3TXP+wSKhF/hvBgRbzzq8A84FEuZEbhpwK
         4udrngZL/RD31Gb0wU7H7mnx6RPE+b5Dfa6J925a7kNG4mufu//bL3bXriIrGs4P8/SK
         PKdL241BGiqY1S2yQn+3vjJ/t5OyJkNk82AxY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=T3NDz7B3u0cl07yHy7Nk5Geumm7F3kKLe2cI3AoIaxZlYYSlTql72FBaOIglaN6wy/
         tOOUrfqHM/HmsxooN/4NmgoqxMyZw2Ku89xTrXGnDEijubtB66KD246c/KvdQYyvGmOs
         bawODX7shG45RVK8hrj0sZsq1lgdSG37dsW7I=
Received: by 10.42.213.132 with SMTP id gw4mr4638207icb.59.1302995283429;
        Sat, 16 Apr 2011 16:08:03 -0700 (PDT)
Received: from elie (adsl-69-209-51-5.dsl.chcgil.sbcglobal.net [69.209.51.5])
        by mx.google.com with ESMTPS id xg14sm2062425icb.7.2011.04.16.16.08.01
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 16:08:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6e8d0165.486.12f608bb3de.Coremail.cyrus@drupalgate.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171703>

Cyrus wrote:
> At 2011-04-17 06:33:10=EF=BC=8C"Jonathan Nieder" <jrnieder@gmail.com>=
 wrote:

>> 2. Msysgit does not include a pre-compiled copy of gettext yet, but
>>    Erik Faye-Lund has done the necessary work.  Make use of it like
>>    so:
>>
>> 	cd /
>> 	git checkout devel
>> 	cd /src/gettext
>> 	sh release.sh
>>
>>    Now "gettext --help" should work.
>
> When I go to step 2 as you mentioned in the mail, I meet errors.
> Please see my screenshot in the attachment. Thanks .
>
> | error: Your local changes to the following files would be overwritt=
en by checkout:
> |
> |	bin/astextplain
[...]

Sorry about that.

	git checkout -f -t origin/devel

should work, I hope.
