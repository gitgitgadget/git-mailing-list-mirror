From: Pat Notz <patnotz@gmail.com>
Subject: Re: get-upstream
Date: Thu, 23 Sep 2010 08:28:21 -0600
Message-ID: <AANLkTinm2sJbhiZ8pUNtv4KUE3tqWtsDVzKpNXUa=Dn7@mail.gmail.com>
References: <AANLkTikqJmsUo53dRngXcWsoEfcFzLQ-J1V5oZOGUL03@mail.gmail.com>
 <AANLkTikQ8sHrp+sSZ8e8u7L+6=NHVY3cD9DwChAzLEk0@mail.gmail.com>
 <AANLkTikYnj_00Pdsm+QM1=kvqMpeKDCeOOqOS0XEwMXg@mail.gmail.com>
 <AANLkTi=QnP0CUCU=6fR50UzphnVMVvmfe9mkqpf1NHLt@mail.gmail.com> <20100923053717.GB27540@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramana Kumar <ramana.kumar@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 23 16:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oymn4-0004LI-7N
	for gcvg-git-2@lo.gmane.org; Thu, 23 Sep 2010 16:28:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab0IWO2o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Sep 2010 10:28:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:56494 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0IWO2n convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Sep 2010 10:28:43 -0400
Received: by fxm3 with SMTP id 3so63682fxm.19
        for <git@vger.kernel.org>; Thu, 23 Sep 2010 07:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0eb1lntoond66NT8U0h3GPW20aGwjgI/qDilpW6Uopk=;
        b=pStOjut3C74K+GowuB9LOkg/9ecwA3OLqjN7nMz8S8ar5ncyQW+oZ4GdVwIUwc3UH6
         YPGFAwIaLXY7PAqVTqL3Z306T8NUrS1kA/E2BAz8ixJL6piXgrKVAq74gbaKUL5JzOTE
         cUeQYV7kCDH8WlD8NA0AQcYXSAOvMaPp36n98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FJPXfGEhmRDn6aDaeRiyI+5uRIsQwTjOIJgmeuZ/TtI/d4qhudGQVRXIyL8RJNDHTQ
         rq5dYWiTRspJVysj4NzqixqXnoFm+vD6XAZghIJ8lGLa+6qtwRCbKREplblU3fS8XF5g
         A28iZhWxshqTsvGpuUntcsFhhSF8NdADRn5qM=
Received: by 10.239.187.134 with SMTP id l6mr99286hbh.132.1285252122243; Thu,
 23 Sep 2010 07:28:42 -0700 (PDT)
Received: by 10.239.185.65 with HTTP; Thu, 23 Sep 2010 07:28:21 -0700 (PDT)
In-Reply-To: <20100923053717.GB27540@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156870>

On Wed, Sep 22, 2010 at 11:37 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 23, 2010 at 02:16:43PM +1000, Ramana Kumar wrote:
>
>> Thanks Pat - that's awesome.
>> Is there a git shortcut for removing the refs/remotes or refs/heads
>> prefix? (I know I can just use other progs for that too)
>
> If you use the for-each-ref solution, you can use the :short modifier=
,
> like:
>
> =A0git for-each-ref --format=3D'%(upstream:short)' `git symbolic-ref =
HEAD`
>
> -Peff
>

That's pretty cool.  Using the >=3D1.7.0 syntax you can also specify an
alternate branch like

$ git rev-parse --symbolic-full-name other-branch@{upstream}

Also, looking at TFM I discovered that @{u} is valid shorthand for
@{upstream} -- sweet.

Still, I think Peff's solution looks best and covers more versions of g=
it.
