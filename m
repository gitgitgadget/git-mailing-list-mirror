From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 02:54:00 +0530
Message-ID: <CALkWK0=nGP2J_EQM83Pv--5orAMdAPmk-3t5uF2pkJYScpM2KQ@mail.gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CALkWK0mM9HBUvHGHPEw4Vdosp_qfu_1L49TaZrzdC5n3soWkYg@mail.gmail.com>
 <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <CALkWK0kA86YgonuXv=h2hA_hV8RfWPsBjtrk6OnHXiP=qDBjwg@mail.gmail.com> <CAP8UFD3i2vc3OSAHRERpiPY7cRjqhkqcBN9hVW0QmMksnCPccw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:47:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pn-0000sy-1u
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934370Ab3DGVYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 17:24:41 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49419 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762040Ab3DGVYk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 17:24:40 -0400
Received: by mail-ie0-f173.google.com with SMTP id 9so6166269iec.4
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 14:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=Fu7wSx+DVyqR+8rUnGxYw0lGlwmq6BVAhVi6GYmF1Qk=;
        b=ErSfsk/JwqBHyWbR7Ia/dE5y3ScpCWsExzbJyqX5BgdxsZrhPFpBGKVm4CMqAe1WPl
         u0c/1HySXRKXfp/Bckn8XK4irhrQwTb0OaUANFCxdM1YOTFEyKxfAnlUCYYzLvAVxWPP
         6WFAZKpz1/FIDNPumVUeVT7LzEJoFlkNbHbQgtKc3ndPXwNLfaEbjOLsQUMEzF6UfMxZ
         Z6hmp0tLOq59eD0CZ5m7IeTA77xQZtNyUXCSzVINFlerOMSA5veEi3rnWRcTGUIU7IAP
         85pCeQcQ6YC7kq75zjTTV2KmmKWFSZHalUE9LskentTUTmgspmceOV/1jtJjOH31NDSX
         IQgg==
X-Received: by 10.50.117.3 with SMTP id ka3mr4674919igb.107.1365369880323;
 Sun, 07 Apr 2013 14:24:40 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 14:24:00 -0700 (PDT)
In-Reply-To: <CAP8UFD3i2vc3OSAHRERpiPY7cRjqhkqcBN9hVW0QmMksnCPccw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220379>

Christian Couder wrote:
> About generation numbers, please have a look at the thread leading to this
> message:
>
> http://thread.gmane.org/gmane.comp.version-control.git/177146/focus=177586
>
> In short, generation numbers were not such a good idea because there were
> already existing ways to get around the problem and because there was no
> simple way to implement them without breaking other things.

Thanks for the interesting read, Christian.  I didn't follow the
discussion closely, and only have a passing understanding/ interest in
the issue.

> My opinion is that your proposal can only be accepted if it is also a
> solution, or a big step toward a solution, to other difficult problems, like
> for example narrow/subtree clones.

Hm, a link object referring to a tree object, as opposed to a
revision.  I'll think about this for some time.

> So you should try to improve it by looking for other important features it
> could provide in a simple way.
> This would prove, or at least be a good sign, that it is a fundamental
> improvement to add a link object the way you describe it.

I'll look for more submodule-like features to strengthen my case.
