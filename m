From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 1/3] git-submodule: allow submodule name and path to differ
Date: Sun, 10 Jun 2007 10:42:43 +0200
Message-ID: <8c5c35580706100142j38cc18a6tf4a23bd0c82afb82@mail.gmail.com>
References: <1181425132239-git-send-email-hjemli@gmail.com>
	 <1181425132294-git-send-email-hjemli@gmail.com>
	 <7vbqfod57b.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0706100820560.4059@racer.site>
	 <7vps448bgx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sven Verdoolaege" <skimo@kotnet.org>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:42:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJ0X-00053C-Tl
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:42:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762890AbXFJImp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762873AbXFJImo
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:42:44 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:20052 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762715AbXFJImo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:42:44 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1688345wah
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 01:42:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S5J4XJ1vDcaYsxMBwQdrMlZ2wyFNfVHumTZvDjDPCeqQvYTvrol4cZHS2hzR3jJlikmwLoVGJH9hC/EwaTGIEvfJ3snjWJ+456mdS9TfLZVfm8nrptYllewhe2QNXWbnAwnrcfpOOavnP12O2WTAJutjBnM6S1W0mufvQQjzGB8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QtnClK7879Ht/Z310UR4cyNbSDLKQr+f5ickV1WCOI9g/NVZh/o958VcxESrrpCYDEIBcOgMJsOCcl3TvXibiRDcw2N4AYTlD+zc9iqZvaTYf1m4TldhP/2crCJI6wyiXAoD+R7N/oSTIbgUFPpSh1KxLt247LXTJaJRd26Cfgk=
Received: by 10.114.171.1 with SMTP id t1mr4294295wae.1181464963690;
        Sun, 10 Jun 2007 01:42:43 -0700 (PDT)
Received: by 10.115.73.2 with HTTP; Sun, 10 Jun 2007 01:42:43 -0700 (PDT)
In-Reply-To: <7vps448bgx.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49683>

On 6/10/07, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Sat, 9 Jun 2007, Junio C Hamano wrote:
> >
> >> Lars Hjemli <hjemli@gmail.com> writes:
> >>
> >> > This teaches git-submodule to check module.*.path when looking for the
> >> > config for a submodule path. If no match is found it falls back to the
> >> > current behaviour (module.$path).
> >>
> >> I have a feeling that it might be much less troublesome in the longer
> >> term to admit that module.$path was a mistake and support only one
> >> format; wouldn't trying to support both leave ambiguity and confusion?
> >
> > Just my 2cents: git-submodule is not yet in any released version. So let's
> > fix things early. In our world, it's not like you lose face when you have
> > to admit mistakes. (Instead, you lose face when you refuse to fix them.)
> > Ah, if only politics learnt from our world...
>
> Well, I completely agree with what you said up to "So let's fix
> things early.", but when I re-read what I wrote, I realize that
> my wording was bad --- I did not mean to drive the discussion in
> that direction.
>
> It was not Lars's *mistake* to admit to begin with.  His was one
> valid design that was consistent within his patch series.  The
> thing is that there just was a better alternative suggested
> later; it does not make the first iteration a mistake in any
> way.
>
> So, Lars, my apologies if I offended you -- I did not mean it
> that way.

No need for apologies, no offence taken :)

-- 
larsh
