From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v2] git-merge: ignore space support
Date: Wed, 25 Aug 2010 09:22:34 +0200
Message-ID: <AANLkTimRyeMbLKLmbKJEqgGPDFo3OCsz=QwVzkSaP5n8@mail.gmail.com>
References: <20100823205915.GA4484@ns1.cockos.com>
	<20100824022820.GE17406@burratino>
	<5F681E95-9369-490A-84FE-55B99EA8FE63@cockos.com>
	<20100825044006.GJ11619@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Justin Frankel <justin@cockos.com>, git@vger.kernel.org,
	eyvind.bernhardsen@gmail.com, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 25 09:22:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoAJm-0001pH-NJ
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 09:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684Ab0HYHWg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Aug 2010 03:22:36 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56857 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab0HYHWe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Aug 2010 03:22:34 -0400
Received: by iwn5 with SMTP id 5so362445iwn.19
        for <git@vger.kernel.org>; Wed, 25 Aug 2010 00:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iQnPoVvulj7QjouzUgEI2so821/iNcwxPPztJFO42jM=;
        b=IA1Rh45rYV58lOdekqKeSCJ5K2vdT3eloy1VcaMEUJSlsLSr/X1rFQmoAY01LRu8WG
         cQW8Aka9kLn0vBOKjUHx4IFdEcKRMWJMN/+NFT4ro86g4chmRZPeHA0kAOYWjArS793f
         RmR9oZ3EXtZPq77N+s2KTaXvZOy3ASn4L0oXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WA1wj+NgOn3sdix71JpPgtB7V2ZVXF/LyrYV4HMjmvApk5bI469d4eGGtmmqHLfQ7m
         v0osdUTGWEEHLdFYKbyU8Glo4+mn4ycaXxIFN1JpU1bSZC/VdZwICzNAUVwri8qPqQ2M
         zkl1TSgzEGbfN5SH5gNzIv0b/QZ1l7/eCw/a0=
Received: by 10.231.13.133 with SMTP id c5mr9300526iba.73.1282720954161; Wed,
 25 Aug 2010 00:22:34 -0700 (PDT)
Received: by 10.231.154.204 with HTTP; Wed, 25 Aug 2010 00:22:34 -0700 (PDT)
In-Reply-To: <20100825044006.GJ11619@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154430>

Hi,

On Wed, Aug 25, 2010 at 06:40, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Justin Frankel wrote:
>
>> Fine by me... (ok if I were to nitpick I would probably make most of
>> the internal static functions check that opts was non-NULL before
>> dereferencing, in case the calling code ever changed
>
> Not a bad idea. =C2=A0I'll squash in something like this.
>
> A real BUG_ON macro would make this less ugly.

I think exactly because of this there is no prior art of using NULL as
'use the default options'. Without this all these NULL pointer checks
wont be necessary.

Bert
