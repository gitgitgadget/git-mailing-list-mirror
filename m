From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [PATCH v2] Work around curl-gnutls not liking to be reinitialized
Date: Sat, 09 Feb 2008 10:44:55 +0100
Message-ID: <87y79usbu0.fsf@mid.deneb.enyo.de>
References: <20080208220941.GA22199@glandium.org>
	<1202509359-23840-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 09 11:10:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNmet-0006uo-FM
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 11:10:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbYBIKJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 05:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754052AbYBIKJd
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 05:09:33 -0500
Received: from mail.enyo.de ([212.9.189.167]:4610 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbYBIKJd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 05:09:33 -0500
X-Greylist: delayed 1474 seconds by postgrey-1.27 at vger.kernel.org; Sat, 09 Feb 2008 05:09:33 EST
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1JNmGW-0003Kt-8o
	for git@vger.kernel.org; Sat, 09 Feb 2008 10:44:56 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.69)
	(envelope-from <fw@deneb.enyo.de>)
	id 1JNmGV-0002q3-8H
	for git@vger.kernel.org; Sat, 09 Feb 2008 10:44:55 +0100
In-Reply-To: <1202509359-23840-1-git-send-email-mh@glandium.org> (Mike
	Hommey's message of "Fri, 8 Feb 2008 23:22:39 +0100")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73205>

* Mike Hommey:

> +#if (LIBCURL_VERSION_NUM < 0x071003) || (LIBCURL_VERSION_NUM > 0x071200)
>  	http_cleanup();
> +#endif

Shouldn't you check the version that is used at run time, not the one at
compile time?
