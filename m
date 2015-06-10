From: Christopher Dunn <cdunn2001@gmail.com>
Subject: RFC: 'git-sym' for large files
Date: Wed, 10 Jun 2015 12:05:54 -0500
Message-ID: <CAD2z=MAT_+T1yFW1Q6hasvBoiT6_TrO-03oNqiYxMS5XBfCJPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 10 19:06:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2jS6-00062T-3X
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 19:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934075AbbFJRGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 13:06:03 -0400
Received: from mail-vn0-f53.google.com ([209.85.216.53]:36168 "EHLO
	mail-vn0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934072AbbFJRFz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 13:05:55 -0400
Received: by vnbg1 with SMTP id g1so9170793vnb.3
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=9g7AJzTXX8csx/OeirVBTGjf3mo/dPMOIRZnVLEEuJ0=;
        b=lsP9LrLtQRxpJ6mSiBO7oDcaobWLJVZYANXyLYcvXqIp/sB605l2Fhv6uHpxCdnHj7
         0qohI+U+uU2Se0ZM/w4U+e7it+zcyzAWq73cTckgqsFTrx0sEz6r5brh1XKPv874MtAI
         UbYipagV5/ydCJMBzJ3+OrOXN9AGqJAOKY/4SWgqWNWD6qtmaDewKR8/isErD3viHjhW
         Olz6/wrD7697VTGHmTun7GYhrcqeeAzX3jCyMlBka0x+EdasxsZ3WdE0Kzd8ut/lxvAf
         J2Iu5fAGq+bKuM+ZvyhHvdzb/g8pCypCvdn3WKIgnPzGzH+L8WVgphyodg4hovFVjOTP
         vRkw==
X-Received: by 10.52.94.75 with SMTP id da11mr8147905vdb.54.1433955954498;
 Wed, 10 Jun 2015 10:05:54 -0700 (PDT)
Received: by 10.52.98.134 with HTTP; Wed, 10 Jun 2015 10:05:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271329>

https://github.com/cdunn2001/git-sym

https://github.com/cdunn2001/git-sym-test/wiki/Examples
