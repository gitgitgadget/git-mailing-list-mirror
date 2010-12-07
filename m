From: Casey Dahlin <cdahlin@redhat.com>
Subject: Re: [PATCH] logging branch deletion to help recovering from mistakes
Date: Tue, 7 Dec 2010 12:54:18 -0500
Message-ID: <20101207175418.GU355@fearengine.rdu.redhat.com>
References: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
 <20101207162358.GT355@fearengine.rdu.redhat.com>
 <20101207174520.GB21483@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Casey Dahlin <cdahlin@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 07 18:54:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQ1kb-0006Lv-12
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 18:54:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751727Ab0LGRyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 12:54:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:10363 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750819Ab0LGRyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 12:54:46 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id oB7HsKOn024607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 7 Dec 2010 12:54:20 -0500
Received: from fearengine.rdu.redhat.com (dhcp243-150.rdu.redhat.com [10.11.243.150])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id oB7HsIML004309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Tue, 7 Dec 2010 12:54:20 -0500
Content-Disposition: inline
In-Reply-To: <20101207174520.GB21483@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163097>

On Tue, Dec 07, 2010 at 11:45:20AM -0600, Jonathan Nieder wrote:
> Casey Dahlin wrote:
> 
> > Could commits made onto a detached head also show up here? Or is that
> > better thwarted with another mechanism?
> 
> I think that's better thwarted with the HEAD reflog:
> 
> 	$ git log -g HEAD

I was more worried about changes that were made onto a detached head,
and then the head was reattached, leaving the new commits dangling.

The end result is identical to a deleted branch, just wondering if we
should note it in the same place.

--CJD
