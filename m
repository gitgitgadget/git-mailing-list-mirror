From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: conflict status
Date: Tue, 04 Aug 2009 00:19:21 -0700 (PDT)
Message-ID: <m34osoqc5p.fsf@localhost.localdomain>
References: <DDAD985F-C9CA-4159-B382-354D4B082C19@users.sourceforge.net>
	<fabb9a1e0908031037t16a828f6h4de9fb11bcc957fe@mail.gmail.com>
	<200908032017.35101.trast@student.ethz.ch>
	<7vvdl4925k.fsf@alter.siamese.dyndns.org>
	<4F52523A-2CEA-4CD3-A094-A2627E2A4403@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Sverre Rabbelier <srabbelier@gmail.com>, <git@vger.kernel.org>
To: Michael Wild <themiwi@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:19:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYEJ0-0001eu-N4
	for gcvg-git-2@gmane.org; Tue, 04 Aug 2009 09:19:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbZHDHTX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2009 03:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbZHDHTX
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 03:19:23 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48499 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932494AbZHDHTW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2009 03:19:22 -0400
Received: by bwz19 with SMTP id 19so2901732bwz.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 00:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=7x6FBZDY/f3pZ0EPEPvhWImFC++vd3WWUOX9C8IIKtg=;
        b=CWgiPJN33+zLcY8+OkPiVPZO6k1nYVFow9Acu6g4cYbkMF0Hn//xWAJcrReDuln1bn
         9ryhJGbFvJF1rIGOn3dT9+kufdJIlDsaonp73AtaIXC3otsSbI3BOFOIfanlFEOhIjp3
         ikPLOktghBpAFg/AHEZJW0b80x7cSWKXCCC3I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=a+WnYglVSrfcmZWL9nEBfLfu/9gmJth27Wof7VVi20eBLB+5yWai5rFmUyiKPZ4Nyn
         DI72OK7o1oHDYkhSJkb9cQW5MFqdiwmGU39cB9o6NBd69ZKeePc2m2dlnOhdvhTMLa6F
         /AEIAccefdwC9yDLrRufHSSemwW/QYVmC5VvQ=
Received: by 10.204.52.5 with SMTP id f5mr241313bkg.203.1249370362344;
        Tue, 04 Aug 2009 00:19:22 -0700 (PDT)
Received: from localhost.localdomain (abwk147.neoplus.adsl.tpnet.pl [83.8.234.147])
        by mx.google.com with ESMTPS id g28sm10346127fkg.15.2009.08.04.00.19.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 Aug 2009 00:19:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n747JH4x023829;
	Tue, 4 Aug 2009 09:19:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n747JEtM023826;
	Tue, 4 Aug 2009 09:19:14 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4F52523A-2CEA-4CD3-A094-A2627E2A4403@users.sourceforge.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124764>

Michael Wild <themiwi@users.sourceforge.net> writes:
> On 3. Aug, 2009, at 20:35, Junio C Hamano wrote:
>> Thomas Rast <trast@student.ethz.ch> writes:
>>
>>> That only shows 'unmerged: foo' for me...
>>>
>>> The closest to porcelain I can get while still having all the
>>> information is
>>>
>>>  $ git ls-files -s foo
>>>  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 1       foo
>>>  100644 d00491fd7e5bb6fa28c517a0bb32b8b506539d4d 2       foo
>>>
>>> In other words, not porcelain at all.
>>
>> "git ls-files -u" would be what you want.  It shows all the paths with
>> conflicts in the index, and omits paths without conflicts in the
>> index.
>>
>> And the object names allow you to inspect the individual stages.
>>
> 
> 
> I found out about that one too (by having a look at git-mergetool),
> and came up with the following quick hack (doesn't take any arguments/
> options, is very rough and slow for a large number of conflicts). For
> each unmerged file it displays the file name, prefixed with the local
> and remote state. Possible states are "c" for created, "m" for
> modified and "d" for deleted. Probably there are other cases I'm not
> aware of and require special handling.

If you don't need SHA-1s, why not use -t or -v option of git-ls-files,
e.g.:

  $ git ls-files -v -u

-- 
Jakub Narebski
Poland
ShadeHawk on #git
