From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] test-lib: make test_expect_code a test command
Date: Fri, 1 Oct 2010 13:55:54 -0500
Message-ID: <20101001185554.GB18692@burratino>
References: <7vd3rtholo.fsf@alter.siamese.dyndns.org>
 <1285953391-29840-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 01 20:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1kpW-000392-0W
	for gcvg-git-2@lo.gmane.org; Fri, 01 Oct 2010 20:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755427Ab0JAS7D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Oct 2010 14:59:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:49705 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755414Ab0JAS7B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Oct 2010 14:59:01 -0400
Received: by iwn5 with SMTP id 5so4149520iwn.19
        for <git@vger.kernel.org>; Fri, 01 Oct 2010 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rzZl/E8nkG2k3rZY1gvvJsbbslF7YTYRH9sO12xoRE4=;
        b=DL8BHJ/O0IN/39L6JjgAs+tEa63NbSGFrrKvuFhP0MYW2n5vLLQYbEJcYWwPczqYFU
         mMzDiTsXweG+Zfcaqj1MZYlVRGGGKwYOS3DIp3pyZ+mmq94U/lXRITJ5srfoTmzsqEK1
         AbouamAJevE5PeYtm+eHb047RTLkyevhTIv7g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=DSuOrRWyfsfFmS/p5MRsYmkq47u0IdAb2OZYJv7BcECUmXNUfhO49CJukQS4QdHFQc
         kR0sMMSBnctDOMYg3GfZ0z94g2Ar+ofx4l/rLRVAKlNlOrwTEq68lqqti8xXzIO2pK6e
         szPTkc0eJzkpvElHoorC1jrGRplVbLnU0+Vvc=
Received: by 10.231.168.21 with SMTP id s21mr6107167iby.123.1285959541308;
        Fri, 01 Oct 2010 11:59:01 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id r3sm1481507ibk.7.2010.10.01.11.59.00
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 01 Oct 2010 11:59:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1285953391-29840-1-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157773>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Change test_expect_code to be a normal test command instead of a
> top-level command.

I like it.  New code that uses test_expect_code in the old sense
would be easily caught because the title description tends not
to be the name of a command.

Thanks for making the test suite a little saner.
