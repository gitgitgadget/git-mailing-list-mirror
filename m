From: Kjetil Barvik <barvik@broadpark.no>
Subject: Re: Why Git is so fast
Date: Fri, 01 May 2009 11:42:05 +0200
Organization: private
Message-ID: <86zldx88ia.fsf@broadpark.no>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com>
 <m3fxfqnxn5.fsf_-_@localhost.localdomain>
 <b4087cc50904300556s359c91dfu444fa40ea85bd66e@mail.gmail.com>
 <200904301728.06989.jnareb@gmail.com> <20090430185244.GR23604@spearce.org>
 <86iqkllw0c.fsf@broadpark.no> <20090430204033.GV23604@spearce.org>
 <8663gllt88.fsf@broadpark.no>
 <f488382f0904301723i37ef03d9w4e93848e603ed28b@mail.gmail.com>
 <864ow59o53.fsf@broadpark.no> <20090501093427.GA13264@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Steven Noonan <steven@uplinklabs.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri May 01 11:42:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzpGM-000113-LA
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 11:42:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754729AbZEAJma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 05:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754734AbZEAJma
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 05:42:30 -0400
Received: from osl1smout1.broadpark.no ([80.202.4.58]:40914 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754400AbZEAJm3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 05:42:29 -0400
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIY00247LMT5P10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Fri, 01 May 2009 11:42:29 +0200 (CEST)
Received: from localhost ([84.48.79.120]) by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KIY004NYLMRH950@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Fri, 01 May 2009 11:42:29 +0200 (CEST)
In-reply-to: <20090501093427.GA13264@glandium.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118071>

* Mike Hommey <mh@glandium.org> writes:
 <snipp>
| But your "unsigned long" version only copies 5 bytes...

  Yes, that is true...  OK, same result for hashcpy_uchar() and
  hashcpy_ulong() when corrected for this.

  --kjetil, with a brown paper bag
