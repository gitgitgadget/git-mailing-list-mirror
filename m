From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Message from git reset: confusing?
Date: Wed, 5 Aug 2009 11:25:07 -0700
Message-ID: <fabb9a1e0908051125n3e125209n88a9fd86d6fa7534@mail.gmail.com>
References: <vpqab2e7064.fsf@bauges.imag.fr> <7v1vnqb2hc.fsf@alter.siamese.dyndns.org> 
	<32541b130908051042x5308e8fte7b3ead6bf1f24ee@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 20:25:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYlB9-0004hY-S8
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 20:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbZHESZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Aug 2009 14:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZHESZ2
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Aug 2009 14:25:28 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:57869 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbZHESZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Aug 2009 14:25:27 -0400
Received: by ewy10 with SMTP id 10so202216ewy.37
        for <git@vger.kernel.org>; Wed, 05 Aug 2009 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lb3dxcVDR/9Q0paE3brStC9mzVKGBh9Clh82y3HMq4M=;
        b=TJmkSV0NUSdLykIXeXn5gcSTsPIpqF0lG7Q81VkK+8uzMuon92hnauWJVVwLL0i7aj
         ii/klprbl8HZPnq63ueMWJ0tNrAlyRuZGQodcy6M3yTJVDSjut3T9fZMl2EhWwg/Pr3e
         a2dHRIW/aUxKFKre3imNBPFkEqJkhjMYRYXZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NWvgZbRr9xUkR5pjfY+t5C9HLq653w+LneBoT1La43U7Q7OzwrREXaZF3Bl6IXdzC9
         1KMs4+f0lqcccaNEWb45aUTAv2zoukgGe9XoZjdFAh8Z2u9o35SPXrDSwEnGbX14iadc
         kwvapMoiOyhMnmzCW0a8UC6gZ+ynQyJDp9HlE=
Received: by 10.216.10.149 with SMTP id 21mr1195106wev.56.1249496727115; Wed, 
	05 Aug 2009 11:25:27 -0700 (PDT)
In-Reply-To: <32541b130908051042x5308e8fte7b3ead6bf1f24ee@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124942>

Heya,

On Wed, Aug 5, 2009 at 10:42, Avery Pennarun<apenwarr@gmail.com> wrote:
> Yes. =A0I think the problem is that the current output looks more lik=
e
> an error message than a status report.

Definitely.

> I would find it very pleasant if the output looked more like the
> output of "git checkout" (no parameters) in the no-files-specified
> case.

Perhaps instead we could get away with simply adding a header like
'git status' does? And perhaps change the wording some.

--=20
Cheers,

Sverre Rabbelier
