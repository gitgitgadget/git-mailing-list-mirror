From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 0/5] builtin-status submodule summary
Date: Sat, 15 Mar 2008 01:42:57 +0800
Message-ID: <46dff0320803141042g561f94aen2bf8396a2766054b@mail.gmail.com>
References: <1205508521-7407-1-git-send-email-pkufranky@gmail.com>
	 <47DAA638.6060108@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:44:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaDwR-00009A-Ng
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 18:43:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbYCNRnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2008 13:43:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753679AbYCNRnA
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Mar 2008 13:43:00 -0400
Received: from hs-out-0708.google.com ([64.233.178.251]:34697 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753423AbYCNRm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2008 13:42:59 -0400
Received: by hs-out-0708.google.com with SMTP id 4so3065184hsl.5
        for <git@vger.kernel.org>; Fri, 14 Mar 2008 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=y8tjU0TSl3cNyx3zRpXRJbv8RQTqp2m6l8hTbMYUluI=;
        b=n3fLLqmteoiKecuoRMarSMXeqVSLWzYZRV/dGSehiBZwBnySYlT/L5bcoA+eHD6AziTOWjAJURd9lcYbYThCJ03jAaT2slR/1umlM/N5c1qNH21Qgnr/LecrqSIVrmNpftrFNix6RPwitdvggMiOGmzEEQyiUwVykM/0SjhFu4g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gwaKvE+vZgZnh9e1AyjBn0wjN0ieIIT0EffYN21VA9t/TQAjSlsB+reyU/+mLx1ohpSC62Ko7OwgCGa0qIaVeM8CQChHqys7r5RG4d1HWakdMvsFQtdJhzLFW4ID0HtNRaUi0P64QbrUblPqiyceA4FBSymkYN/Ii1h/+Plun70=
Received: by 10.100.33.19 with SMTP id g19mr23504171ang.48.1205516577490;
        Fri, 14 Mar 2008 10:42:57 -0700 (PDT)
Received: by 10.100.32.10 with HTTP; Fri, 14 Mar 2008 10:42:57 -0700 (PDT)
In-Reply-To: <47DAA638.6060108@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77264>

On Sat, Mar 15, 2008 at 12:22 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Ping Yin schrieb:
>
> > IMO, git submodule summary is not so useful for me if it's not
>  > integrated into git-status. In fact i never use "git submodule
>  > summary" directly. git-status with submodule summary support is very
>  > useful to help user figure out what is going on in a more global level
>  > when cooking the commit message.
>  >
>  > So i think this series should go along with the submodule summary series.
>
>  I think so, too. The changes and defaults in wt-status.c are trivial
>  enough that they don't penalize traditional git-status users.
>
>
>  > The v2 series has following commits adding a new commit for documentation
>  >
>  >     1  git-submodule summary: --for-status option
>  >     2  builtin-status: submodule summary support
>  >     3  builtin-status: configurable submodule summary size
>  >     4  buitin-status: Add tests for submodule summary
>  >     5  git-status: Mention status.submodulesummary config in the documentation
>
>  I'd actually squash 2, 3, and 5.
>
>  You still have the statement before a declaration in 3/5.
Sorry i forgot about it.

>
>
>  > +     if (! wt_status_submodule_summary) return;
>
>  And here the important part (IMO) is actually that 'return' should go on a
>  line of its own.
OK



-- 
Ping Yin
