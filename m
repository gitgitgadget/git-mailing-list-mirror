From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: handle filenames with double slashes better
Date: Thu, 21 May 2009 12:22:16 -0700
Message-ID: <7vws8a9s7r.fsf@alter.siamese.dyndns.org>
References: <20090521122511.GA31614@sepie.suse.cz>
	<7vd4a2bj3p.fsf@alter.siamese.dyndns.org>
	<20090521191204.GA29362@sepie.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 21 21:23:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7Dr3-0000tm-95
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 21:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754004AbZEUTWU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 15:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753654AbZEUTWU
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 15:22:20 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:39460 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753362AbZEUTWT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 15:22:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090521192217.NNDE17670.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 May 2009 15:22:17 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id uKNG1b00K4aMwMQ03KNGwg; Thu, 21 May 2009 15:22:16 -0400
X-Authority-Analysis: v=1.0 c=1 a=YytS7IVUZiMA:10 a=MBz2rtpSkVcA:10
 a=rtW5m38tb8FSwb90NdoA:9 a=MCRtbqmO-zdkzDump98cu3lj6JYA:4
X-CM-Score: 0.00
In-Reply-To: <20090521191204.GA29362@sepie.suse.cz> (Michal Marek's message of "Thu\, 21 May 2009 21\:12\:04 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119703>

Michal Marek <mmarek@suse.cz> writes:

> I tried this, but I'm not sure it's better now (and there might be some
> inconsistencies left). IMHO removing the double slashes is an operation
> similar to the unquoting done in find_name(), i.e. converting the text
> in the patch to something that can be passed to lstat() or
> cache_name_lookup().

Ok, you convinced me.

Let's take your first patch with just the s/canon_name/squash_slash/
change.

Thanks.
