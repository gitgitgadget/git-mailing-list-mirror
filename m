From: Mike Hommey <mh@glandium.org>
Subject: Re: GIT_SSL_NO_VERIFY=1 over http doesn't ignore a different ip
	address for the signed certificate
Date: Thu, 21 Feb 2008 20:09:54 +0100
Organization: glandium.org
Message-ID: <20080221190954.GA24759@glandium.org>
References: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com> <20080221064252.GA16036@glandium.org> <e26d18e40802211057o255246f3p31800c73eb8391ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 20:08:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSGmP-0001WL-4V
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 20:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbYBUTHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 14:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbYBUTHt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 14:07:49 -0500
Received: from vuizook.err.no ([85.19.215.103]:57874 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbYBUTHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 14:07:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JSGlf-0008G2-VS; Thu, 21 Feb 2008 20:07:46 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JSGnq-0008FY-9Y; Thu, 21 Feb 2008 20:09:54 +0100
Content-Disposition: inline
In-Reply-To: <e26d18e40802211057o255246f3p31800c73eb8391ec@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74644>

On Thu, Feb 21, 2008 at 10:57:58AM -0800, Anatoly Yakovenko wrote:
> yep, it tells me that the certificate is rejected because it was
> signed for a different ip then the one i am connected too.  while this
> is a security threat, browsers will let you ignore it, so i expect
> that libcurl or git should be able to ignore that error as well.

What is the exact message ?

Mike
