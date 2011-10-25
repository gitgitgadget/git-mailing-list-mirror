From: Eugene Sajine <euguess@gmail.com>
Subject: pull is not a git command - 1.7.6.4
Date: Tue, 25 Oct 2011 11:58:06 -0400
Message-ID: <CAPZPVFbakHo0hgz3bo+SLMuYnQSEA=ab+4W92+Lr5Fq4XZy2PA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 25 17:58:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIjOJ-0003K1-HT
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 17:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756721Ab1JYP6I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Oct 2011 11:58:08 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:38982 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756719Ab1JYP6H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Oct 2011 11:58:07 -0400
Received: by iaby12 with SMTP id y12so698714iab.19
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=LdLlD+WHXPaYAXKvW118Mxa5Uml1mSq1UvmR/8AySJs=;
        b=KVUJ1XCpMekeH6LqB5pyLHhIiPOeC/s6OwwuFxUXrO3afBztnly9AYoY7cvlIIFbMo
         +EMk8giGyDEtAHJH4n0PFHpYjMnvrpT8Ks8ZhP7WiFRm11rL91SUWwTHpp0dNnxBMg3q
         bS9XxS+2zg8DumC8A0RusxIJk+KGEet4IxLEI=
Received: by 10.231.29.79 with SMTP id p15mr539703ibc.16.1319558286536; Tue,
 25 Oct 2011 08:58:06 -0700 (PDT)
Received: by 10.231.199.17 with HTTP; Tue, 25 Oct 2011 08:58:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184214>

Hi,


We have built git 1.7.6.4 and we have a following problem with it:

It is localted in a folder /usr/local/git-1.7.6.4/
If the user has both /usr/local/git-1.7.6.4/ and
/usr/local/git-1.7.6.4/bin in $PATH variable then git works fine.
If the user doesn't have the upper level folder in the $PATH then git
cannot execute some commands like "git pull".
It says pull is not a git command. Or git gc complains that repack is
not a git command.

It doesn't seem to be the case with 1.7.4.1

Was there any change between those versions that i missed, or may be
there is some property we have to specify during build?

Thanks,
Eugene
