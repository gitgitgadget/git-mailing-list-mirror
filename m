From: Sebastian Schmidt <isibboi@gmail.com>
Subject: Git over HTTPS with basic authentication
Date: Thu, 18 Apr 2013 21:47:02 +0200
Message-ID: <1366314422.12299.3.camel@sibbo-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 21:47:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USuna-0002SO-Qk
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 21:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936464Ab3DRTrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 15:47:10 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:39628 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab3DRTrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 15:47:09 -0400
Received: by mail-ee0-f52.google.com with SMTP id b57so1297992eek.11
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:subject:from:to:date:content-type:x-mailer
         :mime-version:content-transfer-encoding;
        bh=i/UiFrdvGSv7anWxZy6L+f9w5N1x2v1yqSfC5jjBge8=;
        b=ZPOjT/gfMTBKBtSpysIeR7OPnsNy3qYaAtFKqgoK8KLhm9aMEBJXJLwsnCPqtwVFWN
         KQlMOjG/wxHa/2ZpN60AyHJ/4SgTOamdmuZ9Y5DyLi8VfPCxr6ioNcYRhEMMzFbrIeQz
         MVndc0IACDeg/yeCMr2f+5FhatZtrC2VJ1zTUsi34pWK1TfebeWRvqkc/aeQH5lCjaMf
         EID+ki3nBpC0rT3lb9BWb+yg9BTSBjKaHHmGi2+dgd4Xa7IsZ+omUw3ZIdE0hvORnumZ
         gPyI4jTtyAoxLX3AibomtPAOfquz7lpoaZMZ9a3RfJKbCPEPY4fszRITpczUD9IjwK0J
         TiOA==
X-Received: by 10.15.22.76 with SMTP id e52mr33842313eeu.7.1366314427968;
        Thu, 18 Apr 2013 12:47:07 -0700 (PDT)
Received: from [129.13.225.154] (colubris-intranet.scc.kit.edu. [141.3.208.8])
        by mx.google.com with ESMTPS id i53sm18117689eeu.5.2013.04.18.12.47.06
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Thu, 18 Apr 2013 12:47:07 -0700 (PDT)
X-Mailer: Evolution 3.6.2-0ubuntu0.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221685>

Why is git not working over HTTPS with basic authentication? I can clone
just fine, but when I try to push, it tells me

error: Cannot access URL https://..., return code 22
fatal: git-http-push failed

I have googled for an hour now, all I find is people that have the same
problem and the solution is always to use SSH.

Sibbo
