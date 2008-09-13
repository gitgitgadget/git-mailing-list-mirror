From: "Miles Georgi" <azimux@gmail.com>
Subject: externals program, way to do svn:externals-like subproject management without git-submodule
Date: Sat, 13 Sep 2008 14:17:18 -0700
Message-ID: <853238710809131417v3818955sed4c0d3dd411a540@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 23:18:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KecVg-0000ZJ-Ue
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 23:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbYIMVRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 17:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYIMVRV
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 17:17:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:42052 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750981AbYIMVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 17:17:20 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1444900rvb.1
        for <git@vger.kernel.org>; Sat, 13 Sep 2008 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=b9EddiqHc2bwtCAbu5+7NBh5dFmFApGcN5oW6eRuXx8=;
        b=luCR1+9ivISNChHFNpHync/25i58SNaBfP32PYXg3WjZs8UrUnAECOiP7u8EwtK19T
         2v6WUmWd0DYUtfTYOUO8vfb0BSQfOSIT7rhG+I40hlaDc8lxynuvm+K6SmH6liEqhOCY
         k88JdVeVCe/78nPbndwPVHCEvKVj+PR9ZlZkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=anLnBPIdCOjoPDGyNqumTLGFXcknqXYOu+MAeAUQqCjFNjJimYMescO70iBLHu/Ibf
         //xlAZfhHt6wcfV5Xs/Ob8cc7nnQI28hoyiSS83SQ11jmx2MRgNI5xjzwwnMPzg+R0/5
         ky9ORlI4plrrHL6RzminUmRVoUqoRY/XSfmp4=
Received: by 10.141.163.12 with SMTP id q12mr3590926rvo.260.1221340638917;
        Sat, 13 Sep 2008 14:17:18 -0700 (PDT)
Received: by 10.141.98.11 with HTTP; Sat, 13 Sep 2008 14:17:18 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95816>

I recently wrote a program called externals to make it more simple for
me to manage/deploy subprojects in my ruby on rails apps.  The problem
was that my projects had a bunch of subprojects, some of which were in
svn some in git, and when it came to deploying/managing these
subprojects it was kind of a pain in the neck.  Also, I wasn't fully
satisfied with git-submodule.  I'm assuming that several people on
this list prefer the git-submodule workflow over svn:externals, but
for me, I find myself performing a lot of extra steps that were
unnecessary when working with svn:externals.  I've found the code I
wrote to be really useful so I cleaned it up a bit and released it to
the public as the externals project.  It provides an SCM agnostic way
of managing subprojects with an svn:externals-like workflow.

I posted this on the rails list a week ago (though it can certainly be
used in non-rails applications (it does require ruby to be installed,
and is best installed via rubygems))   I didn't get any feedback at
all which was kind of dissapointing.  I decided to mention it here to
see if I can get any feedback.

I have a tutorial demonstrating how to use ext here:
http://nopugs.com/ext-tutorial

Any feedback is greatly appreciated

Miles
