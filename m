From: "Thomas Adam" <thomas.adam22@gmail.com>
Subject: Re: [PATCH] asciidoc: add minor workaround to add an empty line after code blocks
Date: Sat, 1 Nov 2008 23:42:44 +0000
Message-ID: <18071eea0811011642g6bc36530sf2036ef15ce0df82@mail.gmail.com>
References: <87skqfus7v.fsf@iki.fi>
	 <2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com>
	 <87od13ujm4.fsf@iki.fi> <20081030104503.GA17131@diku.dk>
	 <7v7i7n3vwe.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jonas Fonseca" <fonseca@diku.dk>,
	"Teemu Likonen" <tlikonen@iki.fi>, git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 00:44:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwQ8O-0004f0-V5
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 00:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132AbYKAXmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 19:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752056AbYKAXmr
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 19:42:47 -0400
Received: from mu-out-0910.google.com ([209.85.134.191]:5732 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752041AbYKAXmq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 19:42:46 -0400
Received: by mu-out-0910.google.com with SMTP id g7so1889944muf.1
        for <git@vger.kernel.org>; Sat, 01 Nov 2008 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=r2WcQ8dB8xfq6BDfQfU+aZ2TohMZE3zigwDQog9K+9s=;
        b=OzMcbVRS+hdct2zeUG5X6xL+ZAbTfwSeiVDqjeUAjEcQA+ar4SFlJiRFERSqVLfPc1
         MoyZdGAJnGbaR4XWImcvZ/oAC1HydehnpHN2xwiWq9zdlVakKaA1vr2ceaHJys8j/FfV
         oBcXyYVzhbUP3IQmdflnWHYIpfQRqPkJgO88Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=u6uqqgGo15mrJp3oA76v7cMFI3im427e14J+A9DKXak/p2oEnUVAFBAjp7lXj8sVC4
         ImmT4PfuINZNmZaRsoP8ye/Ga+ewPtW1V5QLvK1lTMM8FttmW3OpSUFeSkb/zS8A6HHH
         mXxCRYINWdgy27SAhDaTDWjb0H+UgufEU6ilg=
Received: by 10.103.218.19 with SMTP id v19mr6324010muq.110.1225582964398;
        Sat, 01 Nov 2008 16:42:44 -0700 (PDT)
Received: by 10.103.182.8 with HTTP; Sat, 1 Nov 2008 16:42:44 -0700 (PDT)
In-Reply-To: <7v7i7n3vwe.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99789>

Hello --

2008/11/1 Junio C Hamano <gitster@pobox.com>:
> Thanks; I do not have an environment with docbook-xsl-172 handy, so I'll
> just take your word and apply it to 'maint'.

Just out of interest, how much progression on the asciidoc Git
documentation is there with respect to the latest version of asciidoc
which might give new features, if that makes sense?   Something the
ELinks project does is distribute a fixed version of the asciidoc
script to avoid annoying asciidoc errors each time there's a new
asciidoc release.

Is this something worth considering for Git as well?

-- Thomas Adam
