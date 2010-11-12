From: Mike Coleman <tutufan@gmail.com>
Subject: possible 'git --dirstat=0' buglet in 1.7.0.4?
Date: Fri, 12 Nov 2010 08:33:56 -0600
Message-ID: <AANLkTi=wZ8MhU0NUw9as-kw8Lhr=TFBK2BY7MFRQvOct@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 12 15:34:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGuhe-0002ws-5o
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 15:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757452Ab0KLOeE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 09:34:04 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:37923 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab0KLOeD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 09:34:03 -0500
Received: by gyh4 with SMTP id 4so1872640gyh.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 06:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=090eMRikBmuVa4mecGLknzkoCah177vw2s8VVwtnQII=;
        b=v97OW2BMQPH2UCxhL42+YxviPMIEORfDi5F8w0KiyFfNYzxf9FJy03X+v/+Luap8C7
         O+iUjOjSH/8hdd3Sqxy5/QLH2nqDhUB/mEdCfdZ2mr0g0LTjgV6e9JVqMaH6sF5oPVHR
         0Bqgd7shQb5VfNRDZzhFpPbutmnguAUJdhe6I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bbwog/OrjEQ3di4DDoCzpeSAI7hDMiLPWoL1bx47CejfL3q6tgS6U9P6TidevU1+9K
         0V/2Bg+OeKPlEmvE3hjxckqfAcx0KqAbaNCrJP8HtGFC2WgWpk1LtIEW2P2XS6Yl+CoB
         gCTQ5J3yexRIPzmL/qAnMpcSoJwSesIk+1JhA=
Received: by 10.42.229.200 with SMTP id jj8mr2642494icb.53.1289572436696; Fri,
 12 Nov 2010 06:33:56 -0800 (PST)
Received: by 10.42.172.70 with HTTP; Fri, 12 Nov 2010 06:33:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161344>

I noticed just now that the '--dirstat=0' flag still seems to filter
out some diffs, even though I would expect the '0' to mean "don't
filter anything".  If there's another flag that says "don't filter", I
missed it.  Could this be a rounding or off-by-one error?

Mike
