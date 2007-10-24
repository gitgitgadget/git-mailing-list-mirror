From: "Jakub Narebski" <jnareb@gmail.com>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished summary continued
Date: Wed, 24 Oct 2007 13:04:01 +0200
Message-ID: <8fe92b430710240404u202521d4g2275bc4886956807@mail.gmail.com>
References: <1192827476.4522.93.camel@cacharro.xalalinux.org>
	 <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de>
	 <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com>
	 <Pine.LNX.4.64.0710210031130.25221@racer.site>
	 <471AFD07.4040606@op5.se>
	 <Pine.LNX.4.64.0710212308540.25221@racer.site>
	 <471C586A.9030900@op5.se>
	 <Pine.LNX.4.64.0710221156540.25221@racer.site>
	 <8fe92b430710231906l35606fe2j2b7c28ed6f4dd1a3@mail.gmail.com>
	 <20071024102950.GA3908@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Andreas Ericsson" <ae@op5.se>,
	"Steffen Prohaska" <prohaska@zib.de>,
	"Federico Mena Quintero" <federico@novell.com>, git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Oct 24 13:04:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ike2A-000673-Fn
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 13:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084AbXJXLEF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Oct 2007 07:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754929AbXJXLEE
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 07:04:04 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:54058 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753107AbXJXLEB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Oct 2007 07:04:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so183481wah
        for <git@vger.kernel.org>; Wed, 24 Oct 2007 04:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=FLJooOM13L5hpT7Trmr7wkYEYt3GydSXSGdUYHI1feY=;
        b=aO9bLXb3lpBKE/Zp56fbftKjVxMxKxB6BDQBlGKfn7nZEIBpXwo5sMtPszd3HuscTv+w2vbAq3wltg8Vgi3ZT7S/W+1nrSNTdhE1LuC9XFlAsLQWb2Laaus32f2w76EIctyMJIrgMTy1nLKIblWzk302/ufMxTC3vekts6552zM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U+cVHZ6/MDmXdkxMK1/wMObUYCBG7lt9Szfzbu6vzulRzcls5vg0pepp8ulEAEo3T3IgxAa5p2ibNkxY9yZqj3EE2/EnpmwpU3vs/ksazM2JcltWbxfZqq0gfvvWafrp68vmDsBL0EU7Hqp5xnj2IdV6GTuMUqCf8KD9AtGvN9s=
Received: by 10.114.183.1 with SMTP id g1mr559875waf.1193223841321;
        Wed, 24 Oct 2007 04:04:01 -0700 (PDT)
Received: by 10.114.195.16 with HTTP; Wed, 24 Oct 2007 04:04:01 -0700 (PDT)
In-Reply-To: <20071024102950.GA3908@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62207>

On 10/24/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-10-24 04:06:38 +0200, Jakub Narebski wrote:
>
>> 5. git format-patch to generate patch series; use git-shortlog or
>> grepping for patches subjects and git-diff --stat to generate
>> introductory email. Unfortunately StGIT template for introductory
>> email does have neither shortlog nor diffstat fields to atomatically
>> fill.
>
> It does now! (I don't think it's in any released version yet, though.=
)

That is nice to hear.

By the way, there is SRPM for StGIT in
http://homepage.ntlworld.com/cmarinas/stgit/
(I need it because I have Python 2.4), but it is not listed on download=
s page...

--=20
Jakub Narebski
