From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: newbie with broken workflow
Date: Fri, 4 Apr 2008 00:03:01 +0200
Message-ID: <8aa486160804031503j1ff3adbcu83f41eef14347370@mail.gmail.com>
References: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "James Kingston" <james.kingston@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 00:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhXXC-0008NZ-F3
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 00:03:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756935AbYDCWDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 18:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756904AbYDCWDG
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 18:03:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:3836 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756918AbYDCWDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 18:03:04 -0400
Received: by ug-out-1314.google.com with SMTP id z38so837295ugc.16
        for <git@vger.kernel.org>; Thu, 03 Apr 2008 15:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4P2hWJKhr4E7diFDMLLHnFb3wjEyG9G1WB6UaOYw+lw=;
        b=RQeoeXECDT+Fb4UCLmaon6t/IaQi0MINFy0FVCuMrnjr7+LqFNjySdk4MUZqZZjUyo4XnMH1ZeCHZIwIl0JeWQ3ZgRVMDmbOnIfSzb+1CwqWadOSaccWJ5KG6PDro9hSQsWFrgqa5p+bGgVCrlCYYvyWnJm9fB/q2T3qITNXDS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rcxqSsBj6EKaPWyK9rPd+CXmOR84+J9mlwweCr5a1rDuvo6q9z4k7N+i4rrKl28tsef3eOKNSXH5sqJS7/nK1dqbmAyopbb2VsWik6L7+MJ1lSHfOOLFxo85gSAaeMVawDWh/uk9XO+ZZyZHJoA3EtCP7XejnhVOIcb7o93VdGs=
Received: by 10.151.110.14 with SMTP id n14mr167543ybm.188.1207260181166;
        Thu, 03 Apr 2008 15:03:01 -0700 (PDT)
Received: by 10.151.14.14 with HTTP; Thu, 3 Apr 2008 15:03:01 -0700 (PDT)
In-Reply-To: <9d27c6320804031445p3fc80115n59218673dd587795@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78785>

On Thu, Apr 3, 2008 at 11:45 PM, James Kingston
<james.kingston@gmail.com> wrote:
[...]

>
>  /c>     cd /c/cc
>  /c/cc>  git init
>  /c/cc>  git add *
>  /c/cc>  git commit
>  /c/cc>  mkdir /c/wd
>  /c/cc>  cd /c/wd
>  /c/wd>  git clone /c/cc
>  /c/wd>  cd cc/
>  /c/wd/cc>  ls
>  /c/wd/cc>  vi config.ini
>  /c/wd/cc>  git checkout -b config_changes
>  /c/wd/cc>  git diff
>  /c/wd/cc>  git add config.ini
>  /c/wd/cc>  git commit
>  /c/wd/cc>  git checkout master
>  /c/wd/cc>  git merge config_changes
>  /c/wd/cc>  vi config.ini
>  /c/wd/cc>  git push /c/cc

git push updates the branches, not the working copy, so:

cd /c/cc
git pull /c/wd/cc HEAD

>  /c/wd/cc>  cd /c/cc
>  /c/cc>  vi config.ini # doesn't show the change made in experimental
>  branch, though gitk shows the patch
>  /c/cc>  git status # says that config.ini has been modified
>  /c/cc>  git add config.ini # grasping as straws
>  /c/cc>  git commit # changes nothing, as far as I can tell
>  /c/cc>  git reset --hard #still changes nothing.  My diffs are there
>  in the log, just out of reach
>

Santi
