From: Patrik Gustafsson <pvn@textalk.se>
Subject: --orphan erases HEAD reflog
Date: Fri, 3 Jun 2016 13:28:13 +0200
Organization: Textalk
Message-ID: <f51f9df7-d6d7-3a45-736f-ca2e2c9eb2cb@textalk.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 13:28:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8nH2-0004Wr-Su
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 13:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbcFCL2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 07:28:17 -0400
Received: from smtp.textalk.se ([192.121.104.208]:37031 "EHLO smtp.textalk.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069AbcFCL2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 07:28:16 -0400
Received: from [2a00:801:7:1:5fef:821f:1c16:fe15]
	by smtp.textalk.se with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <pvn@textalk.se>)
	id 1b8nGv-000748-5R
	for git@vger.kernel.org; Fri, 03 Jun 2016 13:28:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296302>

after running the command:

git checkout --orphan fuleFix

my HEAD reflog is emptied.
I would like to have my reflog intact :)

git version 2.8.3

dist:
Manjaro

thanx for being awesome
