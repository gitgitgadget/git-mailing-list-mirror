From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] shell doc: emphasize purpose and security model
Date: Sun, 10 Feb 2013 23:13:58 -0800
Message-ID: <20130211071358.GM15329@elie.Belkin>
References: <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <20130211035908.GA4543@sigill.intra.peff.net>
 <20130211041404.GA15329@elie.Belkin>
 <20130211041714.GA12281@sigill.intra.peff.net>
 <20130211042609.GC15329@elie.Belkin>
 <20130211043322.GA12735@sigill.intra.peff.net>
 <20130211055604.GE15329@elie.Belkin>
 <20130211055752.GF15329@elie.Belkin>
 <7vhaljpbpn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4nb0-0007g4-5a
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:14:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab3BKHOJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:14:09 -0500
Received: from mail-da0-f41.google.com ([209.85.210.41]:36065 "EHLO
	mail-da0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456Ab3BKHOG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:14:06 -0500
Received: by mail-da0-f41.google.com with SMTP id e20so2612975dak.14
        for <git@vger.kernel.org>; Sun, 10 Feb 2013 23:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=c256wsJ5gogoCIjaTcdrvgYaNUQhQKTLgpad+HoyjIo=;
        b=S6AmBP/o8ZVVQneGGDguizqqtvNT6ghHZeNtrP2jBVvzZ8S6S50h2ATURfM+K8JVQk
         77bJ2N6NkChuZ+fExbcr4OulLIhwBZ6/ncF39ymckAdNRaZqVKPMrWIXbwbtRw5Mpy2f
         UC8gSZC1sIqvqkQJKZYuMxGV+7Y0zwyyMlHoT7orhuYL4J4S/nM5MBPdryzgJ68tqCiy
         6qmVgUPOMYaa49zIjgKGrrdv350wD3UzbGKIdEpClKWWJEZZnK/4GHbmvCpxRiqcnAFG
         uS4SijDhT5GDbcWNKaL8SUWOinS0iZ3jgHSn7QM9xaWMcTAbOSf8c14zRnZQXWFkHjai
         440w==
X-Received: by 10.68.130.194 with SMTP id og2mr16446637pbb.134.1360566845693;
        Sun, 10 Feb 2013 23:14:05 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id zq5sm6787462pbc.16.2013.02.10.23.14.03
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 10 Feb 2013 23:14:04 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vhaljpbpn.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216009>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> --- a/Documentation/git-shell.txt
>> +++ b/Documentation/git-shell.txt
>> @@ -9,25 +9,61 @@ git-shell - Restricted login shell for Git-only SSH access
>>  SYNOPSIS
>>  --------
>>  [verse]
>> -'git shell' [-c <command> <argument>]
>> +'chsh' -s $(which git-shell) git
[...]
>                                               "command -v"

Sounds good.

(chsh isn't in POSIX either, FWIW. ;-))

Jonathan
