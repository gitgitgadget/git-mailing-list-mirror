From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 06/45] Move sequencer to builtin
Date: Sun, 9 Jun 2013 22:37:52 +0530
Message-ID: <CALkWK0nA=27wqds-FZfPFtzdsAm1VKsZOF4hAOCLNi==FjrkKw@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-7-git-send-email-felipe.contreras@gmail.com> <CALWbr2z_VArUi_4iKgdUgmUTA0hQ0EDF9ZuMs4RdEEZfnFOxMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:08:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulj6c-0005qO-NI
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789Ab3FIRIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:08:34 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:37009 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab3FIRIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:08:34 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so14480989iea.17
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+PfgHZKW6478B/fhCzMY3ebKDbeeayZDMDtzxDm14Pg=;
        b=jdN9qE44SGeRByo4GOJQatfKjjUAzT+exVe0H040Hlk+iRh+Ub2ciHvBnazNEympNR
         icCQDCa3GD1sLvUCZ1w1FkKwHzF0H7UocCwi9f85GRkSE78UyeuKgZ5b1WDjdn/ttf45
         iGaMlMZ2Zt/ocQ51cxoJCMUlPpMwqu7UoVPhmWtfiwEBX5KeKWsi0oq2iVYIfI4W5hrq
         PivWYvvLtg/Sg+vTuuCPPmGf/XOJC0YINh38DnS3r9PwLc2dt2EYuD+7HTcTT9j0jB8a
         b1S0KrAzdnIWYPQlF6AqtCW9LzYFEvnDzzKg/Qfd6jBOIK+HnWRAhQZQs1dTWhRzlwcZ
         0EWg==
X-Received: by 10.50.98.104 with SMTP id eh8mr2566066igb.111.1370797713753;
 Sun, 09 Jun 2013 10:08:33 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 10:07:52 -0700 (PDT)
In-Reply-To: <CALWbr2z_VArUi_4iKgdUgmUTA0hQ0EDF9ZuMs4RdEEZfnFOxMw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227023>

Antoine Pelisse wrote:
> I don't understand why the code doesn't belong to libgit.a, and how
> it's gonna make it more "clean". I can see that it is needed only by
> revert and cherry-pick, but is that the only reason ?

Perhaps this will help? [1].  Join into the discussion.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/226845
