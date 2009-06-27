From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv6 4/8] gitweb: (gr)avatar support
Date: Sat, 27 Jun 2009 02:32:09 +0200
Message-ID: <cb7bb73a0906261732k57b78052ud8b96a550de52cd5@mail.gmail.com>
References: <1245926587-25074-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200906270058.16686.jnareb@gmail.com>
	 <cb7bb73a0906261614x3a5dab02h1f29d68b6f5005b1@mail.gmail.com>
	 <200906270125.25048.jnareb@gmail.com>
	 <7vhby2o6xy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 27 02:32:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKLq7-00035z-Vq
	for gcvg-git-2@gmane.org; Sat, 27 Jun 2009 02:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753673AbZF0AcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2009 20:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753464AbZF0AcI
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jun 2009 20:32:08 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:35531 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbZF0AcI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2009 20:32:08 -0400
Received: by bwz9 with SMTP id 9so2312324bwz.37
        for <git@vger.kernel.org>; Fri, 26 Jun 2009 17:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KTksEHb5k7uwx0T8dIjWfR2X/VX4XyhqLTeUcNGD67k=;
        b=lVjVKfq9qW+wb9+IiPlEcmF3qjbpaj2sTZRsa9LI0cmXImLHvUPmsz0NRZej79UtXE
         tLtrNtHAhZRM13bNFvZfCc/IWb/my6K/m5kyLKbWbUN67eWONoZrkGccAvKxD/JdEEok
         BEgaLDRV/U1rY+suqKoJfMD5JSB9KPuRmDPaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N88HnW9FHyPv92CIRqndudU15JHp6nSz3gzMwhaSvB8UiumeHGgZDlMya3Nqgz5KlR
         H2OVAJIRwTLRiNDT8ZYKNhI85n31BOKfev5gjQ4C7ntoKsauzAlc4Joz9ehHz1QawLqF
         TcU5RJYKnoXFToU53rHRCdE2i4MyB3aicB1+A=
Received: by 10.204.98.195 with SMTP id r3mr2013990bkn.128.1246062729891; Fri, 
	26 Jun 2009 17:32:09 -0700 (PDT)
In-Reply-To: <7vhby2o6xy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122344>

On Sat, Jun 27, 2009 at 2:29 AM, Junio C Hamano<gitster@pobox.com> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>
>> I'm not sure if having picons as 'default' for gravatar is a good idea,
>> because the rules for resolving picons are complicated[1]... which
>> I didn't realize when writing this (sketch of) idea.
>>
>> [1] http://www.cs.indiana.edu/picons/ftp/faq.html
>
> Also picons these days look somewhat antiquated with its rather strict
> limitation to the colormaps (IIRC, you practically have to go grayscale if
> you want to use a real photo), and it would make sense to try gravatar
> first and then fall back to picons.

That's what gravatar's default is for: if the image is not set, use
whatever is provided as default (with this patch, the picon).


-- 
Giuseppe "Oblomov" Bilotta
