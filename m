From: Geoff Russell <geoffrey.russell@gmail.com>
Subject: Re: understanding how remote tracking works
Date: Mon, 9 Aug 2010 13:16:31 +0930
Message-ID: <AANLkTik7e8hS6Vk0ZJawQ56hFbXz5ri+nb4kqAJ+USBP@mail.gmail.com>
References: <AANLkTi=J3tDnZUg3k5bzDk2ydzYVVLKLwoW0gpBypYAs@mail.gmail.com>
	<i3nlq0$8un$1@dough.gmane.org>
	<AANLkTinktpx-rXj1K0BSy0Qwo62SEGFAJWvhKo0nJq=i@mail.gmail.com>
	<AANLkTi=usaZGfOM67acmdAWwvbHe_eHyjmRLGmdTYNaC@mail.gmail.com>
	<20100809021900.GA10596@burratino>
Reply-To: geoffrey.russell@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Witten <mfwitten@gmail.com>,
	Ralf Ebert <info@ralfebert.de>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 09 05:46:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiJJu-0003fc-U0
	for gcvg-git-2@lo.gmane.org; Mon, 09 Aug 2010 05:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755376Ab0HIDqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Aug 2010 23:46:34 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63560 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755135Ab0HIDqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Aug 2010 23:46:33 -0400
Received: by wwj40 with SMTP id 40so11130944wwj.1
        for <git@vger.kernel.org>; Sun, 08 Aug 2010 20:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type;
        bh=tbp/IeZ2pLunBQz47X+5+r3zMT5fXSlXHlALthlnWDI=;
        b=LBqeL77gGU0YHxkUaZuY5a6EEmMzvXoOa97DcEgP4wxDknSZzLFCKD5SJpM8uSxqQI
         q+c6uBG4tYsgpnanOBnDZvJZ5GitZTCi6MHFsinBSfB2Kyt6/sB1TysAWAY49Sk7/ZOI
         ac3C3OpGCUT04TTPPZEsGXme+/TFJ3sS9eZR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=Ds9WLJRUqPdynG6cybuAwfzplKEiVrXcS21tImN1MWJVpxkjUc9pp+oTxa7QEZUBX/
         lxVfizpB+DZe+X7+WWnbY6fvTAwL5lpTDUlwlnxq8NMm7BrOtg990YxshxFWKSMltopy
         RpivYUG+gTA2UBz1D3Qj7HN/8jIfFssv/vmRE=
Received: by 10.216.188.20 with SMTP id z20mr2121474wem.51.1281325591967; Sun,
 08 Aug 2010 20:46:31 -0700 (PDT)
Received: by 10.216.80.82 with HTTP; Sun, 8 Aug 2010 20:46:31 -0700 (PDT)
In-Reply-To: <20100809021900.GA10596@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152947>

On Mon, Aug 9, 2010 at 11:49 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Michael Witten wrote:
>> On Sun, Aug 8, 2010 at 20:53, Geoff Russell <geoffrey.russell@gmail.com> wrote:
>
>>> I'm working my way through Jon Loeliger's Git book and it's
>>> confusing when the actual behaviour differs from that in the book
>>
>> This probably results from the git culture's conflation (or should I
>> say confusion?) of low-level and high-level representations and
>> commands.

I often find the low-level commands easier to understand ... and they
don't change as often.

Geoff
