From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: About the .gitmodules file
Date: Wed, 2 Jan 2008 16:39:24 +0600
Message-ID: <7bfdc29a0801020239w6f4133d3pc6f1aa325b1067db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 02 11:40:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA10x-0007Dn-Nd
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 11:40:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083AbYABKj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2008 05:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754030AbYABKj0
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 05:39:26 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:22729 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbYABKj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2008 05:39:26 -0500
Received: by fk-out-0910.google.com with SMTP id z23so6061373fkz.5
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=ZN00MFWuvFtUILDtQiDHo4Y/h66B59QkLKdEiaGYGhM=;
        b=TvSWat+v5BQaRAWHwPYA1yndCOVmGkBcPKsKHAprrDlxik4uBtxZxh17hBJ3LkML3o/bQyL1cdZMcOBasVfBnixliqLVKUUtaz5kaivWECMuT+usaWD12AgpAfkY+Oy0gzf61Rr/O0hYy+Bb3/68SIBeD9VXY2opi0rU3YHdCkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q3uhPb2q8eB1UpBOCPNVnlPnaFDPtbBV67kuou1JKf/o50j24bfqgHyytF2ZqcNpAt76IjIP07bW072GmmsQ88yNdMmuav4NgGCMHXUlx7dmiPfVNj9YcCt6yXQ2kyeisFtp8THaAT1WIPpKfX8mBiCalVdiQ3cniO+co6CtpNI=
Received: by 10.78.145.14 with SMTP id s14mr16369506hud.58.1199270364454;
        Wed, 02 Jan 2008 02:39:24 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 2 Jan 2008 02:39:24 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69470>

Hi All,

I need a help in order to parse the .gitmodules file generated on
"git-submodule add". An entry for a submodule in that file looks like:

    [submodule "a"]
            path = a
            url = /home/imyousuf/projects/git-projs/smart-sip/submodules/a/.git

I want to parse this file to know the location of my module so that
when I got git-commit on the parent project my script will also
traverse the submodule hierarchy. I wanted to know whether path = a
noted the relative path from the current directory or not.

Thanks in advance,

-- 
Imran M Yousuf
