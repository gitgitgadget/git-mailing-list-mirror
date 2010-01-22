From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: Re: git-archive ignores export-ignore
Date: Fri, 22 Jan 2010 10:07:57 -0800
Message-ID: <20100122180757.GD5307@penguin.codegnome.org>
References: <20100121221312.GB5307@penguin.codegnome.org>
	<7vocknhs70.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 19:08:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYNvW-00042G-Mq
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 19:08:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756022Ab0AVSIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 13:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755909Ab0AVSIB
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 13:08:01 -0500
Received: from mta31.charter.net ([216.33.127.82]:33870 "EHLO
	mta31.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755881Ab0AVSIA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 13:08:00 -0500
X-Greylist: delayed 71677 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jan 2010 13:08:00 EST
Received: from imp11 ([10.20.200.11]) by mta31.charter.net
          (InterMail vM.7.09.02.04 201-2219-117-106-20090629) with ESMTP
          id <20100122180759.UVKY1847.mta31.charter.net@imp11>
          for <git@vger.kernel.org>; Fri, 22 Jan 2010 13:07:59 -0500
Received: from penguin.codegnome.org ([71.83.124.90])
	by imp11 with smtp.charter.net
	id Yi7y1d0011x8DgP05i7yVl; Fri, 22 Jan 2010 13:07:59 -0500
X-Authority-Analysis: v=1.0 c=1 a=VUtgQAhiK5IA:10 a=iw0a9BV3ZkGXhRnwd5IA:9
 a=-8-KCl09rPDSzDWiBw71EU6WAw4A:4
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id BB23637CB2; Fri, 22 Jan 2010 10:07:57 -0800 (PST)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Fri, 22 Jan 2010 10:07:57 -0800
Content-Disposition: inline
In-Reply-To: <7vocknhs70.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137770>

On Thu, Jan 21, 2010 at 04:57:39PM -0800, Junio C Hamano wrote:

> There is something that is different in my failed attempt to reproduce it
> from your problem description, but I cannot tell what it is.
> 
> Do you have some garbage character immediately after "e" in "-ignore"?

No, but it turns out that juniperxml.cfg is actually a symlink in this
repository. I'm not sure that should make a difference, but perhaps
that's the missing element in recreating the problem.

I wouldn't think so, because the reason it's a symlink is because I was
unable to get git-archive to ignore the actual file on export, so I
moved it elsewhere and replaced it with a symlink so that the contents
of the file weren't exported.

Hope that helps!

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
