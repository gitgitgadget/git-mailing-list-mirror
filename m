From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: On PPC64, the parsing of integers on the commandline is bitshifted.
Date: Thu, 07 Aug 2008 16:34:00 -0500
Message-ID: <CxVxAoKmEQsrgFdHEvL0sjkgBBIVZ3Zvsl0pPSuDSfH_8xM8NOSGfw@cipher.nrlssc.navy.mil>
References: <20080807203122.GR22707@curie-int.orbis-terrarum.net> <X68iwLodMeAo1RYVJdU3iyNzAFylpDRpP1jkviJTeiOnoNs5n2qZcg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 23:38:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRDC4-0002Q6-DH
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 23:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753424AbYHGVhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 17:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753303AbYHGVhh
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 17:37:37 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:49939 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752673AbYHGVhg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 17:37:36 -0400
Received: by mail.nrlssc.navy.mil id m77LY0rZ001423; Thu, 7 Aug 2008 16:34:00 -0500
In-Reply-To: <X68iwLodMeAo1RYVJdU3iyNzAFylpDRpP1jkviJTeiOnoNs5n2qZcg@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 07 Aug 2008 21:34:00.0654 (UTC) FILETIME=[4E5D9EE0:01C8F8D5]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91607>

Brandon Casey wrote:
> Robin H. Johnson wrote:
>> In a 64-bit userland, big-endian environment, the parser gets integers
>> wrong.
> 
> There is a fix on master. Can you try that out?
> Unfortunately, looks like it did not make it into 1.5.6.5

Also, just so you know, it is test-parse-options.c that is broken, not
the parsing code. So, the rest of git should be using an int with
OPT_INTEGER() and should operate correctly.

-brandon
