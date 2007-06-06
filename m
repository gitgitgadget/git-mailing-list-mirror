From: Michael Poole <mdpoole@troilus.org>
Subject: Re: [PATCH] Remove useless uses of cat, and replace with filename arguments or redirection
Date: Tue, 05 Jun 2007 23:51:52 -0400
Message-ID: <87sl957naf.fsf@graviton.dyn.troilus.org>
References: <46660F43.4060402@freedesktop.org>
	<20070606133915.d72e4afe.git@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Triplett <josh@freedesktop.org>, git@vger.kernel.org
To: Stephen Rothwell <git@ozlabs.org>
X-From: git-owner@vger.kernel.org Wed Jun 06 05:52:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvmZ4-0001PM-4O
	for gcvg-git@gmane.org; Wed, 06 Jun 2007 05:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbXFFDvy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jun 2007 23:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765801AbXFFDvy
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jun 2007 23:51:54 -0400
Received: from 24-75-174-210-st.chvlva.adelphia.net ([24.75.174.210]:48271
	"EHLO sanosuke.troilus.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753555AbXFFDvy (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Jun 2007 23:51:54 -0400
Received: by sanosuke.troilus.org (Postfix, from userid 1000)
	id E4D5E89C047; Tue,  5 Jun 2007 23:51:52 -0400 (EDT)
In-Reply-To: <20070606133915.d72e4afe.git@ozlabs.org> (Stephen Rothwell's message of "Wed\, 6 Jun 2007 13\:39\:15 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49240>

Stephen Rothwell writes:

> On Tue, 05 Jun 2007 18:34:59 -0700 Josh Triplett <josh@freedesktop.org> wrote:
>>
>> -commits=$(cat ../revs | wc -l | tr -d " ")
>> +commits=$(wc -l ../revs | tr -d " ")
>
> This is not equivalent, you probably wanted:
>
> commits=$(wc -l <../revs | tr -d " ")

Which relevant version(s) of wc do not accept filename arguments?
POSIX[1] seems to specify it.  Or do you mean that there is some
subtle difference in its processing of stdin vs specified files?

[1]- http://www.opengroup.org/onlinepubs/000095399/utilities/wc.html

Michael Poole
