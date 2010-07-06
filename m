From: Mahesh Vaidya <forvaidya@gmail.com>
Subject: git sub modules related
Date: Tue, 6 Jul 2010 23:15:59 +0530
Message-ID: <AANLkTinej91PZbh_axJqz92mI0Y3GUako8tuKtU24iwV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 06 19:46:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWCDf-0008IB-Qv
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 19:46:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756091Ab0GFRqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jul 2010 13:46:01 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53204 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194Ab0GFRqA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jul 2010 13:46:00 -0400
Received: by gye5 with SMTP id 5so1934009gye.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 10:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=m3oTA574I0wUutT8StMPgSjV76HceNBIvizIjD56mHk=;
        b=ZjzdwNf9sDVjbsK8TeeicwHMka616j2dc+uwlm+Q0RrGVR1KWIVBbFJ2DYLoSdOGq/
         FUCZm9GBRevJVSkFKoVcgxE9G9Aq2G1HuXkaFGSPtYBbf1GRej9saDT8eLL1Y1yRY6Ny
         LyRM8NV3wvr31B6oSVbWj4pNNRRuUj0RrIgoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=dnY6isnpyeaSXBmxY49cRUGp8nySe7Le+nQZMl/xleE2CRf33DKcUekhT2lrkEcj6r
         fwLTp63NA/rNwNNi1JcI8qA+Qspn+Fe9aGXV5klp1T9hXFf/nF4hgoozczAjztrjUuMs
         ePeGl3PZ1w7cky5x1eIN8yHfr1vw8bmS99O3U=
Received: by 10.90.71.17 with SMTP id t17mr4417868aga.132.1278438359591; Tue, 
	06 Jul 2010 10:45:59 -0700 (PDT)
Received: by 10.90.100.4 with HTTP; Tue, 6 Jul 2010 10:45:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150379>

Hi

Created a 'super' level module top and add 2 sub modules a and b (As
given in manual); However I am not able to create a Global branch /
Tag.

super ---> a
          |
          ---->b

I am hoping to create a branch FOO which will recursively go in super,
a and b; In that case how do need to associate tags and branch in
super, a and b by a single artifact

Thx/ Mahesh
