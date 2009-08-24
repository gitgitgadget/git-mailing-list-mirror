From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: sr/gfi-options, was Re: What's cooking in git.git (Aug 2009, #04; 
	Sun, 23)
Date: Mon, 24 Aug 2009 11:45:51 -0700
Message-ID: <fabb9a1e0908241145p2a1fe59fgef42a4c46209f154@mail.gmail.com>
References: <7v1vn2qb29.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0908241641390.11375@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 24 20:46:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfeYf-0006jw-8g
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 20:46:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753276AbZHXSqM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2009 14:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753234AbZHXSqL
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 14:46:11 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:54425 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753222AbZHXSqK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 14:46:10 -0400
Received: by ewy3 with SMTP id 3so2666793ewy.18
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 11:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=R0XJ8aReYUo8Sc3ZvgpiPZzSkpwS4pDU3CbojqsEgik=;
        b=rRnVDVhklQvqrfO0VqCOb0D0GQM+iMG5r1lO27YSrBdgMZSEJKnEjvKg84DJ43RBAN
         ZBfkF2cxGCObrvWdkJ/N+vYGpu3ynmwbRYcwuKy8Hch4EjrvXcU+D8ZGsXh0E1pmDelm
         MjigZlSpXe98dNVRIcYE9NcrUiqg2rZTNVyhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=bBejXWYHQTN+DlJdTBlWYE113TBnjW0jU6fgLfmYBVij5aNwkL8K4fdxol2EEmEpHv
         NZ3L63hNw5vP6+KGtohs92EAuTMdAlG/9+dRXHv8784OwMu021nWEVAxfjEeb1DKiia1
         cPpL7ETGwiMlPfLnwZSqTEnUxska+mnXwQloU=
Received: by 10.216.18.84 with SMTP id k62mr1070715wek.126.1251139571116; Mon, 
	24 Aug 2009 11:46:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908241641390.11375@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126955>

Heya,

On Mon, Aug 24, 2009 at 07:45, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> On Sun, 23 Aug 2009, Junio C Hamano wrote:
>> * sr/gfi-options (2009-08-13) 3 commits
>> =A0- fast-import: test the new option command
>> =A0- fast-import: add option command
>> =A0- fast-import: put option parsing code in seperate functions
>>
>> What is this used by?
>
> By a hg-fast-import Sverre was writing for me:

And possibly also by the p4 helper I think?

> Sverre hinted at the possibility of ripping this out of hg-git and pu=
tting
> it into a hg:// helper.

I don't know if I have time for that this week, but it's at the top of
my todo list :).

--=20
Cheers,

Sverre Rabbelier
