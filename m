From: Rostislav Svoboda <rostislav.svoboda@gmail.com>
Subject: fatal: bad object HEAD
Date: Thu, 19 Mar 2009 17:55:17 +0100
Message-ID: <286817520903190955n2e27abb6ydd52d9ddcffccbc7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 19 17:57:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkLY9-0006qK-AY
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 17:56:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050AbZCSQzX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 12:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754960AbZCSQzV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 12:55:21 -0400
Received: from mail-bw0-f169.google.com ([209.85.218.169]:43416 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753069AbZCSQzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 12:55:20 -0400
Received: by bwz17 with SMTP id 17so580082bwz.37
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=EYUHbQZl7wVb39HO70GKx3G2MsaHzQy71jQTvSywnlw=;
        b=m5BaV3TCoApFYcz+0alBe1jRhsOC60nFBRzaLaGWoyWWUW0dvmVPncgKYk0/3mn97a
         hcVoqE7XLG1mrwk2MdOWYFSWSdrhUJ7eIoWG+GDwb7lxFLQHC0+p3jmYVkbZuvIcjGC7
         5jEgDj2CC1lLZrHm+4ssxiJqVJ6Pat4JkuE18=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=UpCKznv/M/O5KvT3LHIAW6BprQqtCNxXlR91h7uuXHeBU4Sr+nolrEBkjkJZFSjo5a
         dOAN+0W0h9xJrJhmbHH5SeYLLLrPyjdEdTXq8i8y9DsfrmWeEaokeitziiLp0eqNXfUX
         aF/lKAiUfoEDQkVh9Gi5ONQ5CkYfjmoxUEjyw=
Received: by 10.204.55.15 with SMTP id s15mr899188bkg.53.1237481717058; Thu, 
	19 Mar 2009 09:55:17 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113792>

Hi people, I have a BIG trouble:

$ git fsck
error: refs/heads/branch_1 does not point to a valid object!
error: refs/heads/branch_2 does not point to a valid object!
error: refs/heads/branch_3 does not point to a valid object!
error: refs/heads/master does not point to a valid object!
(and quite many missing and dangling blobs)

I use msysGit 1.6.1-preview20081227 and I did:
$ git checkout master
$ git gui

here I got again and again that stupid error message
'file fname.ext has been modified but no changes detected' so I did
$ git add fname.ext
$ git branch branch_1    (here I did a mistake. I wanted to do 'git
checkout branch_1' )

And now is _everything_ seems to be lost... uaaaa :( What can I do now?
Any would be REALLY appreciated

Bost
