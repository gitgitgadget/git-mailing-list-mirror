From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH v4 06/45] Move sequencer to builtin
Date: Sun, 9 Jun 2013 19:10:37 +0200
Message-ID: <CALWbr2yfbmkFQzm_GJHJWTXwge4WRReOokcRDCfEdAjTP9_y2A@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-7-git-send-email-felipe.contreras@gmail.com>
	<CALWbr2z_VArUi_4iKgdUgmUTA0hQ0EDF9ZuMs4RdEEZfnFOxMw@mail.gmail.com>
	<CALkWK0nA=27wqds-FZfPFtzdsAm1VKsZOF4hAOCLNi==FjrkKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:10:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulj8d-00076s-0i
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750908Ab3FIRKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:10:39 -0400
Received: from mail-qe0-f45.google.com ([209.85.128.45]:41377 "EHLO
	mail-qe0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab3FIRKi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:10:38 -0400
Received: by mail-qe0-f45.google.com with SMTP id w7so757806qeb.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6gH78j636gYhUjpg3jauf5m54N377tKASe1GAip2Qvw=;
        b=dTnpPsYr3G3ynDOUEKv63iNqH+Mxqa95G9OCWQmCwWy6PzWXObQgLe4vBlxRB89r3t
         ftZTg4YPl4YeGDwag4RBpJiGiIZkbb2dnAVvfJwzcyLoXjNG/Ni3bnqwEVH9RWh4Lwbi
         ipmlngRKyPiqrnKIUAjHUsUIXbwuUMf/ex8xFMfOHZnzBHcMCaL+D2C63jAqsiEW88l0
         cdQEgTtYFZ/rk01770wEDgzx/3x3Q8tRzqCNLqRRBHcVRUpH1n8Px/GV/HGYtbJ53gP8
         YasCg8ZDsogOHfIrTndTcLDrJ+ovwo8GAAYpHhjg+22ncRi4UCtkOAgsiu60h5d2zmW5
         z5ZQ==
X-Received: by 10.224.69.66 with SMTP id y2mr2432155qai.61.1370797837985; Sun,
 09 Jun 2013 10:10:37 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Sun, 9 Jun 2013 10:10:37 -0700 (PDT)
In-Reply-To: <CALkWK0nA=27wqds-FZfPFtzdsAm1VKsZOF4hAOCLNi==FjrkKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227024>

On Sun, Jun 9, 2013 at 7:07 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Antoine Pelisse wrote:
>> I don't understand why the code doesn't belong to libgit.a, and how
>> it's gonna make it more "clean". I can see that it is needed only by
>> revert and cherry-pick, but is that the only reason ?
>
> Perhaps this will help? [1].  Join into the discussion.
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/226845

OK Thanks, missed that. I'm catching up the last two hours of discussions.
