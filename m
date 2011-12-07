From: Pete Wyckoff <pw@padd.com>
Subject: Re: [RFC PATCH] git-p4: introduce asciidoc documentation
Date: Wed, 7 Dec 2011 10:36:59 -0500
Message-ID: <20111207153659.GA16841@arf.padd.com>
References: <20111203235328.GA3866@arf.padd.com>
 <4EDF3611.3000902@diamand.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Wed Dec 07 16:37:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYJYV-0005kG-2E
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 16:37:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab1LGPhE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 10:37:04 -0500
Received: from honk.padd.com ([74.3.171.149]:40275 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756478Ab1LGPhD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 10:37:03 -0500
Received: from arf.padd.com (unknown [50.52.169.245])
	by honk.padd.com (Postfix) with ESMTPSA id 8082CEE;
	Wed,  7 Dec 2011 07:37:02 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 93FE4313E6; Wed,  7 Dec 2011 10:36:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4EDF3611.3000902@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186464>

luke@diamand.org wrote on Wed, 07 Dec 2011 09:46 +0000:
> On 03/12/11 23:53, Pete Wyckoff wrote:
> >Add proper documentation for git-p4.  Delete the old .txt
> >documentation from contrib/fast-import.
> >---
> >+------------
> >+$ cd project
> >+$ vi foo.h
> 
> I think it works with other editors as well, although I've not tried
> it myself. Obviously with reduced functionality :-)

Quite.  :)

> >+git-p4.allowSubmit::
> >+	By default, any branch can be used as the source for a 'git p4
> >+	submit' operation.  This configuration variable , if set, permits only
> 
> Spacing around comma in "variable , if set"

Thanks, queued up.

I've got 8 more patches to the docs and code, adding unit tests
as I figure out quirks of all the existing options for
sync/clone.  I'll continue with the submit options next then
send them all out for review.

		-- Pete
