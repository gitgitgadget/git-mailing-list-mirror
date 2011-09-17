From: robert mena <robert.mena@gmail.com>
Subject: Really removing a file named \\ from repository (gitolite)
Date: Sat, 17 Sep 2011 11:35:56 -0400
Message-ID: <CAAZ43xYOTYx8e-o9J4_bV9BRUT07ScUUrc=4SKaT9W7ytt7tDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 17 17:36:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4wvz-0007QF-1w
	for gcvg-git-2@lo.gmane.org; Sat, 17 Sep 2011 17:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab1IQPf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Sep 2011 11:35:58 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39029 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753224Ab1IQPf6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Sep 2011 11:35:58 -0400
Received: by fxe4 with SMTP id 4so2587749fxe.19
        for <git@vger.kernel.org>; Sat, 17 Sep 2011 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=0JXuNqbfLrQtKbbR4NtGyfRRlpU0nlHYKv/B3Bq0BqQ=;
        b=rYVWQx8nkU3cYHY25roDhrlzyD1yzF1xg8VoDg0TLuXSCP+n1rvhdptCrho/VD3vYf
         gGUQpmxZeVDVk8MMqNf5II86OqRxWiWxNx1QSxxLy6s4n4nQ2YfsGZlkRscX7n8trwbn
         5zV1zIgczRMtPvuDqA7Qng3htOKfGAKui/7cU=
Received: by 10.223.34.143 with SMTP id l15mr1404187fad.46.1316273756864; Sat,
 17 Sep 2011 08:35:56 -0700 (PDT)
Received: by 10.223.105.147 with HTTP; Sat, 17 Sep 2011 08:35:56 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181584>

Hi,

I have a problem.  I've created a repository and when I try to clone
it from netbeans under windows it gives me an IOException complaint
that he can't delete directory X.   I can do it fine from command line
(linux) and the same development build from netbeans mac.

While investigating I found that there was a file named \\ under the X
directory when I created the repository in the first place.  I've
successfully removed (rm and git commit / git push) but still the
netbeans under windows does not work with the same exception.

Any ideas?

Do I have to somehow nuke this file from the git repository so the IDE
does not try to fetch it?
