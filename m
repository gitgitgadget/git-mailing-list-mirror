From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: On PPC64, the parsing of integers on the commandline is bitshifted.
Date: Thu, 07 Aug 2008 16:26:15 -0500
Message-ID: <X68iwLodMeAo1RYVJdU3iyNzAFylpDRpP1jkviJTeiOnoNs5n2qZcg@cipher.nrlssc.navy.mil>
References: <20080807203122.GR22707@curie-int.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Aug 07 23:28:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRD1d-00074R-V0
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 23:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758745AbYHGV0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 17:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758029AbYHGV0r
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 17:26:47 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:41371 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758721AbYHGV0q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 17:26:46 -0400
Received: by mail.nrlssc.navy.mil id m77LQEdP000595; Thu, 7 Aug 2008 16:26:29 -0500
In-Reply-To: <20080807203122.GR22707@curie-int.orbis-terrarum.net>
X-OriginalArrivalTime: 07 Aug 2008 21:26:15.0792 (UTC) FILETIME=[39494F00:01C8F8D4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91606>

Robin H. Johnson wrote:
> In a 64-bit userland, big-endian environment, the parser gets integers
> wrong.

There is a fix on master. Can you try that out?
Unfortunately, looks like it did not make it into 1.5.6.5

-brandon
