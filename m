From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: gitweb, missing project list
Date: Tue, 2 Sep 2008 20:29:02 -0400
Message-ID: <9e4733910809021729g2ccb062oc8818a69c20f857e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 03 02:30:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KagGP-0003O5-Dk
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 02:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755367AbYICA3G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2008 20:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754816AbYICA3G
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Sep 2008 20:29:06 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:44398 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754625AbYICA3E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2008 20:29:04 -0400
Received: by py-out-1112.google.com with SMTP id p76so1395875pyb.10
        for <git@vger.kernel.org>; Tue, 02 Sep 2008 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=qjbLuZ09Fn2zoO45MvNFPa68dt5IREfm5fWahOAgK6A=;
        b=aTsSVeoX9Rgq569emUBPoFCDhQi3Ksp8p6BY5ny7bTKhNKB//aeXAN8EHgflCyy8vd
         EZ3W8WKXDo5GB9uPA/lk1AYyHoEX61CE4wIZmkqwALX6Q/Y2rsfkUb4Le2P1GaNBHMYC
         PJ/proMb42vwoPs9g7xUmwDcA7i3o5bMmRn3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=Cr4gnBmEVynFjAfrZpZE08eSUn2hSqW+tcnwlKlBWBTnX1XhZFlJJAobgT3SCCRVCg
         zTVGGE9Y44zZUiYPkqYNbGiHEPseASfCsUnTfo0mtYq811UTmuPTGivGNAvH48SdPDOe
         0ST90x+UZjWxv56qCbGPcRKCyc1JThi6VoOs0=
Received: by 10.65.219.20 with SMTP id w20mr16823229qbq.43.1220401742536;
        Tue, 02 Sep 2008 17:29:02 -0700 (PDT)
Received: by 10.64.178.13 with HTTP; Tue, 2 Sep 2008 17:29:02 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94750>

I can see my project list when I do:

./cgi-bin/gitweb.cgi

But it does not show on my website
git.digispeaker.com

Rewrite rules:

Options FollowSymLinks ExecCGI Indexes
RewriteEngine on
RewriteRule ^$ /cgi-bin/gitweb.cgi%{REQUEST_URI} [L,PT]
RewriteRule ^[a-zA-Z0-9_\-]+\.git/?(\?.*)?$
/cgi-bin/gitweb.cgi%{REQUEST_URI} [L,PT]

gitweb version:
our $version = "1.5.3.5.605.g79fa-dirty";

This used to work so something has changed at my host.
How can I debug this?


-- 
Jon Smirl
jonsmirl@gmail.com
