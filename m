From: Vampire <Vampire@Masters-of-Disaster.de>
Subject: git svn clone failing
Date: Mon, 14 Feb 2011 18:24:05 +0100
Message-ID: <AANLkTi=Y64ohHnduBqxs--aLW3AYKCxrag2YoAFt58NC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 14 18:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pp2AC-0006U7-4W
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 18:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755780Ab1BNRYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Feb 2011 12:24:34 -0500
Received: from masters-of-disaster.de ([85.214.103.232]:53819 "EHLO
	masters-of-disaster.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755720Ab1BNRYd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Feb 2011 12:24:33 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174])
	by h1362875.stratoserver.net with esmtpsa (TLS1.0:RSA_ARCFOUR_SHA1:16)
	(Exim 4.69)
	(envelope-from <Vampire@masters-of-disaster.de>)
	id 1Pp2A4-0002xh-GR
	for git@vger.kernel.org; Mon, 14 Feb 2011 18:24:32 +0100
Received: by iyj8 with SMTP id 8so5027942iyj.19
        for <git@vger.kernel.org>; Mon, 14 Feb 2011 09:24:25 -0800 (PST)
Received: by 10.231.173.138 with SMTP id p10mr3234509ibz.48.1297704265264;
 Mon, 14 Feb 2011 09:24:25 -0800 (PST)
Received: by 10.231.146.212 with HTTP; Mon, 14 Feb 2011 09:24:05 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166739>

Hi,

I'm trying to issue the following command:

git svn clone --stdlayout http://svn.apache.org/repos/asf/ant/core/ .

But unfortunately this fails after some time with the message:

RA layer request failed: Server sent unexpected return value (403
=46orbidden) in response to REPORT request for
'/repos/asf/!svn/vcc/default' at /usr/lib/git-core/git-svn line 4354

Regards
Bj=F6rn
