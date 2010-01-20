From: John Tapsell <johnflux@gmail.com>
Subject: git locate
Date: Wed, 20 Jan 2010 01:17:17 +0000
Message-ID: <43d8ce651001191717l58d10919j691f4e5b056fe9b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 20 02:17:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXPCF-0001YX-Bx
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 02:17:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755589Ab0ATBRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 20:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755524Ab0ATBRS
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 20:17:18 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:46791 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab0ATBRR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 20:17:17 -0500
Received: by pxi12 with SMTP id 12so5113578pxi.33
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 17:17:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=aE6jR8D3l7yUlqPb6Omz+26HBg/eU/4S8BJ1nbHnMBs=;
        b=fqtPcPPaQW+bVz1oIm+UEsi1goD2oTwCum49HrE8uRKELmM3ACs3A+rP6SWCy9sSCL
         kiQWm5zsUqS2oflVtRy8ARefW+6eXbDndXDQl0KvAd1YT79N7WWkyB+bUUik7wY5sXq4
         1P00nvrPvKZa1s4Vuelqn9kaFIeECD/80sr9s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=JIYvLzqOsX3nZkYhyvppXRF/7ci7yRXMSrYIRuXiSGYwC/NrpPn2yQM9e3wrav5bJ9
         mWzAypH0JKtPGIRCenln/FolJKBft1w/k5QSMGtA3hyn1BhkrudAcf9WFVCOnH+ykwBb
         h/DmyOvPFm7mnZn1gl1bqHwfNC64yyEe60dRQ=
Received: by 10.114.9.13 with SMTP id 13mr3857522wai.208.1263950237503; Tue, 
	19 Jan 2010 17:17:17 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137512>

Hey all,

  Could we add a:  git locate <filename>       or git find <filename>
 that is just an alias to "git ls-files | grep filename" ?

Reasons:

1) git ls-files   does not autocomplete, since it's an low-level
plumbing command
2) It's nice having shell equivalents - e.g.  git grep etc

John
