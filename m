From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Sun, 20 Mar 2016 17:45:19 +0800
Message-ID: <CANYiYbFa5i-E0dYYj2dm4pHmQwLJfj3UBc3OspQz93HTP3C3Ng@mail.gmail.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
	<xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
	<xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
	<56E96096.4020108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Mar 20 10:45:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahZvV-0006Lc-Dz
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 10:45:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbcCTJpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 05:45:23 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36621 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753886AbcCTJpV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 05:45:21 -0400
Received: by mail-wm0-f48.google.com with SMTP id r129so16791741wmr.1
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 02:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=kYnIZP/q1qpiBlFsRaRbm+kSOnnRc3OBaGyGf/SYXHs=;
        b=o1Z0unvxJwCPMdWrih29FCfb4vKsPHNay4vQg5KYYMW9hmbzaQAHuiRVER88wsjaNB
         /LvjI6pdh+hsvLrUZa+PvRCLf7X2+82sFEu3jttNkUXn/RE5EGONEwJ2ggKcwjkpkWiw
         PNegqdjHep7YC+vMchE9b8x21hubLBqNlNNJo0rs4x5ShnoRujWWx1oaYFhjvBzm9RTq
         nleSmC8YmYjK8KZo5CISWuMdo5qBT14YuYMZtIOALkhRbSkTbZrt8S/P58Z4xSGK1pKW
         UzubjhGgTirOZB6dlzLeWM56HLGNvBqEGVMspuIDaBFdpA0X7ObXa/mM7LvUHD5vg558
         UHjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kYnIZP/q1qpiBlFsRaRbm+kSOnnRc3OBaGyGf/SYXHs=;
        b=JQJCinxayU8B211ppOVxhDl1jQOvDNQ4MBDqSjzHsvnGRwQ8kJbs8rEHxMxonMx5QJ
         iMRKWHc8EENBWpJla7SCCEpu9zNxI7ZN9T80wI8Gdg1vKssCPLxBoz7jqY1lipEaEhls
         SnvySwtJosLsFeTGCsctgtkw87SsDi9wnAUu46Xl3RsANEPjzV8T7xLop2tll+bK+XYe
         WwuN3JkcAkyp4IFUpWczFxO0wgPOVYlw4kchFgWUDYoTL+wZ/CPqAPOIkYmiNv82a3fE
         ctb1QfVWYRHZpHTj05GKLCW7qji+3+4N+GR2PCetTg2ZFQmQEn/F/vN25eKcxIziJtub
         bHnA==
X-Gm-Message-State: AD7BkJLUgjCe66tyZt7T3yY4gWwNs0Gvfq24wT/eo3mvs7gCPlnDj4gsZ+YwHGYtm5zUwFhFcMQiHOn4yugxig==
X-Received: by 10.194.227.1 with SMTP id rw1mr23870639wjc.62.1458467119832;
 Sun, 20 Mar 2016 02:45:19 -0700 (PDT)
Received: by 10.194.54.8 with HTTP; Sun, 20 Mar 2016 02:45:19 -0700 (PDT)
In-Reply-To: <56E96096.4020108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289344>

2016-03-16 21:33 GMT+08:00 Michael J Gruber <git@drmicha.warpmail.net>:
> Junio C Hamano venit, vidit, dixit 14.03.2016 18:47:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> But if it makes it easier for translations teams and the i18n
>>> coordinator to work together if I also pulled the git.pot update
>>> myself, I'll do so.  I just didn't know (and still don't know) if
>>> that makes things easier for you guys, or if that risks making
>>> things more confusing, having to or being able to pull from two
>>> trees that are not necessarily in sync down to the minute.
>>
>> So, please just tell me to pull it myself too, if it makes the life
>> of i18n team and the coordinator easier.
>>
>> Thanks.
>>
>
> I don't know about the workflow in general. I'll write up what triggered
> my question: I was looking at the FAQ "how do I display the current
> branch in git" and into ways to provide some ui (think "git status -sb",
> the "+"-line in "git branch"), when I found the problematic output. The
> multiple parentheses looked suspicious to me, but given the many levels
> of macro expansion I wasn't sure, and simply patching the parentheses
> didn't help either. It needed a combination of "make pot" and "msgmerge
> ...", and the fact that the last merge of git.pot was from 2.7.0-rc
> triggered my request to merge what we have.
>
> In hindsight, what happened must have been like this:
>
> "ahead " was marked properly for l10n and translated in the past.
>
> 7a76c28 (status: disable translation when --porcelain is used,
> 2014-03-20) introduced those extra parentheses. Matthieu probably didn't
> rerun "make pot" and "msgmerge" so that he didn't notice the consequences.
>
> When Jian ran "make pot" the "ahead "-entry got removed from git.pot:
> 5e078fc (l10n: git.pot: v2.0.0 round 1 (45 new, 28 removed), 2014-04-19)
>
> When translators ran "msgmerge" with the new git.pot the existing "ahead
> "-entry got commented out, for example here for de.po:
> 74c17bb (l10n: de.po: translate 45 new messages, 2014-04-01)
>
> I'm actually wondering why I didn't notice this much earlier. I don't
> know which workflow would have prevented this either. Maybe, since we
> have "make pot", we should also have "make l10n" or something to make it
> (even) easier for non-l10n-experts to check whether they introduced any
> problems.
>
> Strictly speaking, every source file with i18n markup should trigger a
> "make pot" (and make l10n) when changed, but there's probably a good
> reason why we don't do that.

How about this?  We can make a website (host on github) to show i18n
changes. Homepage is just a markdown page, list no-merge commits
which introduced i18n changes. So we don't have to change the workflow.

1. A local git clone, keep update with upstream.
2. Give a starting point, and generate a no-merge commit list.
3. Scan through local git clone and generate a pot file for each
    commit and its parent commit, and save them in cache (by hard
    link to save disk space).
4. Generate diffs for each commit.
5. Generate the MarkDown web page through a template.
6. Commit the changes of the markdown page, and push to github.

-- 
Jiang Xin
