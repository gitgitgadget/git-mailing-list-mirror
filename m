From: Debian User <user.deb@yandex.ru>
Subject: opentracker bug
Date: Wed, 25 Nov 2015 23:34:19 +0300
Message-ID: <838211448483659@web24m.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 21:42:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1gtX-0003PS-Aa
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 21:42:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbbKYUm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 15:42:26 -0500
Received: from forward2m.mail.yandex.net ([37.140.138.2]:38940 "EHLO
	forward2m.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696AbbKYUmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 15:42:25 -0500
X-Greylist: delayed 483 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Nov 2015 15:42:25 EST
Received: from web24m.yandex.ru (web24m.yandex.ru [37.140.138.115])
	by forward2m.mail.yandex.net (Yandex) with ESMTP id BFD705CA0C5A
	for <git@vger.kernel.org>; Wed, 25 Nov 2015 23:34:20 +0300 (MSK)
Received: from 127.0.0.1 (localhost [127.0.0.1])
	by web24m.yandex.ru (Yandex) with ESMTP id 4F7252DA2E5B;
	Wed, 25 Nov 2015 23:34:20 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1448483660; bh=TDpkr79zfcbmDu+IPku40loF4DMdnn0Gx2s/U1A8lYw=;
	h=From:To:Subject:Date;
	b=PBmptLr3heF+kM8NVQUvU+b2lcObagnhJzyoaqHJusf0SsRt0nLwPdhiI50uYayvo
	 nWcdbdBj77N81Hpbod2V/1HT30Bsy2mY8dd8lqqEBlyy9KwONY13prPjwtLfp8InNw
	 66K5OIO/NbmAU9mm7JaNLXOCf9+YNyOmmvxByfSk=
Received: by web24m.yandex.ru with HTTP;
	Wed, 25 Nov 2015 23:34:19 +0300
Envelope-From: user-deb@yandex.ru
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281742>

Hello. 
I have found a bug in opentracker // http://erdgeist.org/gitweb/opentracker/ , or it is something wrong with my PC (?).

Every time when I access statistics page at "localhost:6969/st?mode=everything", it redirects my browser to "http://www.localhost.com:6969/st?mode=everything" and opentracker crashes with same segmentation error. All other types (modes) of statistics work fine. 

Tried different configs, users, folders, ... all the same. 
Especially fun is "www" and "com" with "localhost" :)

OS Debian 8.0 Jessie amd64, opentracker was installed from sources by instruction on the official website. 

Thank you.
