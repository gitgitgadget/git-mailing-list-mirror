From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitweb: add a setting to control the tabstop width
Date: Tue, 4 Mar 2008 16:35:38 +1300
Message-ID: <46a038f90803031935s7957a700nb5d3ba09b6575423@mail.gmail.com>
References: <20080303221159.GA6875@hashpling.org>
	 <7vhcfnfljw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Charles Bailey" <charles@hashpling.org>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 04:36:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWNwv-00033w-RO
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 04:36:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756639AbYCDDfl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 22:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756490AbYCDDfk
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 22:35:40 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:19974 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbYCDDfk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 22:35:40 -0500
Received: by ug-out-1314.google.com with SMTP id z38so2431944ugc.16
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 19:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iXGlJlyotY3a338V6QP2warko16ThQeD+IroiLN+IRA=;
        b=dRZkeMpHRryqFihAFvILHZS4/N/+7/NlrWZd8l6ffU7TdtgJW5YVPY3h21nntUtwz/qzJ42JmeICgdhG93vYvp06+gteWfU8m8XCJJWb8WU0j3XGJn32+YCDRTqfISRC5JkPr5wQMWwxr9VJ5VlrxV4exguUMQ2GlR/6UaMABVA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sp0mzLA4/X+zGIkK9RwWRoIYEa9QVNHxeHg541yHvibnWXW0FLSQ3Q+mVqq6iyFwFnzAeiIfU7y9IZI7Cz3t5hiWalupQuxIOmGlMpUx8WauLEc0KyOsr6DoqtmqFBtaLma49IfJymeb2jpDKIKE3PdFSi3N2haVnBX4UUR+Q0g=
Received: by 10.66.243.2 with SMTP id q2mr5294607ugh.14.1204601738790;
        Mon, 03 Mar 2008 19:35:38 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Mon, 3 Mar 2008 19:35:38 -0800 (PST)
In-Reply-To: <7vhcfnfljw.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76029>

On Tue, Mar 4, 2008 at 12:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
>  Some people say "Tabs are 8 characters, and thus indentations are also 8
>  characters.  There are heretic movements that try to make indentations 4
>  (or even 2!)  characters deep, and that is akin to trying to define the
>  value of PI to be 3."  Some people disagree.

And on the web, people use CSS to sort these disagreements amicably...
As a web apps guy, adding a setting for something like this, and then
changing the output feels _very_ weird, as it breaks with a lot of
stuff that Just Works in the HTTP+HTML world even for users that view
it differently... like caching :-)

cheers,



martin
