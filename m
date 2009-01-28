From: Caleb Cushing <xenoterracide@gmail.com>
Subject: feature needed imap-send pass as cli switch
Date: Wed, 28 Jan 2009 02:18:52 -0500
Message-ID: <81bfc67a0901272318i707b66a0ja20f97df6fe95c73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 28 08:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LS4ii-00042B-Kz
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 08:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751866AbZA1HS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 02:18:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZA1HSz
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 02:18:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:25395 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751754AbZA1HSz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 02:18:55 -0500
Received: by fg-out-1718.google.com with SMTP id 13so436571fge.17
        for <git@vger.kernel.org>; Tue, 27 Jan 2009 23:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=CXaja9LsbHB+KZ743VidqBKF3CBi3bjz9oziCw+Ip6o=;
        b=OIVL347qVsxYpnjSLfqZ9c+/f9KnM40Ot0PGY++ohTu6KK/8vtlBBFlYyb7PsYEVXb
         zNz3O4NVLr/WMX++rURTnvJaBrsOFUTe46/Gnk8OtZnTdXKelPEgLoNE/UtXauT1Xy9Y
         jkE2kPK7c215gfwYkI2ji+nURGmhPHA2n3b98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=o6+wGyI5LX2sDH6hcd1mA6KI/eUGbPidgfgeZh8KoI7aoOtRGcVEAoAqr2NVW+NpQi
         FK4uIZfcyuKsCrogxC527ysS6R/y73CW2BcbuDpkxOM4pj92/b83xHvC0aOQw1rFKnZB
         3q0kjv3fk/UTP5hTQxg3ztNKQDKuzxpx6xR48=
Received: by 10.223.108.74 with SMTP id e10mr1671978fap.35.1233127132910; Tue, 
	27 Jan 2009 23:18:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107488>

I tend to have my .gitconfig shared on github with a bunch of other
config files and this has been ok, until submitting a patch here I
needed to use imap-send, and the only way I see in the documentation
is to put my email password in .gitconfig, obviously I can't push this
up to my remote as I usually do. I'd like to see an option to pass the
password on the cli, either as an input prompt or as just an argument
to an option, or both. I think storing it in the config file is a
security risk, storing passwords in plaintext is just bad practice.

if it's already possible could someone share how with me? and perhaps
patch the documentation to include how.
-- 
Caleb Cushing

http://xenoterracide.blogspot.com
