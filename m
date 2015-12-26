From: joe <joezeve@openmailbox.org>
Subject: bug: incorrect ssl directory set on git-scm
Date: Sat, 26 Dec 2015 13:35:50 +0000 (UTC)
Message-ID: <loom.20151226T143541-907@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 26 14:41:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aCp5e-0003Oq-VQ
	for gcvg-git-2@plane.gmane.org; Sat, 26 Dec 2015 14:40:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbbLZNkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Dec 2015 08:40:13 -0500
Received: from plane.gmane.org ([80.91.229.3]:50027 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbbLZNkM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Dec 2015 08:40:12 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aCp4l-0002Nv-BT
	for git@vger.kernel.org; Sat, 26 Dec 2015 14:40:04 +0100
Received: from mkvex.177.198.86.177-BGP.mkvex.com.br ([mkvex.177.198.86.177-BGP.mkvex.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 14:40:03 +0100
Received: from joezeve by mkvex.177.198.86.177-BGP.mkvex.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Dec 2015 14:40:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 177.86.198.177 (Mozilla/5.0 (Windows NT 6.1; rv:38.0) Gecko/20100101 Firefox/38.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282997>

git-scm comes with ca-bundle.trust.crt and cert.pem, it currently (2.6.4)
assumes that they are stored in

<dir name>\mingw32\libexec\ssl\certs
<dir name>\mingw32\libexec\ssl

which is not true, they are in

<dir name>\mingw32\ssl\certs
<dir name>\mingw32\ssl
