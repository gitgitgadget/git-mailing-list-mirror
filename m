From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: A question about the tree associated with a git notes commit
Date: Wed, 10 Feb 2010 19:21:18 +1100
Message-ID: <2cfc40321002100021r55370b5fj36d9c292c67bcca4@mail.gmail.com>
References: <2cfc40321002092216p5cbf432bs3766d40858f9bf3a@mail.gmail.com>
	 <7vmxzhfuat.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 09:21:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf7p7-0003D4-7S
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 09:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752866Ab0BJIVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 03:21:20 -0500
Received: from mail-yw0-f173.google.com ([209.85.211.173]:49011 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461Ab0BJIVT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 03:21:19 -0500
Received: by ywh3 with SMTP id 3so7488810ywh.22
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 00:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=UGybplFP3iMyJaYdEkMkO28jhdKfL7daYZEcU0+uPtM=;
        b=A7H7xgiY0HUoGBes1SpWiq2ggDc8JtMEgmM1WqW/2kFXt3EnqLKN47pGMG3T5qPDAF
         VO4KRC3xrdvOpe7j75rmdG7GJW8bA4EcWJTvZCKZ0mpOgMgLdNnlRUcpaPFfY7swF8oT
         kF+iHtyBQZT7EYirPXoxhmJrlhy8CBWAC3Fhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Hsjfb+I4zgPK43UBN7f21aGhHu9c3MaOWXlaFrho8ZutQ0CP1x8trwpbMEWBfq4SU5
         f86gCpCp1YgccRNUH8UlS6/vwhYLcapur0hVHi1NHeZUgsQJn5UnCGSEaMjwi6lJYzo6
         2dVt0y7LyknR5fVzhJOFcd/EFZ/bxf0AATxrc=
Received: by 10.150.253.10 with SMTP id a10mr1747794ybi.283.1265790078431; 
	Wed, 10 Feb 2010 00:21:18 -0800 (PST)
In-Reply-To: <7vmxzhfuat.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139500>

Thanks..apologies for not seeking the answer myself.

jon.

On Wed, Feb 10, 2010 at 6:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> Apologies if this question is answered with trivial analysis of the
>> code, I admittedly haven't done that.
>
> Output from "git log master..0ce25c4b" and especially and c07d5eb (t3305:
> Verify that adding many notes with git-notes triggers increased fanout,
> 2010-01-27) and 71942f4 (t3305: Verify that removing notes triggers
> automatic fanout consolidation, 2010-01-27) would be of interest.
>
