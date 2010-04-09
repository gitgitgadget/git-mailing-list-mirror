From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: How can I tell if a file is ignored by git?
Date: Fri, 9 Apr 2010 05:01:46 +0000
Message-ID: <w2i51dd1af81004082201j81a2758di2e430785a72a5b03@mail.gmail.com>
References: <20100409040434.8602620CBBC@snark.thyrsus.com>
	 <w2hf3271551004082150x620aa21az72b7254f57fbc3f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Raymond <esr@snark.thyrsus.com>, git@vger.kernel.org,
	Jacob Helwig <jacob.helwig@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 07:01:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O06Lt-00017Z-F3
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 07:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752801Ab0DIFBu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 01:01:50 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:47169 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab0DIFBt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 01:01:49 -0400
Received: by bwz1 with SMTP id 1so2257273bwz.21
        for <git@vger.kernel.org>; Thu, 08 Apr 2010 22:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type;
        bh=BtSRQow2KnpITNsEsxRvw5+6FlFjIUCc/iuhCRFAyh8=;
        b=UtnBj2X4EtRXK2YQI2e0oQbE4ORDjbL6j8BxZAhkTiObSSQHKaDs6TOpwlTz0GBrBR
         AIUIM77pWLZqgPJOZVVsTm0uZ2YnWy7RppQDlhMHkBdMXBNLQQ/Z+wEnqHI2LHPy1yHo
         OXwwpGvQZ5DgEGLPWC/Fe9RqMJTNxekNq+hQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=L9r2fhGfDSPWWOcsLSQ8kJezFXZCdpAnZtznfKSI4n6Yje1BcySbTpMfc3LngjZAu6
         eG3sSk4lvaRX0ATj1pj6gdUwjpJRRNHwkTnUGazLgG7vlC0eDxdF3zPJ5ZzQAQqg2HhF
         mYmDtSHlQJgmljNST9K1TB0ugq+sew7eGd1nU=
Received: by 10.204.121.195 with HTTP; Thu, 8 Apr 2010 22:01:46 -0700 (PDT)
In-Reply-To: <w2hf3271551004082150x620aa21az72b7254f57fbc3f5@mail.gmail.com>
Received: by 10.204.132.214 with SMTP id c22mr1255361bkt.60.1270789306875; 
	Thu, 08 Apr 2010 22:01:46 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144397>

On Fri, Apr 9, 2010 at 04:50, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> I personally use Magit [1]. Just thought you might want to look at it.

Eric might be a bit too personally invested vc.el at this point :)

But yeah, magit is great, unlike vc-dir and vc it makes really good
use of Git's index & stash features. Instead of staging individual
files for commit you stage chunks, the quality and granularity of my
commits has gone up since I switched to it from vc due to that.

But to help with the original question: magit has an ignore feature
but it doesn't check whether something is ignored, it just counts on
you not ignoring already ignored stuff because it isn't displayed to
you.

Depending on how you're planning to implement .gitignore support you
might want to go this route.
