From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [GSoC update] Sequencer --continue in pu
Date: Mon, 27 Jun 2011 21:49:49 +0530
Message-ID: <BANLkTi=65mpGmpZmb--2im96ABv74-m3kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 27 18:20:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbEXp-0003JP-9f
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 18:20:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752658Ab1F0QUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jun 2011 12:20:12 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:47727 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573Ab1F0QUK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 12:20:10 -0400
Received: by wyg8 with SMTP id 8so1192608wyg.19
        for <git@vger.kernel.org>; Mon, 27 Jun 2011 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:from:date:message-id:subject:to:cc
         :content-type;
        bh=StMC7kEF0K1nkh7TmaCGuy7gqVJw/i1DY3feXMJCe+I=;
        b=HpjRjj4i39+45k7wabtb1Lbx8b+RCS8vsPCd3JQLE72LoMqE5uB06ezLkWWb27eD8i
         s1nvAiwTN/vusfflmmahy9wSZ0ADImChHbPuGuhR9ddFoEHf7eDxIoras4vjfdpDETQg
         EXOdRvcmF+RSZPOO3SJPtbEfvYLU0Vs0Vsa+8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=EbSnfs8kEysbq2xoLpUZxeGlvpsbVpWwYcAhoQfWfc1cVVPFcYeIkmWvB0JybpMTGC
         1zCNzdYIfH+hzIKaBsmxHCM1vlyojm1Pw4dQD0LQ1x/GO3hLzB1E/OErHTkkQ3UmRt2z
         UH+63Zb49I/pHQHl+DegwbM9uWOY+gJG6vd7s=
Received: by 10.217.0.9 with SMTP id k9mr5435815wes.76.1309191609297; Mon, 27
 Jun 2011 09:20:09 -0700 (PDT)
Received: by 10.216.18.16 with HTTP; Mon, 27 Jun 2011 09:19:49 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176352>

Hi,

I haven't been able to do much work this week due to travelling and
some other engagements.  The latest series [1] is now in 'pu'
(31cd3b18), and should be accessible to a wider audience.  I will
hopefully have a nicer series with additional tests ready by the end
of the week.  While this cooks, I plan to sketch out some
post-mid-term work as RFC patches before the evaluations.

As usual, feel free to contact me about anything.  Thanks for reading.

-- Ram

[1]: http://thread.gmane.org/gmane.comp.version-control.git/176139
