From: Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: Implementing CSP (Content Security Policy) for gitweb in the
 future
Date: Sun, 05 Jun 2011 08:52:30 -0400
Message-ID: <1307278350.23564.5.camel@localhost>
References: <1307177015-880-1-git-send-email-jnareb@gmail.com>
	 <1307222101.5994.13.camel@localhost>  <201106051103.59541.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 05 14:52:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTCor-0000Lv-9p
	for gcvg-git-2@lo.gmane.org; Sun, 05 Jun 2011 14:52:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab1FEMwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 08:52:34 -0400
Received: from mailbigip.dreamhost.com ([208.97.132.5]:40590 "EHLO
	homiemail-a2.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756115Ab1FEMwd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Jun 2011 08:52:33 -0400
X-Greylist: delayed 56249 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Jun 2011 08:52:33 EDT
Received: from homiemail-a2.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTP id C76FA280063;
	Sun,  5 Jun 2011 05:52:32 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=mattmccutchen.net; h=subject:from
	:to:cc:in-reply-to:references:content-type:date:message-id
	:mime-version:content-transfer-encoding; q=dns; s=
	mattmccutchen.net; b=eFRFqa9ITgdT0gOXx+nyw1FN+xD/ykBUFCmbe0CGzMh
	9kPDRDkSDAEQd28RyODruIQBZ7NIseDVoV+dYJgEVUsiMnoAZqoHaJ4fDu+1dJJx
	DR7hfzdFg803V3HuPFb3NgYckVWu3yvecVzHXJbWnzRy5j4JVz5sQHzhtbt5JW/A
	=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
	subject:from:to:cc:in-reply-to:references:content-type:date
	:message-id:mime-version:content-transfer-encoding; s=
	mattmccutchen.net; bh=mx/A2t54fO7w29lpq7ohEmgXMqM=; b=UKdBFCbfTA
	u8C9LrnTNW687xxA3fSxFcBKT55PQUkSbDHmRS9l+fMrxCX1l5AOTyAXG8JhSNs0
	A3OBy4ZxrCejP0+Tuj+bkapmqirhuzMKzSZFTUBaDjpohgV7aF0pnPYvni+H0SK+
	ecxrQfxuldzWYjV0Cf8BJqSH/6++H36vo=
Received: from [192.168.1.40] (pool-74-96-127-26.washdc.east.verizon.net [74.96.127.26])
	(using SSLv3 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: matt@mattmccutchen.net)
	by homiemail-a2.g.dreamhost.com (Postfix) with ESMTPSA id 45FE0280061;
	Sun,  5 Jun 2011 05:52:32 -0700 (PDT)
In-Reply-To: <201106051103.59541.jnareb@gmail.com>
X-Mailer: Evolution 2.32.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175074>

On Sun, 2011-06-05 at 11:03 +0200, Jakub Narebski wrote:
> In the future however it might be better solution for gitweb to implement
> (as an option) support for CSP (Content Security Policy), which IIRC did
> not exists in 2009, in addition to current $prevent_xss.

Sure.  CSP is not a substitute for designing to prevent harmful HTML
injection, but a mitigation for some of its worst effects in case some
injection points are overlooked.  There's no reason not to enable it by
default with $prevent_xss, though third parties adding functionality to
gitweb would need to know to disable it or modify the policy
accordingly.

-- 
Matt
