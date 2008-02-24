From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: add regression tests
Date: Sun, 24 Feb 2008 09:58:30 +0100
Organization: glandium.org
Message-ID: <20080224085830.GD13416@glandium.org>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Feb 24 09:56:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTCet-0003wA-Nu
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 09:56:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbYBXIz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2008 03:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbYBXIz4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 03:55:56 -0500
Received: from vuizook.err.no ([85.19.215.103]:60130 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbYBXIzz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 03:55:55 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JTCeB-0001HN-LA; Sun, 24 Feb 2008 09:55:53 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1JTCgo-00045S-PY; Sun, 24 Feb 2008 09:58:30 +0100
Content-Disposition: inline
In-Reply-To: <20080223212843.GA30054@localhost>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74914>

On Sat, Feb 23, 2008 at 10:28:44PM +0100, Clemens Buchacher wrote:
> These tests require a webserver. The executable path and listening port
> are configured using the environment variables
> 
> HTTPD_PATH (default: /usr/sbin/apache2) and
> HTTPD_PORT (default: 8111),
(...)
> +LoadModule dav_module /usr/lib/apache2/modules/mod_dav.so
> +LoadModule dav_fs_module /usr/lib/apache2/modules/mod_dav_fs.so

You'd need something for these paths too.

It would be nice if the httpd setup could be done in another file so
that other tests could use it. Also, an https setup would be nice ;)

Mike
