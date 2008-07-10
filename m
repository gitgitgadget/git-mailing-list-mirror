From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH 2/4] git-imap-send: Add support for SSL.
Date: Thu, 10 Jul 2008 07:33:17 +0200
Organization: glandium.org
Message-ID: <20080710053317.GC24520@glandium.org>
References: <1215638942-25010-2-git-send-email-robertshearman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Shearman <rob@codeweavers.com>
To: Robert Shearman <robertshearman@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 07:34:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGonY-00044B-S9
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 07:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624AbYGJFd0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 01:33:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbYGJFd0
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 01:33:26 -0400
Received: from vuizook.err.no ([194.24.252.247]:39272 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300AbYGJFdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 01:33:25 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KGomI-0001G1-Az; Thu, 10 Jul 2008 07:33:20 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KGomL-0006d9-HW; Thu, 10 Jul 2008 07:33:17 +0200
Content-Disposition: inline
In-Reply-To: <1215638942-25010-2-git-send-email-robertshearman@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87939>

On Wed, Jul 09, 2008 at 10:29:00PM +0100, Robert Shearman wrote:
> From: Robert Shearman <rob@codeweavers.com>
> 
> Allow SSL to be used when a imaps:// URL is used for the host name.
> 
> Also, automatically use TLS when not using imaps:// by using the IMAP STARTTLS command, if the server supports it.
> 
> Tested with Courier and Gimap IMAP servers.

Please do an alternative implementation using GnuTLS. Why ? Because curl
can be built against openssl or gnutls, and it would be sad if git
ended up depending on both indirectly.

Mike
