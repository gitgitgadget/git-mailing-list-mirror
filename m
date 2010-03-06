From: Thomas Anderson <zelnaga@gmail.com>
Subject: a few beginner git questions
Date: Sat, 6 Mar 2010 00:42:40 -0600
Message-ID: <15b345f1003052242r7d812fe4q6ade253283696304@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 07:42:59 2010
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nnniz-0003yW-Ce
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 07:42:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275Ab0CFGmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 01:42:43 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:42213 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821Ab0CFGml (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 01:42:41 -0500
Received: by pwj8 with SMTP id 8so2822855pwj.19
        for <git@vger.kernel.org>; Fri, 05 Mar 2010 22:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=1aaq+X837O5MfGJk1O4WX4kd08S56E3whf9p3nooU1s=;
        b=fkhrL/NaOWefgFoRHnBU8DwrzN/PO/5FChCARR17O5Cm1WnsPvNjNz4s+rZe/L+Z6R
         k/mLyM0og31QL8/Qia60KRgz+Vg3qIEnSV38LhysK4Ez8BjtVD36u6beLSg9TZKHQFPX
         /sjBADcP/tZ0lY2hzAxuMJ+pmmhqE/cAWWzII=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pH90Sj1qBE60fxH1+b6Bdsq1pifJi9PT1rTeAM8mIRHboPUQHDIl+/XC23bAjgW3S7
         vvtKlHzic8T0AgXbQWeBJ5fRJ1VguHazt8iIsVkwKW4t7LCgrgkRzye+HZB5463Khcih
         46sx3toS6Toyd+4nDzkYpX7NLQt+0fxrdzMOk=
Received: by 10.142.119.33 with SMTP id r33mr1329121wfc.80.1267857760913; Fri, 
	05 Mar 2010 22:42:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141604>

A few questions.

1. When do you commit changes and when do you stage changes?  Or maybe
more to the point, what's the difference between doing "stage, commit,
stage, commit" and "stage, stage, commit"?

2. What's the difference between merging and pushing?  In CVS, you
merge code by manually adding changes.  ie. the CVS client doesn't do
the merging - you do.  Yet in Git Gui, there's a Merge menu button, as
if it's now supposed to be somehow automated?

3. Creating branches in Git Gui is easy enough but it's unclear to me
how to switch back to the trunk once you've created a branch.

4. I clone git://github.com/symfony/symfony.git to c:\git\test\root
and clone that to c:\git\test\clone.  I then blank
c:\git\test\clone\README, stage it, commit it and push it and the
change does not appear in c:\git\test\root\README.  I then reopen Git
Gui and open root and there I see the blanked README as an uncommited
state change.  I commit it and the change still does not appear in
c:\git\test\root\README.  Is this what Git should be doing?
