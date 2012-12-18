From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH 1/2] Documentation/git-checkout.txt: clarify usage
Date: Tue, 18 Dec 2012 13:12:57 +1100
Message-ID: <CAH5451nVVSoJeTkCsuyKfJksg15mwPfcZxym9WCzNK2ENezg-w@mail.gmail.com>
References: <1355726702-27974-1-git-send-email-chris@rorvick.com>
 <1355726702-27974-2-git-send-email-chris@rorvick.com> <7vhanlnnz7.fsf@alter.siamese.dyndns.org>
 <17103971665F4C4495C6C96086A58B8F@PhilipOakley> <7v1ueol6ut.fsf@alter.siamese.dyndns.org>
 <CAH5451nVe1VcD3VzCO7EtKSkzv9CyJs=uqQ9MkMTJEXMTwEvmw@mail.gmail.com>
 <7vobhsjq6a.fsf@alter.siamese.dyndns.org> <7vvcc0i0rz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Chris Rorvick <chris@rorvick.com>,
	Git List <git@vger.kernel.org>,
	Tomas Carnecky <tomas.carnecky@gmail.com>,
	Woody Wu <narkewoody@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 03:13:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkmgc-0000mK-BY
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 03:13:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753608Ab2LRCNT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 21:13:19 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:50378 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106Ab2LRCNS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 21:13:18 -0500
Received: by mail-qc0-f175.google.com with SMTP id j3so42342qcs.34
        for <git@vger.kernel.org>; Mon, 17 Dec 2012 18:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Hj5F34r7WHBsuoI+LSvtuuHCUka2sPyZK1pK4KLVesw=;
        b=YU4LY94Ej1zPSv9tcXf5z0mvgx9NHPC4WpHYEwk4L4/SCYu6SCZ6Efq7V55nPmUVl3
         bTSBBsZR8ful5XNQxNdT0dfeDdaA6/AXyT0dJrP1nyeCHfvizEyec9hDaLvm3EOmzTXG
         37dUMIu2LRqTkph0qIDrazswgFXLZ+rJtF0ZdxKEynDRAiAZIzZwjE/PbI89HbuCQ3nf
         T3MAZvUXor0aYYnmSn7ZtIq2tKmgk2f+4dtTY0xFc0a23vivmqowBQdu9anJcHGbbOIx
         31qSX+w1rr0W0PvjwhRl31+NBh4auYl04to2CdhAHU0GxrBTYm9UkGxy5wR2bJpYNISd
         488Q==
Received: by 10.224.96.4 with SMTP id f4mr223275qan.79.1355796798047; Mon, 17
 Dec 2012 18:13:18 -0800 (PST)
Received: by 10.49.14.3 with HTTP; Mon, 17 Dec 2012 18:12:57 -0800 (PST)
In-Reply-To: <7vvcc0i0rz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211731>

I like these, and I think they are conveying the right amount of
information. There is a slight discrepancy between the <branch> and
<commit> versions, where it seems we are assuming that by checking out
a commit you are intending to work 'on top of' it. This could be
avoided by using the term 'with' in both cases. Also, they are in
different tenses, but I'm not sure which is preferred ('Prepare to' vs
'To prepare for').

In the second tense, these opening lines might look like this:

+       To prepare for working with <branch>, switch to it by updating

+       To prepare for working with <commit>, detach HEAD at it
+       (see "DETACHED HEAD" section), and update the index and the
+       files in the working tree.


Regards,

Andrew Ardill
