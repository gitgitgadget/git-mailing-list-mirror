From: "Leo Razoumov" <slonik.az@gmail.com>
Subject: why no "git fetch --dry-run" ?
Date: Fri, 21 Nov 2008 16:41:57 -0500
Message-ID: <ee2a733e0811211341j1e49fad7o64577605951fa5c0@mail.gmail.com>
Reply-To: SLONIK.AZ@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Nov 21 22:43:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3dmX-0004Wj-LN
	for gcvg-git-2@gmane.org; Fri, 21 Nov 2008 22:43:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752588AbYKUVmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Nov 2008 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbYKUVmA
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Nov 2008 16:42:00 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:18134 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752482AbYKUVl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Nov 2008 16:41:59 -0500
Received: by fg-out-1718.google.com with SMTP id 19so866759fgg.17
        for <git@vger.kernel.org>; Fri, 21 Nov 2008 13:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=2qcbOo1t0U/DiWANb2dm8E/xyNdW4Ni8yvayjVZYFpY=;
        b=VVD8ktECO9ryDceMf83TgEPy82gHAw5ATWE7yPk6R2uS4hDjaRvgEHaLBmHAgi4N/e
         Vdf1wx3OncdG7v+lWTbMAX064tpZrbNTorwn017C2ZOhJ13pfg0tnW2N4MC2dq3Hm49A
         7nlM8yoBdEmX+X4P4T4GP6J1Ja0GL1zOO/joQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=xPISwbiFCZWNb4PR3mPk1RKp2gaAUo+AdRjII9TeYRWxV0QMdiEa6+tk59rhrJSXLt
         AAcQhrbMjQPrlSD/Vb+PsLpv6ZePyQU1oRd4tpQFUQmoBICLVbvffUoIH+yseGI8Mjgu
         zTdnLRDIXpkoafMpMcxHbh3WS336UmULXN+Kk=
Received: by 10.180.246.2 with SMTP id t2mr278861bkh.161.1227303717658;
        Fri, 21 Nov 2008 13:41:57 -0800 (PST)
Received: by 10.181.7.8 with HTTP; Fri, 21 Nov 2008 13:41:57 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101542>

Hello List,
I am curious why there is "git push --dry-run" and no "git fetch
--dry-run" nor "git pull --dry-run". It would make sense to keep
push/pull/fetch as symmetric as possible.
For example, I just want to see which branches, if any, changed on a
remote repository since my last fetch. "git fetch -v --dry-run" would
be handy in this case.

--Leo--
