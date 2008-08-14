From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Adding a challenge-response authentication method to
	git://
Date: Thu, 14 Aug 2008 14:00:03 -0700
Message-ID: <20080814210003.GQ3782@spearce.org>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <alpine.DEB.1.10.0808141018220.13400@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git <git@vger.kernel.org>
To: david@lang.hm
X-From: git-owner@vger.kernel.org Thu Aug 14 23:01:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTjwT-0008FB-6Q
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 23:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbYHNVAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 17:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752467AbYHNVAE
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 17:00:04 -0400
Received: from george.spearce.org ([209.20.77.23]:55003 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbYHNVAE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 17:00:04 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 762E638376; Thu, 14 Aug 2008 21:00:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0808141018220.13400@asgard.lang.hm>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92400>

david@lang.hm wrote:
> On Wed, 13 Aug 2008, Shawn O. Pearce wrote:
>
>> Isn't there some authentication frontend that some IMAP servers
>> use to handle the authentication for them?  I think last time
>> I setup bincimap it used checkpassword.  We might want to do the
>> same if we are going down this road...
>
> are you thinking of SASL?

Maybe I was.  But I think I was thinking about DJB's checkpassword
tool.  There are several tools that implement the same calling
conventions, some of which link to PAM or an LDAP database, etc.
Plus its fairly easy to create your own if you really needed a
custom solution.  You just have to be able to read fd 3.  :)

-- 
Shawn.
