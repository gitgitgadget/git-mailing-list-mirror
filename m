From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: Why Is There No Bug Tracker And Why Are Patches Sent Instead Of
 Pull Requests
Date: Wed, 7 Mar 2012 19:03:17 +1100
Message-ID: <CAH5451mcu=sQa8KL8ptGr5w_d-OmtzAD9B-fwtMGE0w5zELgGA@mail.gmail.com>
References: <CAM=oOO2i-9zraF-YG5YzvZEmN1eXTnQfhJ-eMF04NP7HGtf41w@mail.gmail.com>
 <7vhay9tqs6.fsf@alter.siamese.dyndns.org> <20120229225304.GA9099@burratino>
 <CAH5451miv_Mo_9tZV+mfDEHuEX0491duqAYh66aOzLsMLTNkaA@mail.gmail.com>
 <8762eoimp0.fsf@thomas.inf.ethz.ch> <7vmx80nt68.fsf@alter.siamese.dyndns.org>
 <4F504699.3070406@gmail.com> <20120302041924.GG5248@burratino>
 <4F505F8C.70802@gmail.com> <7vsjhrfprz.fsf@alter.siamese.dyndns.org>
 <4F50D6C6.3080909@op5.se> <7vk433eyts.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Andreas Ericsson <ae@op5.se>,
	Neal Kreitzinger <nkreitzinger@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	opticyclic <opticyclic@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 09:04:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Bqn-0006vj-A0
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 09:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753756Ab2CGIDl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Mar 2012 03:03:41 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:42142 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab2CGIDj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2012 03:03:39 -0500
Received: by wejx9 with SMTP id x9so3581519wej.19
        for <git@vger.kernel.org>; Wed, 07 Mar 2012 00:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=xoXtVjX4PQSK1Tn8YMrsJZDOfL3Wqi2voYQwfp9J62o=;
        b=ZiTjfV9QBvoolHL2e1zSnJOyz2D0/DPktu2iha4/eVVONV4dRr2jPg3psUFMSytnb1
         HeYbSQzTfT6Q5vXBH5/74Y3/urDr6py1TyDw4SEaVfQZO/tP5V8F1J6zKCVoxLlwpj+s
         ivIJI1PGuSgXDiAWhhbxvN/VmlePaYugv/73LV8fEP8XgRpAlihI3+09U3CljHo3nSy3
         1LVUXvL3qsWML4cexV/gvBNY83nvyegFi3TQBZO+zH48M0fhPO1svtAfs+7xs5ubHcGe
         yFQySnqpyIHUVvJcE4FXY/vyASfNwe1OL4FRNks2ZTgWK83p9sF1R70SbrD12TQ2wqgh
         3zZg==
Received: by 10.180.93.232 with SMTP id cx8mr24454002wib.14.1331107418348;
 Wed, 07 Mar 2012 00:03:38 -0800 (PST)
Received: by 10.223.96.133 with HTTP; Wed, 7 Mar 2012 00:03:17 -0800 (PST)
In-Reply-To: <7vk433eyts.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192431>

Just a quick status update on where the issue tracker experiment at
git-scm.atlassian.net is up to:

The basic structure of the issue tracker is set up, and is ready for
people to log bugs if they want to. So far no one seems to inclined,
but note that it is still locked down to only people who have both
registered, and been promoted to 'trusted'. I will promote everyone
who has registered so far to 'trusted' in the hope that some of them
might add bugs!

The next main step is to have conversations on the list automatically
converted into issues that can be tracked. This will be either by
forwarding selected threads to the tracker, or forwarding everything
to the tracker and managing it from there. Unfortunately, a recent
upgrade broke the (unsupported) ability to create issues from
emails[1]. This will hopefully be fixed soon, and when it is we will
be able to move this experiment to the next phase.

If anyone has any ideas they would like to test, please let me know!

Regards,

Andrew Ardill

[1] Reply from Atlassian:
Officially we do not support
(http://confluence.atlassian.com/display/AOD/Restricted+Functions+in+Atlassian+OnDemand)
issue creation from email in OnDemand. The feature request for this
functionality is located at:
https://studio.atlassian.com/browse/JST-5649

There was the ability to create issues from email if emails were sent
to jira@<instance domain> as you tried to setup, but this
functionality was not officially supported and broke in the recent
JIRA 5 upgrade (which is why you receive those errors).

I believe we are planning to fix this in an upcoming bugfix release
within the next several weeks though, so please try again later.
