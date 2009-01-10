From: "Jonas Fonseca" <jonas.fonseca@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #01; Mon, 05)
Date: Fri, 9 Jan 2009 23:15:37 -0500
Message-ID: <2c6b72b30901092015l2405627aqf928e43c12eabc3c@mail.gmail.com>
References: <7vbpulnduj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jan 10 05:17:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLVHT-0001uC-OP
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 05:17:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbZAJEPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 23:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbZAJEPj
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 23:15:39 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:39904 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbZAJEPi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 23:15:38 -0500
Received: by bwz14 with SMTP id 14so29892421bwz.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 20:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=I0QbZES3I9IxuL9QBBlcgdSxHGQAaNHeDbtXSzPUevs=;
        b=BP8E7dN/L6CV7VdF8m5dZb4t3lamar+OfxQUH3DBmOqXxyUwa0x0vz6jbuaMYZrc9p
         nSp4kR8a+7HOHkqLpv43rPA5q4Ujn16ssgVIrZsjIb6OwFm/xQeUecEfFRe6zPOZsVI5
         dJb+4HFgIvJoPTR9UAsmme+qOfJ1kBZqyPY9E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Ek/paQmrRm4kP6HQzDcU+yhDjmdtp+GCTuxw8TzWvTrct3WUtJnx0a0DohNk/lqsT3
         UnlDC16ALUSc/TB+DvAsGJ7N7iuCth+ggkLAB74G2isyEcqNb5nGm9iOqT3p6SXZl+Hn
         S/jI4Fc5ZzzCtzZkXh1jiW6yzXXg3KcXfAKuk=
Received: by 10.181.145.6 with SMTP id x6mr10000579bkn.25.1231560937104;
        Fri, 09 Jan 2009 20:15:37 -0800 (PST)
Received: by 10.181.215.20 with HTTP; Fri, 9 Jan 2009 20:15:37 -0800 (PST)
In-Reply-To: <7vbpulnduj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105071>

On Tue, Jan 6, 2009 at 01:33, Junio C Hamano <gitster@pobox.com> wrote:
> ----------------------------------------------------------------
> * mv/apply-parse-opt (Sun Dec 28 00:03:57 2008 +0100) 1 commit
>  + parse-opt: migrate builtin-apply.

This broke apply for me after updating to the current "next" earlier
today. When requesting that the patch be read from stdin I get the
following error message:

  > git diff | git apply -R -
  fatal: can't open patch '-': No such file or directory

-- 
Jonas Fonseca
