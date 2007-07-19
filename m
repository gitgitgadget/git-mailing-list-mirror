From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: snapshot cleanups & support for offering multiple formats
Date: Thu, 19 Jul 2007 00:40:07 -0700 (PDT)
Message-ID: <513314.51284.qm@web31813.mail.mud.yahoo.com>
References: <200707190930.57019.jnareb@gmail.com>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Matt McCutchen <hashproduct@gmail.com>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 19 09:40:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBQcg-00037L-8S
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 09:40:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757071AbXGSHkL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 03:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757264AbXGSHkK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 03:40:10 -0400
Received: from web31813.mail.mud.yahoo.com ([68.142.207.76]:41841 "HELO
	web31813.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757029AbXGSHkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jul 2007 03:40:09 -0400
Received: (qmail 52231 invoked by uid 60001); 19 Jul 2007 07:40:07 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=dgn0RORLsL6T4v3LPpGpxNAL+xdGmUaCFVix0RbjBRGRzdwnWbFKklNDLw6Fcl6C9WlAYKzzTkhbkHW2nEcvbhD/FcMjK42davL5LjN4shK93kM/s4woGwt9RfkSSRTpdCUJq3kuqqalKtmYa7dvb1QLs9pMalwG7Iu5gCRMxhQ=;
X-YMail-OSG: wcrMqYsVM1nns6wX9WG08JngAOd4LfHRPQqwHPzqjD2S9ElqCiIzuYtAZMohapq2UNcS8Q--
Received: from [68.186.61.63] by web31813.mail.mud.yahoo.com via HTTP; Thu, 19 Jul 2007 00:40:07 PDT
In-Reply-To: <200707190930.57019.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52949>

--- Jakub Narebski <jnareb@gmail.com> wrote:
> Luben Tuikov wrote:
> 
> > I wouldn't mind an improvement in the snapshot area of gitweb.
> > I wasn't really happy with the snapshot feature as it was originally
> > implemented, as it would generate a tar file with ".tar.bz2"
> > name extension, but the file was NOT bz2, and I had to always
> > manually rename, bz2, and rename back.
> 
> This was a *bug*, but it is now corrected (in 9aa17573). Gitweb used 
> Content-Encoding, which is meant for _transparent_ compression.

Yeah, that's what I suspected, since there was nothing obviously
wrong with the code.

Thanks for the fix.

   Luben
