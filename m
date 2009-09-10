From: Aloisio <aloisiojr@gmail.com>
Subject: Cannot clone redirecting stdout
Date: Thu, 10 Sep 2009 19:33:21 -0300
Message-ID: <fc8ab2ad0909101533l135c8003m80091cb40ec93f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 00:33:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MlsD8-0007Qd-5M
	for gcvg-git-2@lo.gmane.org; Fri, 11 Sep 2009 00:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751122AbZIJWdl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2009 18:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbZIJWdl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Sep 2009 18:33:41 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:56531 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZIJWdk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2009 18:33:40 -0400
Received: by bwz19 with SMTP id 19so447451bwz.37
        for <git@vger.kernel.org>; Thu, 10 Sep 2009 15:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=VysXJ3PLbUrrqu2Tq/elCYdenRR5V2zXk4VwpHO3VFU=;
        b=YCrtuydIpS9/jiP7G0jgmo7gbsb1VDmPSblBImytUCi8pT7uwhGx1xuhHgXtrI0WqI
         /KFhfXHiQSPp58mIFRoCU35OaexhVQ/Ag6wirRHiidgTvPiqVLIXC8HmxAkGZK90jKdg
         GmqXwxwo/TAwb17vjspNIo1ZgtlG4NcULnUcw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=b/POiMLoh7iZjetpXIEqmZUn/M+y9q8hB/wHaT/EXldXn4XabkM018sNrwlQHxRrDM
         +xZ7RpPNELTLMJxBu0QzOd0uYGTpBp3JtuF6O9ytS60XiyrYn4Oy934r+niM6RgkYG6l
         NzaFrBtF22BJBQwQUgMa04fkS1s8OI7dgIHMA=
Received: by 10.204.151.207 with SMTP id d15mr1408145bkw.137.1252622022309; 
	Thu, 10 Sep 2009 15:33:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128156>

Hi all,

I faced a problem when trying to clone git://gitorious.org/qt/qt.git

this works:
git clone -n git://gitorious.org/qt/qt.git repo

this doesn't:
git clone -n git://gitorious.org/qt/qt.git repo >log
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed

I reproduced the error in the following versions:
git version 1.6.0.4
git version 1.6.4.2
git version 1.5.4.7

Any clues?
Thanks

Aloisio Almeida
