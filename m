From: Johan Herland <johan@herland.net>
Subject: Re: git format-patch should honor notes
Date: Wed, 8 Dec 2010 11:12:11 +0100
Message-ID: <201012081112.12112.johan@herland.net>
References: <4CFEACC5.70005@redhat.com> <20101207221151.GC1036@sigill.intra.peff.net> <4CFF3FE4.4080104@warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <drmicha@warpmail.net>, Jeff King <peff@peff.net>,
	Eric Blake <eblake@redhat.com>,
	Thomas Rast <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 08 11:18:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQH6N-00085E-Lj
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 11:18:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145Ab0LHKSO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 05:18:14 -0500
Received: from smtp.opera.com ([213.236.208.81]:47893 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751232Ab0LHKSO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 05:18:14 -0500
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 Dec 2010 05:18:13 EST
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oB8ACC7X004361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Dec 2010 10:12:12 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4CFF3FE4.4080104@warpmail.net>
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.64 on 213.236.208.81
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163182>

On Wednesday 08 December 2010, Michael J Gruber wrote:
> Also, in order to be really useful, I would need a place to store the
> cover letter also. I was experimenting a while back with a design for
> annotating branchnames which "basically" worked but haven't had time
> to really implement it. If I remember correctly, I had to set up some
> "bogus" refs to keep my notes from being garbage collected and was
> still figuring out the best place to put them. I'll dig it up when I
> have time to.

I believe the last time the issue of adding notes to branch names was 
discussed, the consensus was that rather than using notes, they could 
be stored using a custom entry in the config file, e.g.

  git config branch.mybranch.description "Description of mybranch"

I might have misremembered this, though.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
