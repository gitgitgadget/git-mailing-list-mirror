From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH v2] Work around curl-gnutls not liking to be
	reinitialized
Date: Sat, 9 Feb 2008 11:43:01 +0100
Organization: glandium.org
Message-ID: <20080209104301.GA32309@glandium.org>
References: <20080208220941.GA22199@glandium.org> <1202509359-23840-1-git-send-email-mh@glandium.org> <87y79usbu0.fsf@mid.deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Florian Weimer <fw@deneb.enyo.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 11:43:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNnAj-0006Ht-1H
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 11:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751827AbYBIKm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 05:42:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYBIKm0
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 05:42:26 -0500
Received: from vuizook.err.no ([85.19.215.103]:41550 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751531AbYBIKmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 05:42:25 -0500
Received: from aputeaux-153-1-42-109.w82-124.abo.wanadoo.fr ([82.124.6.109] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JNnB1-0003sj-4E; Sat, 09 Feb 2008 11:43:25 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JNnAj-0008Qf-6i; Sat, 09 Feb 2008 11:43:01 +0100
Content-Disposition: inline
In-Reply-To: <87y79usbu0.fsf@mid.deneb.enyo.de>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 2.2): No, score=2.2 required=5.0 tests=RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73207>

On Sat, Feb 09, 2008 at 10:44:55AM +0100, Florian Weimer wrote:
> * Mike Hommey:
> 
> > +#if (LIBCURL_VERSION_NUM < 0x071003) || (LIBCURL_VERSION_NUM > 0x071200)
> >  	http_cleanup();
> > +#endif
> 
> Shouldn't you check the version that is used at run time, not the one at
> compile time?

That is a very good remark, and another good reason to prefer patch v4.

Mike
