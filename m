From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: [ANNOUNCE] Gitbuilder 0.2.0 is released
Date: Wed, 29 Oct 2008 14:37:22 -0400
Message-ID: <32541b130810291137i11a6e086ndedc43c9fb2e6ef0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 29 19:49:00 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvG5p-0000RD-V3
	for gcvg-git-2@gmane.org; Wed, 29 Oct 2008 19:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752607AbYJ2SrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2008 14:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752542AbYJ2SrU
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Oct 2008 14:47:20 -0400
Received: from mail-gx0-f12.google.com ([209.85.217.12]:39403 "EHLO
	mail-gx0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435AbYJ2SrT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2008 14:47:19 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Oct 2008 14:47:19 EDT
Received: by gxk5 with SMTP id 5so59378gxk.13
        for <git@vger.kernel.org>; Wed, 29 Oct 2008 11:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=utvrhAW4diSqSBKJxwJZguApfUYTyV+qvoY6trSzFio=;
        b=NGU4pJm3W3ptOSxxuf+u4U7OmS+A0l8NCjoeUiw1p7wp+tiRj6Q/LyxzkhKaLV0rAW
         klbKuh+SNSYFxDd/gQkwVBoxIwCe8vP3ULoFbMmNjfDEZOIVUFrzkD2mte9ibic8uH9a
         HjSLRCogca5iQKSQiVZ0V/K0HydxSJqiq2HxU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=NwoYvCQvsjx0lZjhOazGEBLCpl4lcQ+MW2VAz80sVnNU1Uw8b27qcyMDrEBdmLqhLS
         dNLjotDMauWmJnSwgyaybgtLWGDGzMOBbvB/RXL8FjisEDq2GqbAZsEHTv5pY4ZQVnT9
         kmDLNJW3WF9M3654baiICzjySJiGGrAFj3yn8=
Received: by 10.151.108.5 with SMTP id k5mr1833310ybm.209.1225305442595;
        Wed, 29 Oct 2008 11:37:22 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 29 Oct 2008 11:37:22 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99389>

Hi all,

I'd like to announce the new v0.2.0 release of gitbuilder, an
auto-bisecting autobuilder tool for git-based projects.  The new
version incorporates several suggestions from end users, including:

 - a new bar at the top shows the most recent builds and their status
 - the RSS link is now more obvious
 - non-fatal warnings now turn your build yellow instead of green
 - we now count and report warnings, errors, and test failures separately
 - a new changelog script can email recent changes in your repo on a
daily/weekly schedule

You can see some running gitbuilder examples (including one that
tracks git.git) here:
   http://versabanq.com/demo/build/

And you can download the source code (in perl+shell) here:
   http://github.com/apenwarr/gitbuilder/

Enjoy!

Have fun,

Avery
