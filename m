From: Mike Hommey <mh@glandium.org>
Subject: Re: GIT_SSL_NO_VERIFY=1 over http doesn't ignore a different ip
	address for the signed certificate
Date: Thu, 21 Feb 2008 07:42:52 +0100
Organization: glandium.org
Message-ID: <20080221064252.GA16036@glandium.org>
References: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Anatoly Yakovenko <aeyakovenko@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 07:41:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS57U-0001th-J5
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 07:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753113AbYBUGkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 01:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752747AbYBUGkt
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 01:40:49 -0500
Received: from vuizook.err.no ([85.19.215.103]:37345 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbYBUGks (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 01:40:48 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JS56m-0003KP-Fo; Thu, 21 Feb 2008 07:40:47 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JS58u-0004U1-2W; Thu, 21 Feb 2008 07:42:52 +0100
Content-Disposition: inline
In-Reply-To: <e26d18e40802201535s7a5c12fbtd61d2445426f4018@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74603>

On Wed, Feb 20, 2008 at 03:35:54PM -0800, Anatoly Yakovenko wrote:
> I am not sure if its a bug in curl or git, but despite setting
> GIT_SSL_NO_VERIFY=1, if i use a different ip address or hostname then
> the certificate was signed for, git fails to push changes.

Can you try with GIT_CURL_VERBOSE=1 ? The trace message will probably
help understanding what happens.

Mike
