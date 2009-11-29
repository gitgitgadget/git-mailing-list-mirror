From: Justin Mattock <justinmattock@gmail.com>
Subject: help reverting a merge
Date: Sun, 29 Nov 2009 15:24:09 -0800
Message-ID: <dd18b0c30911291524q7ea7e9c7v980340ddf7269519@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 30 00:24:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEt7o-0004Dp-Jg
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 00:24:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943AbZK2XYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 18:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZK2XYE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 18:24:04 -0500
Received: from mail-px0-f173.google.com ([209.85.216.173]:48050 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbZK2XYD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 18:24:03 -0500
Received: by pxi3 with SMTP id 3so2298801pxi.22
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 15:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=k3fcPKrHSJw5ZUy6eboYt5Bg1Vtjcpi1Sn0hnUPm+nY=;
        b=EPO6pQH+f14I4SjPTtJra6nvth+NLFY+eJIBKg4oPWsY7YnARUze+vXzRBOgWV3klx
         TTkKU70WZfhYji1t+iX81KJ+PmB1M99C2UKswCi5Refek2RncSILbDi/8y0fW1mhUq9Q
         GW6bBn5+4aY53MZY3MnzWOhfshX/MtgAhDIXY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=iKciWdl3dewjy62HAXlWm0ujwqGCny4ine/5/Net/7g1DY2EZL5igdVfbQOB64er3W
         fMYflcGKFXj8tCfP6oo8LKpjcDOIARkfIBIUN8hsYCPkDvowOtbMsf3FNvTkKpFWe+F1
         qqwectveB1OnQm6xjtVPpkW7TTcb3unhK31yA=
Received: by 10.142.7.10 with SMTP id 10mr370441wfg.137.1259537049108; Sun, 29 
	Nov 2009 15:24:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134041>

(I'm not on the list, so hopefully this goes through).
I've done a bisect on a problem with the kernel,
and am a bit confused on what to do. i.g. the
results are showing this:
a03fdb7612874834d6847107198712d18b5242c7 is the first bad commit

when trying to revert this commit I get this:
git revert a03fdb7612874834d6847107198712d18b5242c7
fatal: Commit a03fdb7612874834d6847107198712d18b5242c7 is a merge but
no -m option was given.

then doing this I get this:

git revert -m 1 a03fdb7612874834d6847107198712d18b5242c7
Automatic revert failed.  After resolving the conflicts,
mark the corrected paths with 'git add <paths>' or 'git rm <paths>'
and commit the result.

how do I find out the commits in this merge to automatically
revert to find the problem that's causing this bug?


-- 
Justin P. Mattock
