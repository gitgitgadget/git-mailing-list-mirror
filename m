From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [RFCv2/FYI] git-sequencer.txt
Date: Thu, 12 Jun 2008 22:04:41 -0700
Message-ID: <4851FFE9.30108@gnu.org>
References: <20080607220101.GM31040@leksak.fem-net> <20080612002258.GC7200@leksak.fem-net> <7vabhr9qru.fsf@gitster.siamese.dyndns.org> <20080612170715.GC6848@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 07:06:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K71UM-0004YL-Ic
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 07:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbYFMFEo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 01:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbYFMFEo
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 01:04:44 -0400
Received: from rv-out-0506.google.com ([209.85.198.230]:23825 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750699AbYFMFEn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 01:04:43 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2360317rvb.1
        for <git@vger.kernel.org>; Thu, 12 Jun 2008 22:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=ujL30Vaoz8dr3UeJXLYJkWCRK26j9Rd9jYSaGYtm9VQ=;
        b=uybiXjco7+i2pULa6u2XsuzrM7PBQkgJWjVZahG2Kv35lm7Y9baCj58vYpPx9CyCCb
         6+Zo+EvYSMuxbvT0gD1oL+kSSkg2vzMFRXI/Ch1dGOzFdQJFJV7X1QpVgis6F0EUQhVi
         X84D8YQb2pIyHKcE+vmSgWvw+So71JJ16yA8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=YMiyCXEc+HeGF0NBYX/77rYY1/rM4zxLrgdjpDctDB3bOTQg30pUHDZxtTv5ydVDmB
         H3utXla9CSSuhalqR3fInFgST+dY3/7YsfyxbK3Q3gguwHWsYuqnNylsUAWYVKYmU92C
         4c+NVl/+yeg1K4FPNaW3peG6we25gckUink6w=
Received: by 10.141.71.14 with SMTP id y14mr1535632rvk.253.1213333481217;
        Thu, 12 Jun 2008 22:04:41 -0700 (PDT)
Received: from scientist-2.local ( [65.248.49.163])
        by mx.google.com with ESMTPS id f42sm2976993rvb.5.2008.06.12.22.04.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 12 Jun 2008 22:04:40 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.14 (Macintosh/20080421)
In-Reply-To: <20080612170715.GC6848@leksak.fem-net>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84831>


> squash [<options>] --from <mark>::
> 	Squash all commits from the given mark into one commit.
> 	There must not be any `merge` instructions between the
> 	`mark` instruction and this `squash --from` instruction.

--after maybe?

Paolo
