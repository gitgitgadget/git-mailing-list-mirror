From: Dun Peal <dunpealer@gmail.com>
Subject: Way to specify an exclusion refspec?
Date: Thu, 2 Dec 2010 16:17:48 -0600
Message-ID: <AANLkTi=YPJKvNW3PKcaSTRSPFCARHC=hn2OtSYOoe7DA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 02 23:17:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POHTO-0003py-8N
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 23:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757651Ab0LBWRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Dec 2010 17:17:49 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:63451 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755547Ab0LBWRs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Dec 2010 17:17:48 -0500
Received: by qyk12 with SMTP id 12so10902352qyk.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 14:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=9STdwiWSgZAJY7D/iqPv15ZR5+8g3RGgIqQWmqrf74s=;
        b=U/00xdkykjnb9edofndypqfvv3CizrkFUdNC0Brkal+wHUGXCqCm0Aav6wjt5TYNYW
         BOr9bFXaW+F4MZHpnJrAcVp4chGZT0nsc1T8K1yaXb0ygA7SCLV9a+8+NdtdtiH5LqR2
         HDy7rYl/gP/U36PFARyYz+TinGl8V/h1+41iI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=MH7AAvH06tgxD46zo1icRp+XRs1eGjbEnTAs4mH0uNeZTy+VppCvM7/54+55JsMACN
         1jGBaezwqZ/7Li3X9jcFFmoW/SMEaVhhHPA58kFSVLFsyUn/OryAsWOOz3y4/BzGH0UK
         Np3Qe22ayfMhbNIp8jEApdkN+vOn2xHOM2NQg=
Received: by 10.224.53.204 with SMTP id n12mr515682qag.49.1291328268094; Thu,
 02 Dec 2010 14:17:48 -0800 (PST)
Received: by 10.220.128.133 with HTTP; Thu, 2 Dec 2010 14:17:48 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162749>

Hi. The manpage describes how to specify an inclusion refspec, like
for example the default one that gets set for `origin` in
`.git/config`, which tells git to include all (`*`) heads in every
fetch operation:

  +refs/heads/*:refs/remotes/origin/*

But how about specifying an exclusion refspec?  For instance, we want
to fetch all heads (`*`) except `foo`, or all heads beginning in "ba"
(`ba*`) except `bar`.

Thanks, D
