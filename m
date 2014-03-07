From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v6 02/11] trailer: process trailers from stdin and
 arguments
Date: Fri, 7 Mar 2014 11:08:50 +0300
Message-ID: <20140307080850.GC4774@mwanda>
References: <20140304193250.14249.56949.chriscool@tuxfamily.org>
 <20140304194810.14249.7378.chriscool@tuxfamily.org>
 <xmqqiors1cn4.fsf@gitster.dls.corp.google.com>
 <CAP8UFD3pg7xeFok6wKPc=iP3D87qhZwyOJm=kiUnAj09NcUJKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 09:10:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLpr8-0005z2-Dm
	for gcvg-git-2@plane.gmane.org; Fri, 07 Mar 2014 09:10:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416AbaCGIKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Mar 2014 03:10:03 -0500
Received: from userp1040.oracle.com ([156.151.31.81]:47414 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751276AbaCGIKC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Mar 2014 03:10:02 -0500
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id s27894Rb025225
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 7 Mar 2014 08:09:05 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s27890xR026746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 7 Mar 2014 08:09:02 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id s278909G026741;
	Fri, 7 Mar 2014 08:09:00 GMT
Received: from mwanda (/41.202.240.6)
	by default (Oracle Beehive Gateway v4.0)
	with ESMTP ; Fri, 07 Mar 2014 00:08:59 -0800
Content-Disposition: inline
In-Reply-To: <CAP8UFD3pg7xeFok6wKPc=iP3D87qhZwyOJm=kiUnAj09NcUJKQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Source-IP: acsinet21.oracle.com [141.146.126.237]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243607>

On Fri, Mar 07, 2014 at 07:19:15AM +0100, Christian Couder wrote:
> On Wed, Mar 5, 2014 at 11:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > This round is marked as the sixth, but I still see quite a many
> > style issues, which I expect not to see from long timers without
> > being told.  Somewhat disappointing...
> 
> Yeah, I don't know why, but these days I find it very hard to review
> style issues in my own code without being distracted.
> And by the way is there a good script to check them?

Many of these would have been caught with kernel.org's checkpatch.pl
script.

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/plain/scripts/checkpatch.pl

regards,
dan carpenter
