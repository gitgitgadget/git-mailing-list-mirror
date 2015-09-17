From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Feature Request] git blame showing only revisions from git rev-list --first-parent
Date: Thu, 17 Sep 2015 10:03:42 -0700
Message-ID: <xmqq1tdxj7v5.fsf@gitster.mtv.corp.google.com>
References: <CA+nPnMx1tkwTRckUjhg6LD055n-jzYDTKsH2sz-0PXPfJiy_tA@mail.gmail.com>
	<20150911140133.GA14311@sigill.intra.peff.net>
	<xmqqa8ss29tq.fsf@gitster.mtv.corp.google.com>
	<xmqqsi6kzsgc.fsf@gitster.mtv.corp.google.com>
	<20150912033054.GA30431@sigill.intra.peff.net>
	<xmqqy4gcxcp4.fsf@gitster.mtv.corp.google.com>
	<20150913100728.GA26562@sigill.intra.peff.net>
	<CAPc5daUcwCferagupF+iy3gxxorfMyEMn0oFMRWBNjc0=2r4og@mail.gmail.com>
	<20150915100538.GA21831@sigill.intra.peff.net>
	<xmqqwpvrtbbh.fsf@gitster.mtv.corp.google.com>
	<20150916173704.GA2727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stephen Connolly <stephen.alan.connolly@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:04:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZccbJ-00039l-Iv
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbbIQRD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:03:57 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35337 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbbIQRD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:03:56 -0400
Received: by pacfv12 with SMTP id fv12so25002272pac.2
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=jgshRCS2/o4tVLZNe9KjO0CjOdYkJ6pt9tlKS6RTjrw=;
        b=qn3BijlcZFMkDg3Dj11tbBK1mJgBl6qBW4Hlfowd0UT+qemvzpI3yAJIzHd2bMlGBR
         FuZB/h9gHWT1LzUyUfhlDs9+ScIN7n6jgpjiosK3hGgc3s/9lqczrC6ilzEqk8BkKIQN
         eR2kPtEnulFD3huzfm5yvKMA4G9oY30K1krzDuz16JwBo8+9645D/9rFwDvW+S1opNQB
         A5uidX6eLRo5oqnVydqY1lywn8a2J35vQQh4qQxlUAGP0Uj1cqf/sJyKxjWk8RhseEVg
         M4h36zz7YGv7T3ZYm1KaxObLNHGAV7gMDJz56/E72b9p9lHX6gM2I87W+QJKWyVHu5M5
         CUwg==
X-Received: by 10.68.215.73 with SMTP id og9mr347935pbc.122.1442509436454;
        Thu, 17 Sep 2015 10:03:56 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:25ac:307e:6383:2d03])
        by smtp.gmail.com with ESMTPSA id k10sm4421236pbq.78.2015.09.17.10.03.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 17 Sep 2015 10:03:55 -0700 (PDT)
In-Reply-To: <20150916173704.GA2727@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 16 Sep 2015 13:37:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278142>

Jeff King <peff@peff.net> writes:

> On Tue, Sep 15, 2015 at 06:14:26PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > It seems like nobody is actually that interested in what "blame
>> > --first-parent --reverse" does in the first place, though, and there's
>> > no reason for its complexity to hold up vanilla --first-parent. So what
>> > do you think of:
>> 
>> I like the part that explicitly disables the combination of the two
>> ;-)
>
> Meaning you didn't like the other part, or that you'll pick up the patch
> as-is? :)
>
> -Peff

I _especially_ like the part that explicitly disables the
combination of the two ;-)
