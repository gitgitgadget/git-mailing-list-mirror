From: th.acker66@arcor.de
Subject: Wrong file casing: git blame shows "Not commited yet" entries
Date: Tue, 21 Aug 2012 10:15:09 +0200 (CEST)
Message-ID: <448976857.19199.1345536909771.JavaMail.ngmail@webmail24.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 21 10:15:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3jcQ-00066u-SD
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 10:15:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab2HUIPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 04:15:16 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:58789 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753131Ab2HUIPL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 04:15:11 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mx.arcor.de (Postfix) with ESMTP id CE0FAE3D30
	for <git@vger.kernel.org>; Tue, 21 Aug 2012 10:15:09 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id C838F7FE428
	for <git@vger.kernel.org>; Tue, 21 Aug 2012 10:15:09 +0200 (CEST)
Received: from webmail24.arcor-online.net (webmail24.arcor-online.net [151.189.8.174])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id C1EB5AA834
	for <git@vger.kernel.org>; Tue, 21 Aug 2012 10:15:09 +0200 (CEST)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-04.arcor-online.net C1EB5AA834
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1345536909; bh=4j+Uvz7VMHCwj/9Xr0+4vqE8mp78HUOlTqzZdJ/fimg=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=BzIztfiAbfM/LhCWE36dy3bPbqHOOkSokPd5Wd7ikVtOO+4kPIgC0sWdi9qs+6sqU
	 RauywYDPQIO3Q/xgZTBboXtDEhyLS+RXb18stYl0CJw5YmckkflPFxUdk6EYYOpAbN
	 TN3qcQNKTYE0N+lkJ9nAgDyv1uCORJ0i7xS2bT1w=
Received: from [188.105.102.86] by webmail24.arcor-online.net (151.189.8.174) with HTTP (Arcor Webmail); Tue, 21 Aug 2012 10:15:09 +0200 (CEST)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 188.105.102.86
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203953>

Hi,

if I have a file "File.txt" in my repo, then "git blame file.txt" gives me
"Not commited yet" for every single line in this file. "git blame File.txt"
gives the correct output.
I am using "core.ignorecaes=true" so this behaviour is not what I expected.
Is this a bug or a feature?

Regards,
Thomas


---
Thomas
