From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Sat, 27 Mar 2010 06:49:06 +1100
Message-ID: <2cfc40321003261249g32ba4472x9786a86830ec9813@mail.gmail.com>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
	 <20100326124650.GA12215@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 20:49:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvFWu-0003NU-E6
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 20:49:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752077Ab0CZTtK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Mar 2010 15:49:10 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35341 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751578Ab0CZTtI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Mar 2010 15:49:08 -0400
Received: by pva18 with SMTP id 18so1626047pva.19
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 12:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pVfQ8BCT+9wlaGKHIhr6wE1aZC0qSyi1CHq/FDFak1I=;
        b=sVXHBlDidRBP9x+kumrM4nGiiGzOifIFJDq6PIH+rQTEK1CkBxADtReUv5oJcNroNF
         O/S0jgLBKL9z1FRBjhYW18Pzs9pgIx5cFKweiK3EYbUypwdDoF+1H7KcSzVJVxudmvpY
         PWRtS7q+xniAKMusizPzI8/3VX+SJOFWV+TOw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LzO/ple/KZ255RkC/Ry9zd4+eP+OQ8u2G1RR/o7ldyHgSv7KYZXAd8moLsXoJPuVY3
         4ssMJo7n1b5cAWgNFZtJRirSBysJR3SWjLImCluu+ipDx/Ja1ASenF9hJLOAUl1Ea63j
         TwWp/6YVy6PsRuj4DqaW39rHW8SPgu1XRC1b8=
Received: by 10.115.89.7 with HTTP; Fri, 26 Mar 2010 12:49:06 -0700 (PDT)
In-Reply-To: <20100326124650.GA12215@coredump.intra.peff.net>
Received: by 10.114.187.19 with SMTP id k19mr1848716waf.20.1269632946767; Fri, 
	26 Mar 2010 12:49:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143274>

On Fri, Mar 26, 2010 at 11:46 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 26, 2010 at 11:48:41AM +0100, Johannes Schindelin wrote:
>
>> This supports opening the results of a 'git grep' directly in a page=
r
>> (where the pager can be 'vi', too).
>
> This is not an argument against your patch, but you may be interested=
 in
> an alternate method:
>
> =A0git grep -n $pattern >grep.out
> =A0vim -q grep.out

Or, in bash:

    vim -q <(git grep -n $pattern)

though, of course you don't get the exit code from git.

jon.
