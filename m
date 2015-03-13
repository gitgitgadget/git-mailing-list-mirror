From: chen chang <chenchangs@gmail.com>
Subject: Is it possible get the tag name of working copy in Git?
Date: Fri, 13 Mar 2015 15:08:12 +0800
Message-ID: <CAFL7HFUNMrTfLx+kj6rBiNeuLhbkPF_t32kOYYSxBP9F=eKSxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 13 08:08:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWJi4-00084T-4l
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 08:08:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751732AbbCMHIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 03:08:35 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36100 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbbCMHIe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 03:08:34 -0400
Received: by lbiz11 with SMTP id z11so20931175lbi.3
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 00:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=eNKNiaQdiVsqzTtoiN1e8OvERqsJQf9O7iaxcG81OVA=;
        b=rfrxI6EWUjB0UxBfyc28yZfYGGEr5UurJNXlauToVym1laX6vcS7WbU5UOk+WkTZIP
         zUhSDKT5bEHp3/shZpIakgUdG4DxNK690jYHe3GpMY/JaPRyKg+McSl6Fa9/PxMt+evr
         KcDsblP+3z7Ekhn8IrreM1T6vkH6nFPBlqphdEQEttVfaBgMgXuXUOABtespKdhEyJGn
         DxMCLHxMz/JqkRb9zxk4k4dHFK4P1W+NQ5enQCzMD/l/lqw3/EFipbCuWlPpa7vdm8my
         mdK2tpLjUd/hyioQYEYI6JfTdzx9GzQepRCL+MyYvrtdfk/bRS3IrqrMIvnwjuNabeSI
         Zrmg==
X-Received: by 10.152.87.176 with SMTP id az16mr9867767lab.61.1426230513199;
 Fri, 13 Mar 2015 00:08:33 -0700 (PDT)
Received: by 10.114.20.137 with HTTP; Fri, 13 Mar 2015 00:08:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265408>

I want to use make file auto generate the revision number of working
copy from the tag name in git.
So as questioned in subject, I have tried to use 'git describe', it
works well in most case, and the output is good match my requirement.
Problem is: when there are multiple tags on same one commit, if check
out one of these tag, the 'git describe' only be able to return the
most new created tag name in that commit, instead of the real checked
out tag.

Seems 'git-describe' capture the most recent tag name by create sequence.

I expect add an argument to 'git-describe' to make it get the most
recent tag name according to checkout status when multiple tags on one
commit.

Is there any suggestion? Thanks!

------------------------------
Chen Chang
