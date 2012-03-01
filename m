From: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
Subject: Question about credential api
Date: Thu, 01 Mar 2012 14:33:08 +0100
Message-ID: <4F4F7A94.2000804@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: peff@peff.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 01 13:37:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S35Fs-0002IQ-L5
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 13:37:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759188Ab2CAMg7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 07:36:59 -0500
Received: from luthien2.mpt.es ([82.150.0.102]:20360 "EHLO luthien2.map.es"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759187Ab2CAMg6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 07:36:58 -0500
Received: from correo.map.es (unknown [10.1.31.68])
	by luthien2.map.es (Postfix) with ESMTP id CD5E3B704B;
	Thu,  1 Mar 2012 13:34:36 +0100 (CET)
Received: from [10.47.128.147] (unknown [10.1.29.79])
	by correo.map.es (Postfix) with ESMTP id 32B8D18001F;
	Thu,  1 Mar 2012 13:34:26 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
X-map-MapScanner: Libre de virus, Libre de virus
X-Spam-Status: No, No
X-map-MapScanner-Information: 
X-map-MapScanner-ID: CD5E3B704B.A9EE3
X-map-MapScanner-From: nelsonjesus.benitez@seap.minhap.es
X-map-MailScanner-Watermark: 1331210082.34033@6zPLWyaY4cHRIx7DX2TCMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191928>

Hi Jeff, a quick question about credential api, after doing this:

static struct credential proxy_auth = CREDENTIAL_INIT;
credential_from_url(&proxy_auth, "http://proxy.server.com:8080");

will prox_auth.username and prox_auth.password be an empty string ? so
that strcmp(proxy_auth.username,"") returns zero.. couldn't figure that
out from api-credentials.txt 

Thanks,
