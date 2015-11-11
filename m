From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Allow git alias to override existing Git commands
Date: Wed, 11 Nov 2015 15:21:27 +0530
Message-ID: <56430F9F.7060900@gmail.com>
References: <56421BD9.5060501@game-point.net>
 <CAGZ79kZxQWVMe3N1ti8npyp9_4DUPAVy9Uk5a75Jwh3Eud2eZQ@mail.gmail.com>
 <56424DDE.2030808@game-point.net> <5642C8BA.8030003@gmail.com>
 <56430A27.2030604@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 10:52:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwS44-0000A8-CJ
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 10:51:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752457AbbKKJvg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 04:51:36 -0500
Received: from mail-pa0-f41.google.com ([209.85.220.41]:33992 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbKKJvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 04:51:32 -0500
Received: by padhx2 with SMTP id hx2so27119191pad.1
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 01:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=CaI0DaPm8coZD4vd9VIAX+XpE6MUFdM8MKmulanpf7U=;
        b=ZqAG5OlxIry4be0rDlECVdkzHttbtfXv9GNmHhsNzObKNciCnVWmNH3j/8ktqSWCsW
         BIJBOZl3JS3arqcKh2WUcOtKsLB2BZ0C1FM+n6mYTjnEzO6lW6fFL0cmFGnU5X93Nwkj
         hzLI6uG7XpsmC8fAuJiQqTzI1D64uAt4vGtypCgF7jNJuMZp9aAOS3otici7IV+Ad4D/
         v9pDDQACQ5xCceIRZ5fl2A9b6D97kUEHWtwtZ+WN8mytMbzZtdMVx1yJ3KxMcB00uvEm
         NbKnSP6oIno8Nb5vG9De5YBi3+AggzutzVE5xEL0qo9iS8vSsR+amXS6cL2iyg9e45S8
         UNvA==
X-Received: by 10.68.244.234 with SMTP id xj10mr13174621pbc.6.1447235492222;
        Wed, 11 Nov 2015 01:51:32 -0800 (PST)
Received: from sita-lt.atc.tcs.com ([117.195.175.90])
        by smtp.googlemail.com with ESMTPSA id y3sm8587448pbt.23.2015.11.11.01.51.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Nov 2015 01:51:31 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <56430A27.2030604@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281154>

On 11/11/15 14:58, Jeremy Morton wrote:
> On 11/11/2015 04:48, Sitaram Chamarty wrote:
>> A lot of things in Unix do follow that "give you rope to hang yourself"
>> philosophy.  I used to (and to *some* extent still do) think like that,
>> but some years of supporting normal users trying to do stuff has taught
>> me it's not always that simple.
>>
>> I can easily see someone blogging some cool way to do something, and a
>> less savvy user uses that in his gitconfig, and gets burned later
>> (possibly much later, enough that he does not easily make the
>> connection!)
> 
> We're not talking about "normal users" here, that's what Google Chrome
> is for.  We're talking about Git users using the commandline client.
> They ought to know what they're doing and if they don't, they're
> screwed anyway because there are quite a few gotchas with Git.

I can only repeat what I said before: it's not all black and white.

Reducing the opportunity to make mistakes is useful for everyone, even
expetrs.  Especially stuff that you may have setup aeons ago and hits
you only aeons later when something (supposedly unrelated) somewhere
else changes and you didn't remember and you tear your hair out.

It happens to everyone.  The only experts I know who have never torn
their hair out over something silly they forgot (could be anything) are
the ones who were already bald :)
