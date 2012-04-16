From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Tue, 17 Apr 2012 01:33:25 +0300
Message-ID: <CAMP44s2N9wFg5kx7jw2w6G6BQ1riX-W9cKt8kBPaofugm0OV1g@mail.gmail.com>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
	<20120415213718.GB5813@burratino>
	<20120416221531.GA2299@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:33:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuUF-0006ki-Rg
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752221Ab2DPWd1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 18:33:27 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:52590 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474Ab2DPWd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 18:33:26 -0400
Received: by eekc41 with SMTP id c41so1435561eek.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SgBwzv8ean9B782ts4zkHASluO5VLadQfzLKYLo8uMM=;
        b=g0UPLdK/c1RqvrIqPBaN5R2DTubWBor1GYkCQ3ZcH5Lwlx+HTBQ8+oTOLMfRU45OAh
         OmLJb2uQGt3PbXH0hTuRQOVplg/LBRy+PeclYQNnNaHIY3oG/g9uJoBiXg6ojXUsmEYf
         +uSyY8W34bflsCZ90OUERDRQ6eFh93AiVa5UW5o0pWyyPf9hWYXjsTYR1DWK+3YwYu7u
         ivmfUZg2Mw0RmrsqFaF4Kn5afrd0+Oa+RVcesUCaZ6hpX2M1Zpr2It28LvnTvdZsy9yL
         EEx7dKXFs8/4bYRCS3ziY6mUJ6RJkwkSIvA0QL0XkiOCNKjXQs9gXn+sE6YoUU/e32HL
         rckg==
Received: by 10.213.32.2 with SMTP id a2mr911394ebd.39.1334615605402; Mon, 16
 Apr 2012 15:33:25 -0700 (PDT)
Received: by 10.213.19.67 with HTTP; Mon, 16 Apr 2012 15:33:25 -0700 (PDT)
In-Reply-To: <20120416221531.GA2299@goldbirke>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195716>

2012/4/17 SZEDER G=C3=A1bor <szeder@ira.uka.de>:
> On Sun, Apr 15, 2012 at 04:37:18PM -0500, Jonathan Nieder wrote:
>> Felipe Contreras wrote:

>> A name like __git_complete should work, presumably.
>
> And foo_wrap() should also fit into those namespaces.

Yeah, I don't have a problem with that, just forgot about it.

But git_complete I think is different.

--=20
=46elipe Contreras
