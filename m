From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v9] Documentation/remote-helpers: Add invocation section
Date: Wed, 7 Apr 2010 14:26:30 +0530
Message-ID: <w2wf3271551004070156ia98bcb9cre81baa3d862bb19b@mail.gmail.com>
References: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 10:57:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzR4N-00061E-9a
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 10:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932491Ab0DGI4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 04:56:53 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:54949 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477Ab0DGI4v (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 04:56:51 -0400
Received: by ywh2 with SMTP id 2so501428ywh.33
        for <git@vger.kernel.org>; Wed, 07 Apr 2010 01:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=t09a54Fg33tHrVzN+0pfxJm0Hw1Uo+xRUjiCwVBWMUM=;
        b=RPXW+H9vPv19rF+iyLFKCHj/Y8kW+PEEiub5Kn2aNlQdEhw8K65geUak/gjZYi8mpf
         rqHBwcNRMDm14RTy3ezLInZS+gy87ehDMax4+UF+hgzJmPXpOXLtwyVO35ZgD93ERv/l
         9bsJkstLo/c/LlFGEuQwkq1xCskolpTgvaENI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=Tax27CveyYC85MYh23JzpLRl2E7GrrwuL1VwL2A4zBlQhrdq20v8xbMfaPU36Fey62
         Ju2GvTIzR9i+ac5smYeTssMCUoIr9CBXqRGxoGdFHXQJ24RX2hj+yhFslyqGgiFFITQl
         hulswX+3yFraXlh6u6lg3AU9DR2dcDfllQuLQ=
Received: by 10.90.69.14 with HTTP; Wed, 7 Apr 2010 01:56:30 -0700 (PDT)
In-Reply-To: <g2vf3271551004062257ycbda64d3z3d3004d802a03fc3@mail.gmail.com>
Received: by 10.91.219.15 with SMTP id w15mr447825agq.18.1270630610165; Wed, 
	07 Apr 2010 01:56:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144206>

Hi Junio,

I see that you've applied v8 of my patch to pu, but there's a small
change in this revision:

diff --git a/Documentation/git-remote-helpers.txt
b/Documentation/git-remote-helpers.txt
index 8838388..6ffc0da 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -44,9 +44,8 @@ INVOCATION
 Remote helper programs are invoked with one or (optionally) two
 arguments. The first argument specifies a remote repository as in git;
 it is either the name of a configured remote or a URL. The second
-argument specifies a URL of the form '<transport>://<address>' or
-'<transport>::<address>', where '<address>' may be an arbitrary
-string.
+argument specifies a URL; it is usually of the form
+'<transport>://<address>', but any arbitrary string is possible.

 When git encounters a URL of the form '<transport>://<address>', where
 '<transport>' is a protocol that it cannot handle natively, it

-- Ram
