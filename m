From: Alexei Sholik <alcosholik@gmail.com>
Subject: 'typechange' in the git-status output
Date: Mon, 14 Mar 2011 20:29:57 +0200
Message-ID: <AANLkTimWR0avW6mBWGa0ArVB8oZUM7nuvc5AYf=wgU-W@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 14 19:30:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzCWt-0002ui-7W
	for gcvg-git-2@lo.gmane.org; Mon, 14 Mar 2011 19:30:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474Ab1CNS37 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2011 14:29:59 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:61774 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753446Ab1CNS37 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2011 14:29:59 -0400
Received: by wya21 with SMTP id 21so4634747wya.19
        for <git@vger.kernel.org>; Mon, 14 Mar 2011 11:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=ZKO+IBf72rJIRF0wY65EKqEweqXHr9hUaMiCw9vJZKo=;
        b=hAvGoTjFV1vE5vG93/dEL92zGKPfIZaNa8IEJ0NK2+IHvgZkHEnFXtQbzwG7ENVArH
         gPD3m3v+pLoRxG9DnwQ6dE4oNbWgs60kduOUyeeiEZ3YwRlzp3zZIvDG79cUm35KoPUi
         uyaF13SRUaSmY5cAheAoBY5TND87Rt6gPeZwg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=oS352WcIJsd8IXyoIsGw3rNJ8xjKuDDMy3c/XGOz0jLmNvnMSiEK/3SVyblTJ8S0So
         u0eglC4wpprEvswOiXwPHgvGbaJ4lhR9KQibGcqI8l7U2/IcYc8Gz+9+UEGO9EBr5yeq
         ftFc4151dA7elPTMtSYF3Ibg2/cPBBSFRTbb0=
Received: by 10.216.22.79 with SMTP id s57mr2604250wes.94.1300127397844; Mon,
 14 Mar 2011 11:29:57 -0700 (PDT)
Received: by 10.216.1.142 with HTTP; Mon, 14 Mar 2011 11:29:57 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169005>

Hi git,

I cloned git mirror from github[1]. When I run git-status in it's
working directory, I see no output.

But then, after copying the whole directory with 'cp -r' and running
git-status in the newly created directory, I get the following:

> # On branch master
> # Changed but not updated:
> #   (use "git add <file>..." to update what will be committed)
> #   (use "git checkout -- <file>..." to discard changes in working directory)
> #
> #	typechange: RelNotes

git-diff shows

> diff --git a/RelNotes b/RelNotes
> new file mode 100644
> index 0000000..56c3863
> --- /dev/null
> +++ b/RelNotes
> ... // the whole contents of the file

Both copies of the repository are on the branch master with the latest
commit 07873dc. Simply diffing copies of the RelNotes file gives no
output.

What happened with the copied repository? I've found a couple of
instances of the word 'typechange' in the source, but no mention in
the docs. What does it mean and what could be the cause of this
change?


  [1]: git://github.com/git/git.git

-- 
Best regards,
Alexei Sholik
