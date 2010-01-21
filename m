From: Howard Miller <howard@e-learndesign.co.uk>
Subject: Re: How do I get a list of tracking branches
Date: Thu, 21 Jan 2010 10:03:46 +0000
Message-ID: <26ae428a1001210203kf5feb0bt132546421a8fae2e@mail.gmail.com>
References: <26ae428a1001210125j156b61afs64bb915a934530c6@mail.gmail.com>
	 <4B5823C1.9010904@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 21 11:05:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXtud-0007Ur-TS
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 11:05:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923Ab0AUKDs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 05:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752742Ab0AUKDs
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 05:03:48 -0500
Received: from ey-out-2122.google.com ([74.125.78.26]:24726 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153Ab0AUKDr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 05:03:47 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1493689eyd.19
        for <git@vger.kernel.org>; Thu, 21 Jan 2010 02:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type;
        bh=OvGpr4RnSgCGjnjBrfwfXHaKwvGpqCL+ENhCm7kHV88=;
        b=FNOyAcD1jg2s7U0AloLnJVfQ8ug3cHSX7rB0vcQA3/rI1tRJdf/Wa10o5MkGsI1XBv
         Gq3PPmP6ViLmfHOs7Nne5MoYnef/AQ6XAlxaYS+QSSc458LIL2fmC/azJctSslWMRxrT
         D2vgS1VZcKP6OBAN6Sqxk1NsWvJrbtn2OmtCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        b=X9jXylUzzvn4zC5fPz5Z8/gTwV/uvzuAklth+DDWQ8hOxePwFxuCxhehBWYvcfwffL
         xmvFnpTz6HzTqfSf82tDzeNQCgaFqqVU0veK8kachRzsIW5LI8UMJ/IHvgsbVSDDh8dd
         fPFACRMDcll7GQz3o0olH0C0sYefIM4FZJs8g=
Received: by 10.213.0.212 with SMTP id 20mr2151258ebc.60.1264068226081; Thu, 
	21 Jan 2010 02:03:46 -0800 (PST)
In-Reply-To: <4B5823C1.9010904@drmicha.warpmail.net>
X-Google-Sender-Auth: c2bcbcb8fc329635
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137649>

>> I know I can go and look at the config file and get this info but is
>> there a simple command that shows which local branches are tracking
>> remote branches? It seems like a very obvious thing to want to know
>> but I can't find it. 'branch -av' even shows 'n behind' and/or 'n
>> ahead' but not *what* it is behind or ahead.
>
> The latter info you get with git branch -vv.
>
> But you said you wanted to know which local branches have upstreams. Or
> do you want to know which local branches have a specific remote as upstream?
>
> Michael

Hi Michael,

Thanks. That's *exactly* what I needed. It's just an extension of my
general rant that while git makes it very easy to create branches it
also makes it very easy to forget why you created them. Or it's easy
for me to forget anyway :-)

Howard
