From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 18/19] index-helper: autorun
Date: Wed, 16 Mar 2016 18:37:01 +0700
Message-ID: <CACsJy8D7kg0Y2Yj=9N2uS-H6YNinD_GSkUbQpAmV0BcC77TuWw@mail.gmail.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
 <1457548582-28302-19-git-send-email-dturner@twopensource.com>
 <CACsJy8CaWFhCzrH3imz+BRMTESSmyUB4jeAaYUDNk+Tmpj-VrQ@mail.gmail.com> <alpine.DEB.2.20.1603151517590.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:37:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag9lk-00026g-SA
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 12:37:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934752AbcCPLhh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 07:37:37 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32834 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934302AbcCPLhc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 07:37:32 -0400
Received: by mail-lf0-f49.google.com with SMTP id h198so16923898lfh.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 04:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0hR6+X/gXxx5955gZZPt5+t3VNTbF1Poxi6oWZIhBtw=;
        b=zZs7h/OMHkYDBE/gEvENdquA73WKdUqTQCplgmO37i04BXN0L+qg2VzflJUZeqJO4R
         D+31pWlwh3dUBHSeaoyasZRKIXbGL0VMRb3DiI1jZO6LIxkxNvzbqdwiMsGGVbHAN8aF
         KTcuvWO6ea/xIzyUHrp5c6JFKxqiuRi7AnqWnaIV+FyGGyBK2AA//K8gANcZyvWUz8ku
         J8YQjBIEQEK7OG0q4R8Zjwa/oVPvSljvl24typuR1n+z7peZKEEn8zPW3RA5faI5usfz
         teVrAPj6qoco69U2GkwhV4CpxkBneRw8a7DMCTOFbJMGheUdeAlFWBihVzbXC+BuW0On
         hDcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0hR6+X/gXxx5955gZZPt5+t3VNTbF1Poxi6oWZIhBtw=;
        b=L6hAh7khH10N9WiKrb9TXfHB7itb9D0jVutE8SNCm6P1H5x5vZVq+t0WK3jf/SoOPo
         Fo1gbOD6JL3baJmAKYobbqIf+0RZece/HChD0qZbCHijly5CeMqevLuOBRG3abn3sCn/
         OtWHNWQ7FT0R4zj4HZANrfagvOT+d+A2K8n99Q3OQTpvXjfZjS1v2G+bYuM9x/jvUYLu
         LdV2gTD15J4ccZ9G5a0Y7ANVY5MGd2uq2XnnmDj76124kFAzN8MtDcjrxorYU7kW2Tad
         BYvXjORTRiVTGEmDiQ3Q7OlPlTt6KqIUVbI6S4S2d36qSCyA37h0a4sJEpyqlti7oflI
         uuHw==
X-Gm-Message-State: AD7BkJIkb6ZJHbj2oUSbVkqwnpe9dGDsFTVP/T4QSVBvuue8XTviWG7IrgUryEKpkBxQPPNWjTbG7Te+ZWMF8g==
X-Received: by 10.25.24.100 with SMTP id o97mr1299159lfi.112.1458128251131;
 Wed, 16 Mar 2016 04:37:31 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Wed, 16 Mar 2016 04:37:01 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603151517590.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288959>

On Tue, Mar 15, 2016 at 9:26 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Duy,
>
> On Tue, 15 Mar 2016, Duy Nguyen wrote:
>
>> On Thu, Mar 10, 2016 at 1:36 AM, David Turner <dturner@twopensource.com> wrote:
>> > Introduce a new config option, indexhelper.autorun, to automatically
>> > run git index-helper before starting up a builtin git command.  This
>> > enables users to keep index-helper running without manual
>> > intervention.
>>
>> This could be a problem on Windows because "index-helper --detach"
>> does not work there. I have no idea how "daemons" are managed on
>> Windows and not sure if our design is still good when such a "daemon"
>> is added on Windows. So I'm pulling Johannes in for his opinions.
>>
>> Background for Johannes. We're adding "git index-helper" daemon (one
>> per repo) to cache the index in memory to speed up index load time
>> (and in future probably name-hash too, I think it's also more often
>> used on Windows because of case-insensitive fs). It also enables
>> watchman (on Windows) for faster refresh. This patch allows to start
>> the daemon automatically if it's not running. But I don't know it will
>> work ok on Windows.
>>
>> Assuming that "index-helper" service has to be installed and started
>> from system, there can only be one service running right? This clashes
>> with the per-repo daemon design... I think it can stilf work, if the
>> main service just spawns new process, one for each repo. But again I'm
>> not sure.
>
> If we want to run the process as a Windows service, you are correct, there
> really can only be one. Worse: it runs with admin privileges.
>
> But why not just keep it running as a detached process?

Because I'm a Windows ignorant who assumed that it's the only way.

> We can run those
> on Windows, and if we're opening a named pipe whose name reveals the
> one-to-one mapping with the index in question, I think we are fine (read:
> we can detect whether the process is running already).
>
> We can even tell those processes to have a timeout, or to react to other
> system events.

So what's you're saying is, we can make this --detach option works,
like how it's daemonized in *nix, right? Then we should have no
problem with this autorun patch. Thanks for checking.

> Please note that I am *very* interested in this feature (speeding up index
> operations).

Yeah I thought so ;-) I'm counting on gfw devs to complete the Windows
part, if this series gets in.
-- 
Duy
