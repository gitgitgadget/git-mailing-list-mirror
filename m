From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] config: add --repository option
Date: Tue, 2 Jun 2009 18:38:59 +0200
Message-ID: <fabb9a1e0906020938h73a49ecbr5a7c78e30c8ec6d7@mail.gmail.com>
References: <1241886936-18941-1-git-send-email-srabbelier@gmail.com> 
	<20090602195555.6117@nanako3.lavabit.com> <7vskiifyd5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 18:39:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBX1P-0001LH-GO
	for gcvg-git-2@gmane.org; Tue, 02 Jun 2009 18:39:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753880AbZFBQjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 12:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753555AbZFBQjV
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 12:39:21 -0400
Received: from mail-ew0-f224.google.com ([209.85.219.224]:62701 "EHLO
	mail-ew0-f224.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753191AbZFBQjU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 12:39:20 -0400
Received: by ewy24 with SMTP id 24so8854040ewy.37
        for <git@vger.kernel.org>; Tue, 02 Jun 2009 09:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=yiLxKWWExV0su0snCMqabaQfe29rxvkC2cPPkZSUjIA=;
        b=xhlW5YQxHtlvKyREA8bTHCw5vtxMGCK2Urf9sNLXD7lP6RkafnkfC4VRZinP3FWMZs
         H0ze8sUQnHFVFZnUR3F0wlIT7uCxfxij4T1S2ekyoMzH51Gt5d7HKoRfCkXfBTchBduo
         XvTyRRGI6s1TPFSWI1f0ZqM1Aonr4X50zXGOU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ID0Us9rCADx0VWhwIa0tWCh1o4r+2vpkIzSk+m3FM8sAzpaywviQ3yiyzG615CnEko
         L+89pVbL7oiYdwCjqbGQdkDHpR/A9SQucp2J32OJmyOUnxYeYQhTQ80Bl/WiLVqC+eBK
         Kbg9MiSeA8634poOTzGS1+iFRYSygdSbP+Pb4=
Received: by 10.216.21.205 with SMTP id r55mr2343996wer.175.1243960760506; 
	Tue, 02 Jun 2009 09:39:20 -0700 (PDT)
In-Reply-To: <7vskiifyd5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120527>

Heya,

On Tue, Jun 2, 2009 at 17:29, Junio C Hamano <gitster@pobox.com> wrote:
> I somehow think --repository is much harder to type than --local, and in
> the context of the command, somehow --local would mesh better with other
> existing options --system and --global, but that comment falls into the
> bikeshedding category.

Ha! I had --local at first, but then figured that might be confusing
since 'local' usually refers to 'on my machine', rather than 'in this
repository'. I'm fine with either.

-- 
Cheers,

Sverre Rabbelier
