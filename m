From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: What's not in 'master', and likely not to be until 1.5.4
Date: Fri, 18 Jan 2008 13:17:02 +0100
Message-ID: <e5bfff550801180417m587c4bfcm7af348ea1a04f648@mail.gmail.com>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	 <7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	 <47891658.3090604@gmail.com>
	 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	 <47893E1A.5020702@gmail.com>
	 <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	 <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	 <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 13:17:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFqAC-0000QD-8a
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 13:17:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbYARMRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 07:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYARMRF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 07:17:05 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:7446 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751361AbYARMRE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 07:17:04 -0500
Received: by rv-out-0910.google.com with SMTP id k20so873859rvb.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2008 04:17:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wffVuBr0YQMVXnAdx7/IrnGvAMZ9Kb+GDiKuMrneR2A=;
        b=K89a8OfLJfiDzlG7MAYDaqwTuomz87oAWHvaWBGPK2cqeAlhQlNLHKnaTiVuHqo8zvV3+NxrV956JZU5xt1vd4zK2r5kibtQIVizKU15lMV1b/yoDz3HCNJgLW1N7wAqbv6VVKXUHJPjESXidn+BhEvsu8KXcfAJc25K6EdDhXg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FKklZbzcn25MbfYikNeLhKiwQ91u1G0lztsH0/ZictXNZkqx1aiIY7O5nsvLxGLVHDCUUT4iAVka0KRLVAMbEOhZghxZlK09LVuryoOLtAZMteN8TrdjKZVP3IRVuTQb2FGy9PTG0hIvwenzOJPKWfVMiEHcaFMMBDnmwozfVNU=
Received: by 10.140.126.14 with SMTP id y14mr2333089rvc.96.1200658622941;
        Fri, 18 Jan 2008 04:17:02 -0800 (PST)
Received: by 10.141.68.21 with HTTP; Fri, 18 Jan 2008 04:17:02 -0800 (PST)
In-Reply-To: <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71006>

On Jan 18, 2008 11:40 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> I think some of them actually have a slight chance of being
> 1.5.4 material, if interested parties present good enough
> arguments that they are actually good and safe bugfixes.
>
>  * compress/decompress abstraction (Marco)
>

I have good enough arguments to NOT include it in 1.5.4: it's a
cleanup, so it's developer oriented, not user oriented, no
performance/feature benefit, no bug fix.

Please apply only after 1.5.4 is out.

Thanks
Marco
