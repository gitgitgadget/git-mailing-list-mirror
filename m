From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 15:33:26 +0530
Message-ID: <535E276E.8090306@gmail.com>
References: <535C47BF.2070805@game-point.net>	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>	<535D4085.4040707@game-point.net>	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com> <87zjj656my.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeremy Morton <admin@game-point.net>,
	Git mailing list <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>, Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 12:03:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeiPS-00021y-Tb
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 12:03:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754599AbaD1KDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 06:03:34 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:47621 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754099AbaD1KDc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 06:03:32 -0400
Received: by mail-pd0-f178.google.com with SMTP id fp1so3410022pdb.9
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 03:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=NDngYjOFAxfLXtPB7XVSwAxM7eQ55KOH6XfttdG3mVA=;
        b=DhSrhXUKeF2bakkReebhaAdPmuZYpY69fZWFnck+QeHJvGW76taXpJrcJi21AmDuWb
         YXKe3GAqguveTrIUAycR30lK6xcHwuq+IMzJC5WRa+QCvtFpqBkRDt3R1+W0eBfJ4i4B
         P+6sM1B4Hf8AHaROvYp6R9djo4uTpHOaAqowHcUB9gZ4m9vuhJf/zylT4FV/7jkQ59af
         L0HRIGG2rXF1RM2fKQVAoc4TkrHDX3lZxIVsroP9dbpOq0ZMsgbxT8soJ0ksPvmRXjcn
         QXIRIYqwUINGA+PrymExQg/9IWLcNXhnKVVdqVZmwx2nUZtZaHGC1uouRxHHN57f+QG4
         ibOg==
X-Received: by 10.68.143.231 with SMTP id sh7mr28020618pbb.7.1398679412242;
        Mon, 28 Apr 2014 03:03:32 -0700 (PDT)
Received: from sita-lt.atc.tcs.com (atcmail.atc.tcs.com. [203.200.212.145])
        by mx.google.com with ESMTPSA id oe4sm33889081pbb.33.2014.04.28.03.03.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Apr 2014 03:03:31 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <87zjj656my.fsf@fencepost.gnu.org>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247265>

On 04/28/2014 11:37 AM, David Kastrup wrote:
> Johan Herland <johan@herland.net> writes:
>
>> Obviously, the feature would necessarily have to be optional, simply
>> because Git would have to keep understanding the old commit object
>> format for a LONG time (probably indefinitely), and there's nothing
>> you can do to prevent others from creating old-style commit objects.

Johan: I seem to have missed your previous email (fat-fingered something
on my mail client I expect).

Your **reasons** for making it optional are all wrong.  People like me
(and David) who are opposed to this run the risk that if the **format**
were to officially change in some way or for some reason (like, say, if
SHA1 is no longer in favour, or whatever), then this "feature" is
foisted on us willy-nilly.

That's not good.

So, while I appreciate your point that it should be optional, please
let's accept that in the end it should be optional because **not
everyone likes it**!

> Personally, I am _strongly_ opposed.  How I name and juggle my private
> branches is nobody else's business in a distributed version control
> system.
>
> They are private.  My personal workflow.  Not part of a commit.

Hear hear!!
