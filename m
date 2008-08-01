From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn now work with crlf convertion enabled.
Date: Thu, 31 Jul 2008 22:09:08 -0700
Message-ID: <7v63qluxsb.fsf@gitster.siamese.dyndns.org>
References: <200807231544.23472.litvinov2004@gmail.com>
 <200807311257.49108.litvinov2004@gmail.com>
 <20080731104529.GE7008@dpotapov.dyndns.org>
 <200808011023.32139.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
To: Alexander Litvinov <litvinov2004@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 01 07:10:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOmuR-0002fI-Mf
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 07:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbYHAFJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 01:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757315AbYHAFJX
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 01:09:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43011 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752983AbYHAFJV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 01:09:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0D3B34217B;
	Fri,  1 Aug 2008 01:09:20 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1CC2E4217A; Fri,  1 Aug 2008 01:09:14 -0400 (EDT)
In-Reply-To: <200808011023.32139.litvinov2004@gmail.com> (Alexander
 Litvinov's message of "Fri, 1 Aug 2008 10:23:31 +0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FF5BBFE2-5F87-11DD-816A-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91028>

Alexander Litvinov <litvinov2004@gmail.com> writes:

> I dont think that disabling convertion is a good way. I really want to convert 
> my files. Possible solution is to pass two file names to git-hash-object: the 
> real file with content and the proposed file name in the working directory. 
> In this case git-hash-object will be able to make correct convertion.

I think the optional parameter to say "pretend the content is from this
path" makes sense even for (and especially for) hashing --stdin.
