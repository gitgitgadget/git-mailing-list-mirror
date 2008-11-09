From: "Caleb Cushing" <xenoterracide@gmail.com>
Subject: force a merge conflict
Date: Sun, 9 Nov 2008 10:09:49 -0500
Message-ID: <81bfc67a0811090709s483506c1h6f9cb0f96216ef22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 09 16:11:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzBwO-0005w4-BI
	for gcvg-git-2@gmane.org; Sun, 09 Nov 2008 16:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbYKIPJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2008 10:09:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755111AbYKIPJu
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Nov 2008 10:09:50 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:36571 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbYKIPJt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Nov 2008 10:09:49 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2067789rvb.1
        for <git@vger.kernel.org>; Sun, 09 Nov 2008 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Jfl8Iw/O3/sii98KsNFkjFBdhKA8SULu9IRaY7QU/co=;
        b=gXZIqN8yO3IN+Ws8bGPqZ5Aw+QFnBWvlnFwtDHdZoBDq5+Wp9o+nsZouhheS1/yE6W
         1ZWG2O040xoICPNdLAamgsPkm3jHfPm5oOMkPMvxX+arNjjI9jroEGQVHH1/zRgFwV3H
         SSgnRwL2DmLrpBmiDVObtvtr7uzj8rsmDbWes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=qt/EUQkrQtvQZQSWJ/WHjJosmwc+kvDq228ImteVqjeWQKuZeMRoRkq+M9MgsIdQwY
         nGUMHaC2ZTQNmUhl8i+LjCCFCd4YkqZuDTHHNsPQp1mqdqvez15JBRvHarDRKTvyLiQ0
         Qd5kuUDFtGyShOj4fmj9KkVxIEgsKXrK4rudA=
Received: by 10.140.170.21 with SMTP id s21mr1352820rve.205.1226243389110;
        Sun, 09 Nov 2008 07:09:49 -0800 (PST)
Received: by 10.141.34.3 with HTTP; Sun, 9 Nov 2008 07:09:49 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100449>

is there any way to force a merge conflict?

there are 2 projects which have basically diverged becoming
incompatible, and both have updated since there common ancestry. I'm
working slowing on merging them back together.

in this case I have a dev branch and fork branch the fork is a copy of
dev except I committed one of the files from the fork. I need to merge
this file back into dev, but git thinks it's a fast forward, because
it really is for git, in reality it isn't, both files have newer
history than their common ancestry.

-- 
Caleb Cushing
