From: Omar Othman <omar.othman@booking.com>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 08:34:20 +0100
Message-ID: <530D98FC.1020601@booking.com>
References: <530B0395.5030407@booking.com> <CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com> <vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 08:34:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIZ0d-0002m1-Sx
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 08:34:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbaBZHeY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 02:34:24 -0500
Received: from mail-out7.booking.com ([5.57.20.191]:47414 "EHLO
	mail-out7.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbaBZHeX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 02:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com; s=bk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=574vlOYaYINoqD2+Telx9KL60g4erlJ5Eos6ZxLNT4Y=;
	b=C0veJ3i0vBjhXfq+8qwE6Su514osDj4+EKGWYWD9fhcySXqmXjkCzE/0qMW4I4nx+6Pq0DzvHZP9iMg29uuXwgu679WuMUM4v7OxE+uV90hT3ukwMI8Z+KkgXr7M6rRHBTLfV6SQT7TjuAEFokDIVEXI7+m948RHqHBdjyizlhM=;
Received: from corpds-202.lhr4.corp.booking.com ([10.186.68.14]:37139)
	by mtx-203.lhr4.prod.booking.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIZ0X-000CKK-H6; Wed, 26 Feb 2014 08:34:21 +0100
Received: from [10.155.74.57] (port=32980)
	by corpds-202.lhr4.corp.booking.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIZ0X-0002lL-Bw; Wed, 26 Feb 2014 08:34:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <530C893D.7000108@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242699>


> Am 24.02.2014 17:21, schrieb Matthieu Moy:
>> $ git add foo.txt
>> $ git status
>> On branch master
>> Changes to be committed:
>>    (use "git reset HEAD <file>..." to unstage)
>>
>>          modified:   foo.txt
>
> Maybe status should display a stash count if that count is > 0, as 
> this is part of the state of the repo.
>
> $ git status
> On branch master
> Stashes: 1                         <----------
> Changes to be committed:
>     (use "git reset HEAD <file>..." to unstage)
>
>           modified:   foo.txt
>
> It would be in Omars example case a clear message that git kept the 
> stash. And generally a reminder that there is still a stash around 
> that might or might not be obsolete.
Again, the same comment: If there is a way to customize git's messages 
by turning them on/off (or, even cooler, the ability to change their 
wording) then this is also a nice option to have and we can turn it off 
by default if we find that most people (here at least) don't like it. I 
don't know whether you guys have discussed this option before (or does 
it exist? I doubt, but I don't know), because having such an option (the 
ability to turn messages on/off or change their wording and what 
internal status information they manifest) will really resolve all kinds 
of such potential conflicts of preferences. Even cooler, people will be 
able to change the wording to their native languages for example.
