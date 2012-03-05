From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: [PATCH v3 0/4] Support http proxy authentication
Date: Mon, 05 Mar 2012 16:14:32 +0100
Message-ID: <4F54D858.7010702@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net, sam@vilain.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 15:16:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4YiL-0001tE-EQ
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 15:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932475Ab2CEOQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 09:16:31 -0500
Received: from luthien1.map.es ([82.150.0.102]:21128 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932403Ab2CEOQa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 09:16:30 -0500
Received: from correo.map.es (unknown [10.1.24.76])
	by luthien2.map.es (Postfix) with ESMTP id C63E2B708B;
	Mon,  5 Mar 2012 15:15:56 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id E4BB92C4F6;
	Mon,  5 Mar 2012 15:15:51 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: C63E2B708B.3AF47
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331561757.23252@P52Afl619gJt5rlXKr3Tag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192241>

Hi, here is a new version of patch-set for supporting proxy
authentication on git, now doing proactive auth if the flag
is set and the proxy url has username, and also handling 407
error code by asking credentials (if necessary) and re-trying.

Patches 1/4 and 2/4 are same as previous version but with ammended
commit messages.

Please comment, thank you!

Nelson Benitez Leon (4):
  http: support proxies that needs authentication
  http: try http_proxy env var when http.proxy config option is not set
  http: handle proxy proactive authentication
  http: handle proxy authentication failure (error 407)

 http.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

-- 
1.7.7.6
