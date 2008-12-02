From: Nicholas Wieland <nicholas.wieland@gmail.com>
Subject: Overwrite master
Date: Tue, 2 Dec 2008 17:10:56 +0100
Message-ID: <D1AC0A41-E89A-4B53-A449-DA9C4422998E@zooppa.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 02 17:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7XrP-0003Mp-4w
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 17:12:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbYLBQLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 11:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751979AbYLBQLG
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 11:11:06 -0500
Received: from gv-out-0910.google.com ([216.239.58.188]:39745 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751348AbYLBQLE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 11:11:04 -0500
Received: by gv-out-0910.google.com with SMTP id e6so523686gvc.37
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 08:11:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:to:content-type
         :content-transfer-encoding:mime-version:subject:date:x-mailer:from;
        bh=ShmAsUaEMOQNegHENI8oZglh5jv8QHKY7lOYN2d2E+o=;
        b=Qv4zkPvn9QzxU6b3SE9z2jCX0dctxyn3NStxVxOm3jh96Fk5Anx4Gl8I4+l3j0nNyW
         FZBcLq3B6oZRMz2/Sqb9zc75Cz5XXSd3iDsfAjcdrDChPD15pn9KSjsdqqQbBhA2tGBF
         rzZR3SiLsseLlHwThftcqRVmeFGguDCEVd8r0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:to:content-type:content-transfer-encoding:mime-version
         :subject:date:x-mailer:from;
        b=XpDkm1Z2PuLHBAPbQrpjaf6kBRhphGE4GHkn/GfYUmdw0TmOygGIkDnROSbamfQ1KQ
         A/GkNA0XWFx8Zrd9UjE/46InZ46TLVgC9Eys1BTxLyJrD1a3iTJghIqYBIt506uJhmFn
         YSpNV8DAurFct/oP9W1iCCPnq84drd4A8HL5k=
Received: by 10.86.93.17 with SMTP id q17mr7332125fgb.8.1228234261990;
        Tue, 02 Dec 2008 08:11:01 -0800 (PST)
Received: from ?1.227.88.33? (89-96-108-180.ip12.fastwebnet.it [89.96.108.180])
        by mx.google.com with ESMTPS id 3sm1106240fge.31.2008.12.02.08.11.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 08:11:01 -0800 (PST)
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102152>

Hi *,
I need to overwrite my master branch with another branch. I've already  
created a backup branch of my master.
I tried a merge but it's just too big to handle, and I don't really  
care about what's in my master now.
The reason I want to do something like this is to be able to branch  
directly from my master in the future and merge back smaller branches  
(basically what I didn't do this time ...) instead of trying to merge  
back a huge one. This time I've used git like I've used svn, my bad,  
very stupid thing ...
Hope my question is clear.

TIA,
   ngw
