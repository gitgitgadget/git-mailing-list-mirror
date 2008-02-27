From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] http-push: add regression tests
Date: Wed, 27 Feb 2008 10:16:42 +0100
Organization: glandium.org
Message-ID: <20080227091640.GA19272@glandium.org>
References: <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080223212843.GA30054@localhost> <20080224085830.GD13416@glandium.org> <20080224180340.GA11515@localhost> <20080224184832.GA24240@glandium.org> <20080225232820.GA18254@localhost> <7vprukfttt.fsf@gitster.siamese.dyndns.org> <20080227085442.GA22501@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Feb 27 10:17:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUIQ3-0006LF-Mu
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 10:17:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601AbYB0JQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2008 04:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbYB0JQ6
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Feb 2008 04:16:58 -0500
Received: from vuizook.err.no ([85.19.215.103]:41506 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbYB0JQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2008 04:16:56 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1JUIP9-0007Kn-5l; Wed, 27 Feb 2008 10:16:53 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1JUIP4-00051t-1K; Wed, 27 Feb 2008 10:16:42 +0100
Content-Disposition: inline
In-Reply-To: <20080227085442.GA22501@localhost>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75215>

On Wed, Feb 27, 2008 at 09:54:42AM +0100, Clemens Buchacher <drizzd@aon.at> wrote:
> http-push tests require a web server with WebDAV support.
> 
> This commit introduces a HTTPD test library, which can be configured using
> the following environment variables.
> 
> LIB_HTTPD_PATH		web server path
> LIB_HTTPD_MODULE_PATH	web server modules path
> LIB_HTTPD_PORT		listening port
> LIB_HTTPD_DAV		enable DAV
> LIB_HTTPD_SVN		enable SVN
> LIB_HTTPD_SSL		enable SSL
> 
> Networking tests are disabled by default. Use GIT_TEST_OPTS=--network to
> enable.
> 
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Acked-by: Mike Hommey <mh@glandium.org>


However, last remark:
> I wanted to state explicitly that HTTPD_ROOT_PATH and HTTPD_DOCUMENT_ROOT_PATH
> do not have to be related. I added the -p flag to both commands, however.

They *are* related, because HTTPD_DOCUMENT_ROOT_PATH is what is in httpd.conf,
set with the DocumentRoot directive, and it's a path relative to
HTTPD_ROOT_PATH. And it is set statically to "www".

Mike
