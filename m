From: Jakub Narebski <jnareb@gmail.com>
Subject: StGIT loses Git commit using "stg repair"; I miss "stg assimilate"
Date: Mon, 7 Jan 2008 23:45:18 +0100
Message-ID: <200801072345.21585.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Catalin Marinas <catalin.marinas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 07 23:45:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JC0jE-0007lb-6U
	for gcvg-git-2@gmane.org; Mon, 07 Jan 2008 23:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbYAGWp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2008 17:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753829AbYAGWp1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jan 2008 17:45:27 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:26013 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752481AbYAGWp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2008 17:45:26 -0500
Received: by fk-out-0910.google.com with SMTP id z23so8763752fkz.5
        for <git@vger.kernel.org>; Mon, 07 Jan 2008 14:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=lT+/+jD/3MlH/UclP6EYGXVHOWveJtB4mG4QebgRbSE=;
        b=jYEGMkpYJtbpSex6V879CGAad+zHB0JRhEqxgNdET8CbQtBv+bTJ63BHXgQyzKQPihLEkNV0Do6hsKFfbtk7C8Sc5bx+ImeAxqakQHa9nrHbRKrsUr0Ch0Qi2Yoh7XOGH/Ld3mKvJiwVFwlMNlDUmfRJwLf8iQYlL8ju9oNpuYA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=tahQyz+D8MnI694DMgUrsMWdbv0L3SDVbM20F+GC3gz4KpAfaZwJ1Z7N8dPZeOWJTySahg+tN5qGe5n5vG/zZgLRJC8lJt/58CjcyxqwakiXhF6+7kLcFBrqvd+pHMpetfxVt7WUTQD/y2PYKh3YNw0k2AYCJptMkhFdF6u2T8Q=
Received: by 10.82.107.15 with SMTP id f15mr5326575buc.0.1199745923996;
        Mon, 07 Jan 2008 14:45:23 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.234.59])
        by mx.google.com with ESMTPS id c24sm13947448ika.10.2008.01.07.14.45.21
        (version=SSLv3 cipher=OTHER);
        Mon, 07 Jan 2008 14:45:23 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69822>

I have StGIT branch with no patches applied: all patches are on stack.
I have accidentally added git commit on top of StGIT branch head.
I tried to use "stg assimilate" to turn this commit into StGIT commit, 
applied, but new version of StGIT has only "stg repair". And the 
sequence

 # stg repair
 # stg rebase origin

made me lose this git commit (well, up to reflog of course). This should 
not happen! Why assimilate got removed?

4206:[gitweb/web@git]# stg --version
Stacked GIT 0.14.1
git version 1.5.3.7
Python version 2.4.3 (#1, Jun 13 2006, 16:41:18) 
[GCC 4.0.2 20051125 (Red Hat 4.0.2-8)]

-- 
Jakub Narebski
Poland
