From: Miles Bader <miles@gnu.org>
Subject: Re: [PATCH] git-reset.txt: Use commit~1 notation over commit^
Date: Thu, 02 Dec 2010 22:17:03 +0900
Message-ID: <87mxoos4a8.fsf@catnip.gol.com>
References: <1291227258-17922-1-git-send-email-jari.aalto@cante.net>
	<1291230820.11917.25.camel@drew-northup.unet.maine.edu>
	<877hftuvvz.fsf@picasso.cante.net>
	<7vfwuhtafr.fsf@alter.siamese.dyndns.org>
	<AANLkTik8TNedGBQh7KXvRSf3HTTQf2-yMJC4VA4OOBjQ@mail.gmail.com>
	<87sjygspgy.fsf@picasso.cante.net>
	<buo39qg8zrf.fsf@dhlpc061.dev.necel.com>
	<87bp54s770.fsf@picasso.cante.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Thu Dec 02 14:17:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PO92Y-0001ae-6k
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 14:17:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757514Ab0LBNRN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 08:17:13 -0500
Received: from smtp12.dentaku.gol.com ([203.216.5.74]:33327 "EHLO
	smtp12.dentaku.gol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757491Ab0LBNRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 08:17:09 -0500
Received: from 218.231.154.28.eo.eaccess.ne.jp ([218.231.154.28] helo=catnip.gol.com)
	by smtp12.dentaku.gol.com with esmtpa (Dentaku)
	id 1PO921-0003Gh-B7; Thu, 02 Dec 2010 22:17:05 +0900
Received: by catnip.gol.com (Postfix, from userid 1000)
	id 15FB1DF97; Thu,  2 Dec 2010 22:17:03 +0900 (JST)
System-Type: x86_64-unknown-linux-gnu
In-Reply-To: <87bp54s770.fsf@picasso.cante.net> (Jari Aalto's message of "Thu,
	02 Dec 2010 14:14:11 +0200")
X-Virus-Scanned: ClamAV GOL (outbound)
X-Abuse-Complaints: abuse@gol.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162703>

Jari Aalto <jari.aalto@cante.net> writes:
>> It doesn't matter.  There needs to be a better reason than "Jari doesn't
>> like it."
>
> This has nothing to do with liking. It how infomation is read. When
> information is consistent, it lessens cognitive load.

No, it has to do with your trying to impose your personal tastes.

^ (and ^^, etc) is a simpler and easier concept to deal with, and
sufficient for the vast majority of tasks -- beyond 1 or 2 levels,
it's typically easier to just use an absolute reference cut-and-pasted
from git log output than it is to count commits and get the right
value to use with ~ (and from experience, unless you're careful, it's
very easy to get counts for ~ wrong).  So it's ~ that's the "expert
notation", not ^.

[How do I know?   Because I've _been_ a git beginner, and spent a long
time trying to learn git.]

-Miles

-- 
Discriminate, v.i. To note the particulars in which one person or thing is,
if possible, more objectionable than another.
