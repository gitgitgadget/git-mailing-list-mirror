From: Junio C Hamano <gitster@pobox.com>
Subject: Re: friendlier names
Date: Tue, 27 Jan 2009 20:51:25 -0800
Message-ID: <7vwscgvxrm.fsf@gitster.siamese.dyndns.org>
References: <87mydc6a2r.fsf@mcbain.luannocracy.com>
 <m37i4gy2z6.fsf@localhost.localdomain>
 <7vocxsy1dd.fsf@gitster.siamese.dyndns.org>
 <200901280312.16717.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	David Abrahams <dave@boostpro.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 28 05:55:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS2Se-0000Bw-Tm
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 05:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZA1Evh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2009 23:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752226AbZA1Evg
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jan 2009 23:51:36 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:41312 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbZA1Evf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2009 23:51:35 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DD01D94518;
	Tue, 27 Jan 2009 23:51:33 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 3E13394517; Tue,
 27 Jan 2009 23:51:27 -0500 (EST)
In-Reply-To: <200901280312.16717.jnareb@gmail.com> (Jakub Narebski's message
 of "Wed, 28 Jan 2009 03:12:16 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 563D8032-ECF7-11DD-8510-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107477>

Jakub Narebski <jnareb@gmail.com> writes:

> BTW with "git add" way you have to know that "git add"-ing a file
> would clear 'is in merge conflict' flags (well, will hide >0 stages...).

Sigh...

Again, you seem to be affected by the same confusion that caused you to
think "git resolved" may have some reason to exist.

An unmerged index with higer stages means that the contents that need to
be in the next commit is _unknown_ for the paths.

If somebody says "I am telling you that this path has the contents I want
to have in the commit I will create next" (which is what "staging" the
contents in the "index" is), what plausible reason does git have to keep
the higher stages for them?  At that point, the contents the user wants to
have for these paths are known.
