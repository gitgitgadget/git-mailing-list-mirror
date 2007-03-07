From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH, 2nd version] git-archimport: allow remapping branch names
Date: Wed, 07 Mar 2007 01:33:35 -0800
Message-ID: <7vwt1tfle8.fsf@assigned-by-dhcp.cox.net>
References: <eslrcr$9rc$1@sea.gmane.org>
	<7vodn5iiew.fsf@assigned-by-dhcp.cox.net>
	<45EE7442.6030308@lu.unisi.ch>
	<7vlki9h1mg.fsf@assigned-by-dhcp.cox.net>
	<45EE80B0.8010403@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bonzini@gnu.org
X-From: git-owner@vger.kernel.org Wed Mar 07 10:34:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOsX2-000759-St
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 10:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422664AbXCGJdh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 04:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbXCGJdh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 04:33:37 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:51139 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422664AbXCGJdg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 04:33:36 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070307093335.GNOU3546.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Wed, 7 Mar 2007 04:33:35 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XlZb1W0091kojtg0000000; Wed, 07 Mar 2007 04:33:35 -0500
In-Reply-To: <45EE80B0.8010403@lu.unisi.ch> (Paolo Bonzini's message of "Wed,
	07 Mar 2007 10:06:56 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41661>

Paolo Bonzini <paolo.bonzini@lu.unisi.ch> writes:

>> Just to make sure.  Was it tested with AND WITHOUT the new colon
>> feature?  I am asking how likely is there a regression.
>
> Yes.  But my Arch repositories do not have colons in the name (I mean I tested on real-world repositories and not weird ones created exactly to make the patch fail).

That's fine.

> In this case, this input will always be of the form t--a/g--REVISION.
>
> So the old one would change to t--a,g--REVISION; the new one would
> strip to t--a/g and convert it to t--a,g (using git_default_branchname)
> and file tack --REVISION at the end again.

Ah, thanks.
