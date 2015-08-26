From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: Git's inconsistent command line options
Date: Wed, 26 Aug 2015 11:10:42 -0700
Message-ID: <CA+P7+xoV=NZvcUyqbdOpjcD1ykrpU7zrWB4JDVMSdBVC7EHEgw@mail.gmail.com>
References: <mrh7ck$r0g$1@ger.gmane.org> <CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
 <CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
 <CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
 <xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com> <CAE1pOi3e8KS9x5yD7CZLESvhXy1oXmQEgUnEFjww7L6JOdZ1Jg@mail.gmail.com>
 <xmqqio822atc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 20:11:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUfAF-0000eK-QS
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 20:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756560AbbHZSLG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 14:11:06 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33213 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756542AbbHZSLD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 14:11:03 -0400
Received: by igfj19 with SMTP id j19so43764358igf.0
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 11:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pX+/iVuBAqZTfM9uBfTbZ53zISz4RtMpDjTDWJdFt1c=;
        b=hO/8LvoEmgdGRoxrqGDEhVj8w4Vgg0WMyFcL2umzSBhBIH1mQyDn6sppkGLEc27ZQQ
         AACj0BIE/4XW/fV0g6YCRtxU7sdlAXJRpch2mWCgDXea1/+RRq7FMI83Fa0BX73ysvJE
         RP4ICdSkirZE5YTXwSEkJQzKcWDF0s//kH2cbBV9q4B0r0MSEDgnRR8z7OSHIlBbjn+P
         px03OoKXw5yVJmFTjQECg2YoOXqjE90Wj5GuNQV3PSRLpLSxVbLLcZzxkghV/x+kH+4v
         BZfd4Er11w9oFvDKUD60zpuBwYsvf/hOepF4Lp1/aH3KAFeFsb9F2Xmfd62rgGt9Mx4f
         Ru6g==
X-Received: by 10.50.82.10 with SMTP id e10mr12184807igy.73.1440612661980;
 Wed, 26 Aug 2015 11:11:01 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 26 Aug 2015 11:10:42 -0700 (PDT)
In-Reply-To: <xmqqio822atc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276623>

On Wed, Aug 26, 2015 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> But notice that I said "if you really want to".  I personally think
> it is a road to madness.

Agreed. I don't believe in command line API here. I think we'd need a
better solution.

My gut says: Live with the warts on old commands and try to make
people use command words for new commands.
