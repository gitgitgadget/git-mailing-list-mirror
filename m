From: "David E. Wheeler" <david@justatheory.com>
Subject: Re: Bad Man Page URLs
Date: Thu, 26 Apr 2012 13:12:38 -0700
Message-ID: <BCD7B631-8C73-4F3F-AB37-9B5CF02655D5@justatheory.com>
References: <2AC038A1-3D8D-425E-92B3-DADFD027761A@justatheory.com>
 <20120406023223.GB16264@sigill.intra.peff.net>
 <20120406025457.GA23997@sigill.intra.peff.net>
 <20120406042215.GA3938@burratino>
 <20120406054637.GA25301@sigill.intra.peff.net>
 <7vzkap1gck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 22:12:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNV3a-0000pR-3G
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 22:12:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756858Ab2DZUMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Apr 2012 16:12:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753398Ab2DZUMn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Apr 2012 16:12:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 221916C41;
	Thu, 26 Apr 2012 16:12:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=subject
	:mime-version:content-type:from:in-reply-to:date:cc
	:content-transfer-encoding:message-id:references:to; s=sasl; bh=
	BWNGeiEKBorK5f2slZgXuXLW84c=; b=BULusV8fUrcYImM2ONXHGWJgbijGikME
	S3Xet0nWcBIU69Ug/t+kPhDGdYymk7enzCou8R+DQnBlLXMqtgAquHWICdELCHQm
	iSVeqSStnUufXOB0skvZkszS+EpeCJj0R9L4xXk2CI8W1gvfIT8xtnVXUMhCj9Qa
	SohOiMzzyRA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18AD86C40;
	Thu, 26 Apr 2012 16:12:43 -0400 (EDT)
Received: from hydrogen.iovation.com (unknown [74.121.28.6]) (using TLSv1
 with cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F323D6C3F; Thu, 26 Apr 2012
 16:12:39 -0400 (EDT)
In-Reply-To: <7vzkap1gck.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
X-Pobox-Relay-ID: 2CB1C742-8FDC-11E1-BB5C-FC762E706CDE-76319746!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196405>

On Apr 6, 2012, at 12:15 AM, Junio C Hamano wrote:

>> Junio, what do you think of building the git-manpages-* tarballs (and
>> the git-manpages repo) with MAN_BASE_URL set to "http://some-official-place/"?
>> As of now, they mention "file:///home/junio/...".
> 
> I think git-manpages repo already sets the base to the old k.org location
> (see dodoc.sh in the 'todo' branch), but I forgot about that setting when
> I cobbled together the tarball releasing script to be run on my home box
> in a hurry. The releases used to be cut on a k.org machine and I initially
> planned to stop generating the manpage/html tarballs when we lost shell
> access to it, but some distro people demanded it, so...
> 
> I do not know how well things would behave if we set it to "git-htmldocs/"
> as Jonathan suggests, but we will see what happens.
> 
> I think there is no need to patch any Makefile; the make variable is
> designed to be overridable by the callers of make, so patches should go to
> either 'dodoc.sh' or the tarball release scripts, which are not checked in
> to the 'todo' branch yet, but I will do so if I remember ;-).
> 
> FWIW, here is the (updated) 'RelBuild' script.

Don't know if you've applied this fix, but I just downloaded the 1.7.10 man pages, and they URLs are now:

        1. Everyday Git
           git-htmldocs/everyday.html

        2. Git User's Manual
           git-htmldocs/user-manual.html

        3. git concepts chapter of the user-manual
           git-htmldocs/user-manual.html#git-concepts

        4. howto
           git-htmldocs/howto-index.html

        5. GIT API documentation
           git-htmldocs/technical/api-index.html

Which also aren't very useful. :-(

David
