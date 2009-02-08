From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Sun, 8 Feb 2009 11:55:55 +0100
Message-ID: <2c6b72b30902080255w6ccac5e9vcd961a9ab93dcdf3@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk>
	 <20090206191511.GD19494@coredump.intra.peff.net>
	 <2c6b72b30902061410l64c98c33g19b97f656d347c83@mail.gmail.com>
	 <20090207071056.GB14856@coredump.intra.peff.net>
	 <7vprhuzoxm.fsf@gitster.siamese.dyndns.org>
	 <alpine.DEB.1.10.0902070050490.8086@asgard.lang.hm>
	 <2c6b72b30902080247n31e5c532m31006fcb07ca95da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun Feb 08 11:57:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LW7Lo-000662-Ph
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 11:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753216AbZBHKz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 05:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753215AbZBHKz6
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 05:55:58 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:35789 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbZBHKz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 05:55:57 -0500
Received: by bwz5 with SMTP id 5so471046bwz.13
        for <git@vger.kernel.org>; Sun, 08 Feb 2009 02:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=KqizaNlKdyk39IVp7DmcIlxDbhkFqRb1BPg/lDKNNYo=;
        b=utuMB6C5t31AT2mQqQQZHj7VC3xKjLKwOPcOG5fRlGr2caMQnr/Ehp07zENyofUR01
         OqpLk3TGZww6ixW6skccqiGG+9Egp1BRKWxKvOnM1Eve5WorhwN9C+jGldUWq/zp6GTi
         P9oHk/cTuNRuysBwum5+wbCifmg7Padj7zHsY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=M2YM1daGL+BYxodbWCg6JMkUz/HTpIaVcxvGOORcKVtnNjy2PkK5dhW/f0TIo1Q8bV
         nD6LbqoZptFYyjsY+gruH9QOtt3wuhpbD0JKyxIhtzr7OxHX29sQ56Mqgfdv6Fs9XJD8
         oJBqc9cj2JJiCppvMNTBwhwdpxQmP/aFZC6b0=
Received: by 10.181.146.14 with SMTP id y14mr649889bkn.16.1234090555532; Sun, 
	08 Feb 2009 02:55:55 -0800 (PST)
In-Reply-To: <2c6b72b30902080247n31e5c532m31006fcb07ca95da@mail.gmail.com>
X-Google-Sender-Auth: 922f888d7e7d26bb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108954>

On Sun, Feb 8, 2009 at 11:47, Jonas Fonseca <fonseca@diku.dk> wrote:
> One problem it does not yet handle is the
> cut'n'paste within the same file where the deleted line ends up in a
> different hunk.

Hmm, this is trivially fixed by passing -M to git blame so maybe that
should just be the default for tig.

-- 
Jonas Fonseca
