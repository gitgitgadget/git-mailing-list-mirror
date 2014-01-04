From: Thomas Ackermann <th.acker@arcor.de>
Subject: [Bug report] 'git status' always says "Your branch is up-to-date
 with 'origin/master'"
Date: Sat, 4 Jan 2014 18:25:29 +0100 (CET)
Message-ID: <86886772.1529128.1388856329849.JavaMail.ngmail@webmail08.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, worldhello.net@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 04 18:25:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzUye-0008QG-5U
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 18:25:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbaADRZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Jan 2014 12:25:32 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:55804 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751279AbaADRZb (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Jan 2014 12:25:31 -0500
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id EA5A63018A;
	Sat,  4 Jan 2014 18:25:29 +0100 (CET)
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net [151.189.21.52])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id E3DE114B01B;
	Sat,  4 Jan 2014 18:25:29 +0100 (CET)
Received: from webmail08.arcor-online.net (webmail08.arcor-online.net [151.189.8.44])
	by mail-in-12.arcor-online.net (Postfix) with ESMTP id CC2F0262E3;
	Sat,  4 Jan 2014 18:25:29 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-12.arcor-online.net CC2F0262E3
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1388856329; bh=MQaLceENugI3mXO9kQBkupQ70nRZsVV3NI3jTo+HZyA=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=C0BI/GXKSpM3wGDtraiqJR5m/P7QgsWJvJhvam5fbT7ZACgJvpbGSSjxbmZZL7/2M
	 BRkmEWtYvsuc7EUTVy956laZj+sZOZGDKxWIMIlmk+pAXjWwF8OtoIj1k60+AAsAtw
	 3I2lIsMV7unRSkLbh0IMGzMaaXNrTFpoxNt2o6kE=
Received: from [94.217.18.252] by webmail08.arcor-online.net (151.189.8.44) with HTTP (Arcor Webmail); Sat, 4 Jan 2014 18:25:29 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 94.217.18.252
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239943>

Since f223459 "status: always show tracking branch even no change" 
'git status' (and 'git checkout master' always says 
"Your branch is up-to-date with 'origin/master'"
even if 'origin/master' is way ahead from local 'master'.


---
Thomas
