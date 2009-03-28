From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How do I force git to forget about merging a binary file that is 
	to stay deleted on the target branch?
Date: Sat, 28 Mar 2009 07:46:29 -0700
Message-ID: <e38bce640903280746n1cd92a3ft252f18e845abc3db@mail.gmail.com>
References: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
	 <51419b2c0903280547y1bb5664dj70e4e6aa939bd015@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 15:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnZpK-0006Aa-2J
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 15:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbZC1Oqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 10:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755010AbZC1Oqb
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 10:46:31 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:45510 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbZC1Oqb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 10:46:31 -0400
Received: by rv-out-0506.google.com with SMTP id g37so423694rvb.5
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lddd81ooLZY0pnhpml3bY8bfGTtqoDvk4NjD4GzaB7o=;
        b=ltZbqwK5zXbCTyRJeEL+jUHbVJwD9vlGOVJFogbNCjIJv+IPMjQdjh76sYKyC3wYaF
         r6wJ/NuwuAkEYiWH8f5SGpCvzIWq3jQRJS5vcG3t8pybpnmYs8q+RF0ZAt6eO7y+6jJn
         UvflLf2tCsIdm8HLfZpVLnqkXbp0EwAZW4a58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BnJ62ecLOIYETQCe3lhgC1pWNzNtmxRmfINov88kF00/0h0WILkm/1GXouttejaT2b
         3tyJyfTRJ5AsHC2BFJ3STwkO2Yi9dg73mmc0h2DgWeZ5wQFzZrp2fT3Bxzi2SBv/nPvW
         j7nkRSL0+jG1ElyRP0yZVuwXQkjkv+1KIDbMY=
Received: by 10.141.195.9 with SMTP id x9mr1698691rvp.216.1238251589057; Sat, 
	28 Mar 2009 07:46:29 -0700 (PDT)
In-Reply-To: <51419b2c0903280547y1bb5664dj70e4e6aa939bd015@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114959>

On Sat, Mar 28, 2009 at 5:47 AM, Elijah Newren <newren@gmail.com> wrote:
> You can resolve this merge conflict by running
> $ git rm TimeSheets/Timesheet\ Exempt.XLS

Much appreciated! That works.

Thanks for your and Nanako's help!

bg
