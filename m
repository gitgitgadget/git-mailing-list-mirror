From: Yann Simon <yann.simon.fr@gmail.com>
Subject: Error with git svn show-ignore: forbidden access
Date: Tue, 1 Sep 2009 11:46:00 +0200
Message-ID: <551f769b0909010246u524599bcoc5b227f4a6279259@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 01 11:46:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiPwI-00089M-JP
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 11:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbZIAJqA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 05:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753202AbZIAJp7
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 05:45:59 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53233 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZIAJp7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2009 05:45:59 -0400
Received: by bwz19 with SMTP id 19so3379711bwz.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 02:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=8TznU/VNo20SVXL1GPHgYbjX0rE5VFUBNDOZEoGShCo=;
        b=UwewE+dR4hKfu3vCGyi4mSakm3FVCnw/2wIlUXz0SK3U1qaO+1mybD4R2fheTFoQNr
         J2wy3jRlC1ENU6uagxjNlssD4baVu666XVvy/BlPv7QKqHRIYIWDJIn3sEJ7A/ycMitZ
         2KSpn0kqy3Qj75S0bCZP9mdh4p6grFFvcpa2k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=lr/csFaRAZgWg+RoDiG5dfq40WPCxopP1DGZaJffwiYhRAz5pfz+MhYEKPuj1h2Y85
         u2AVvc3wtxrT0ceeg7sOHzPmOZD/rn0ujLn+Y1kHBpx5t80c5hvlWmygRLYEaMfANCAC
         79IJjHVNFTitgVXjS+CPI5Dqwe/F5zH2v1gBg=
Received: by 10.103.125.37 with SMTP id c37mr2792017mun.69.1251798360130; Tue, 
	01 Sep 2009 02:46:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127528>

Hi,

with git version 1.6.4:

$ git svn show-ignore > .gitignore
RA layer request failed: Server sent unexpected return value (403
Forbidden) in response to PROPFIND request for
'/repos/XXX/YYY/ZZZ/trunk/aaa' at /usr/lib/git-core/git-svn line 2243

Is git svn show-ignore making request to the svn server?

I tried also with the --no-minimize-url option but get as answer:
$ git svn --no-minimize-url show-ignore
Unknown option: no-minimize-url

Thanks for the help

Yann
