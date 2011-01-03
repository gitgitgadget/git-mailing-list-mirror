From: Levend Sayar <levendsayar@gmail.com>
Subject: clone --bare vs push
Date: Mon, 3 Jan 2011 20:24:14 +0200
Message-ID: <AANLkTi=RNDYrRbyEJXA_c30JEVr=SYUQ01cfA3FyWpLT@mail.gmail.com>
References: <AANLkTi=+cRqD_CDFyaYj8uWOxUA1+5Dgr_pv1guaaT40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 03 19:24:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PZp5G-0007Ma-B3
	for gcvg-git-2@lo.gmane.org; Mon, 03 Jan 2011 19:24:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099Ab1ACSYg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jan 2011 13:24:36 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57611 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab1ACSYf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jan 2011 13:24:35 -0500
Received: by qwa26 with SMTP id 26so13660421qwa.19
        for <git@vger.kernel.org>; Mon, 03 Jan 2011 10:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=zbsGZa+zK/CxCLLdy/MrHsOsN9ogyB+UyPv6A4J5tso=;
        b=MHRRjP/uw+t/9jX3FWq18HxHVQTOfad1/mrtkj3/s4H7UDQdq3v09OWkzyHgUT9g/0
         ln8NBEk6yOIckr8veT0rJH+E4STlsQRXJVBcAlwPv1Ty/37U1ZVx6bZAkR0XABAl29Rl
         EmVCcNbQThOaVt+M3ckhejBpO7vQlZWbGectU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=PsVFttuOn7jjlasbN14lo+4qZhNxcRu3NKy1GYAX1V4/TOGe++ViAa0TddE3QM+4fl
         qEJL97+e1fkbsy9zyS5D+4P5aG3YiJIQ2XLcfnPL3y5r3goAhbpWPBnPnGh9jfFO79r7
         I5trNh42/ErQqrxB6rX24YBHjhln/6G7mav7c=
Received: by 10.229.81.71 with SMTP id w7mr18474640qck.12.1294079074912; Mon,
 03 Jan 2011 10:24:34 -0800 (PST)
Received: by 10.229.219.147 with HTTP; Mon, 3 Jan 2011 10:24:14 -0800 (PST)
In-Reply-To: <AANLkTi=+cRqD_CDFyaYj8uWOxUA1+5Dgr_pv1guaaT40@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164454>

Hi, all.

We cloned a repo from github on our local server. Say X for this. At
that repo, we did

git clone --bare X y.git

Now y.git is ready for other machines to clone.

To update our upstream repo X, we do

git pull

and then

git push --all

to update y.git.

Now questions:

1) When I compare X/.git directory and y.git directory there are many
objects missing in y.git. What is the reason ?

2) git clone --bare is too fast. My .git directory is nearly 1GB. How
can it be copied that much fast ?

3) Is this more safe then git pull, git push

rm -rf y.git
git pull
git clone --bare X y.git

Namely bare cloning each time when we update our main repo ?

TIA

_lvnd_
 (^_^)
