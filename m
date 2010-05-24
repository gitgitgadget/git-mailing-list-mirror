From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: [PATCH 3/7] Add buffer pool library
Date: Mon, 24 May 2010 20:37:59 +1000
Message-ID: <59ECADA1-5F48-4C0E-B3C5-C2F7D7687C8F@cordelta.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com>  <1274650832-7411-4-git-send-email-artagnon@gmail.com> <20100524074757.GC3412@m62s10.vlinux.de> <AANLkTim8olZLKoi4Uk_nPpxhCYKX7b_yUDBrWVW_rm57@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Peter Baumann <waste.manager@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 24 12:38:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGV2z-0000X6-1t
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 12:38:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755755Ab0EXKiH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 06:38:07 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48692 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755542Ab0EXKiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 06:38:05 -0400
Received: by pvg4 with SMTP id 4so732208pvg.19
        for <git@vger.kernel.org>; Mon, 24 May 2010 03:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=O6sPEEH65DSulebK6IGUwtOyqEOhl9jtyTzo7As6QMo=;
        b=rtJTeqPKu45BNFBZxYZdWUtK/Iprz86sAD7ZqnfZHWlIaCDtLSJ5VRJ9pFcju7OYux
         APf1xEyUAz4/O1r1BKUk2FZOBGbpcqN0GWTx57i8LuDZr/opfYOLw/SOFy/b7+rR1MTe
         Lyvg7JowaCS8FlkSDUDyQcM3FayYRRU00nr3Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=m7Bqng15+4E4CfkzxmUAOUSzQQwFyt+MSx91zxnSmpWDPuTHDCA/cVQj0a040O41eg
         OI/bYL796J5LfJSf/ej+BbYaHvCnhO/XKeKWuvnlspiGhUlLSXntG35oPJUnfwjk3A/U
         ZquCLg2QYTK7X8EA7Ns3G8z2uugPFTUnlqEq0=
Received: by 10.115.38.23 with SMTP id q23mr4675539waj.212.1274697484409;
        Mon, 24 May 2010 03:38:04 -0700 (PDT)
Received: from [192.168.1.2] (d122-109-106-179.mit3.act.optusnet.com.au [122.109.106.179])
        by mx.google.com with ESMTPS id d16sm37382319wam.0.2010.05.24.03.38.02
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 24 May 2010 03:38:03 -0700 (PDT)
In-Reply-To: <AANLkTim8olZLKoi4Uk_nPpxhCYKX7b_yUDBrWVW_rm57@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147624>

Hi,

> @David: I'll take the responsibility of cleaning it up/ modifying it
> and getting it merged into git.git. You can work on the repository
> independently, and I'll pull relevant changes into git.git.

@Ram: On that note, can you sign off on your patches so I can
merge them.

>> If this is David's code, shouldn't you then preserve authorship?


[PATCH 2/7] Add cpp macro implementation of treaps
Authored mostly by Jason Evans.
Heavily culled and adapted to use the object pool library by
David Barr.

[PATCH 7/7] Add handler for SVN dump
Originally authored by in Java by Stefan Hegny and others.
Ported to C and rewritten by David Barr.

Both released under two clause BSD licenses.

Patches 3 to 6 authored primarily by David Barr with
contributions in the form of cleanup and documentation from
Ramkumar Ramachadra.
Released under two-clause BSD license but easily relicensed
due to proximity of authors.

-- David Barr.
