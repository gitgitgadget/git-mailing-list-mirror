From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: What is missing from Git v2.0
Date: Mon, 21 Apr 2014 21:24:33 +0200
Message-ID: <53557071.5040500@gmail.com>
References: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 21 21:24:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcJpf-0001pO-NY
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:24:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbaDUTYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:24:44 -0400
Received: from mail-ee0-f53.google.com ([74.125.83.53]:54108 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbaDUTYm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:24:42 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so3869344eek.12
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 12:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=h0zHQqtjJOpUcXA4Xb75vxbNuenGmPWTNZh376QS+/M=;
        b=DHCJLsJLKwihCJy6Q7MjqFiyF0lXKRiYaLJ3XEUMSy84gyEHyPvHdh1uG4CkjgDKIa
         Ba/CISj0PR0FfOSxDBineGHYIvvpt+chQVZV9ZthIRkREIy+iIzdkoSv3FUVQmghLwkO
         AtGAB1Smu9zi5eGZ1bfFNTguYMOaHq2dKodN24ukmeURnPelLQU9gUpRo/HzCXrO2jno
         sfUywQkEIgKvUvC4VbPXennt9AzKRjSOJnMKB6u3BoY7YoFAlV6ntig7LnFgCRK7rtqn
         P8w3OvCN3Uz9s4HZXXovVHsnaimu7/wO0K4KYAGNZ6LsddeZ7n+QswiGQwjv2XIwaXlf
         TNSA==
X-Received: by 10.14.99.68 with SMTP id w44mr4403480eef.82.1398108281028;
        Mon, 21 Apr 2014 12:24:41 -0700 (PDT)
Received: from [192.168.188.20] (p57A25734.dip0.t-ipconnect.de. [87.162.87.52])
        by mx.google.com with ESMTPSA id t44sm106107804eeo.6.2014.04.21.12.24.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 12:24:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAMP44s17h4Tjg+VaMF0atLep8t-0HVp4UDr1WE2wYnEuZ07eaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246624>

On 21.04.2014 00:41, Felipe Contreras wrote:

> = Default aliases =
>
> Every single version control tool out there has default aliases (e.g.
> co = checkout) except Git.
>
> Every argument against default aliases was basically refuted, yet my
> patches went nowhere. And the users still expect these aliases.

+1 about having default aliases in general, and I'd also add these:

br = branch
cp = cherry-pick
dt = difftool
mt = mergetool

BTW, in my experience people tend to stick to predefined aliases instead 
of redefining them to something (completely) different. This means that 
having default aliases will very likely enable one to use the same short 
commands on one's colleague's PC (instead of you running into issues 
because the same alias was defined to a different command).

If we don't standardize this now people will come up with their own 
definitions [1] [2] (and many others if you just search GitHub) which 
are again likely to differ (slightly), hindering interoperability.

[1] https://github.com/github/msysgit/pull/27
[2] https://github.com/sschuberth/dev-scripts/blob/master/git/.gitconfig

-- 
Sebastian Schuberth
