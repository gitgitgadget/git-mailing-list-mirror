From: Dickson Wong <dicksonwong@gmail.com>
Subject: Re: [PATCH] mergetool: reorder vim/gvim buffers in three-way diffs
Date: Thu, 11 Feb 2016 12:10:33 -0800
Message-ID: <CAB8-sypQmomwbq6Fv5OKUbdtBBK5mnuwWg2eAbun9L_K0QcUmA@mail.gmail.com>
References: <1454033894-49954-1-git-send-email-dicksonwong@gmail.com>
	<xmqq1t90jkcr.fsf@gitster.mtv.corp.google.com>
	<xmqqr3gl1pyw.fsf@gitster.mtv.corp.google.com>
	<56BB4BDF.3010407@drmicha.warpmail.net>
	<xmqqlh6szcfk.fsf@gitster.mtv.corp.google.com>
	<56BCAC69.8030909@drmicha.warpmail.net>
	<xmqqbn7nxmhe.fsf@gitster.mtv.corp.google.com>
	<CAB8-syo8dCjDfCH3gAFvC1cnuB-wm9hxtmVb1OhZ7NT0Pw+EbQ@mail.gmail.com>
	<xmqqtwlfvyau.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 11 21:10:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTxZW-00068s-GG
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 21:10:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbcBKUKe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 15:10:34 -0500
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35455 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002AbcBKUKd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 15:10:33 -0500
Received: by mail-ob0-f169.google.com with SMTP id xk3so90648498obc.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 12:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=NToePWcMhK8RWTYpudkxLNVOlb8v4xIsr9Bn3mkkKE8=;
        b=cqFRPwET4qmfoB3GkgGKjCEDRaaxJIrwWS4nXLYhax1aM+dveZgVlgUM3QBSRHTnTl
         3Z6jo/y3blxYb5JK6g1fZ+iQKk9ASGd2aPaaU+1uPZo9dJL0/H3RRR6nHbUK0wNp3j/n
         uTQAmvrHuJBWtcXQ3SjXmlE1lJ1AHTgONtKquyOJwpsi4MoDUGfMV4QeippNLwuxiK/R
         Rhf/7iOrAauYuQ9LeeZyQx+z8iie3aQTp+vf/dkzAwbeHTWi/v/arL/EbcQ1cQuRQ62L
         e+9aclVMct6zEeEtAdJeGd6LJFX5BP8KKBWPFqsbU/dwzZ1oc6iWwGV3lQF4U1p0hZJO
         m0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=NToePWcMhK8RWTYpudkxLNVOlb8v4xIsr9Bn3mkkKE8=;
        b=QD/IZEmVXiij1ZbZ5MkqZk+/mxB995IwznNmHJm39hPH8t4vExjnoeS1WDejvGrbah
         2zr57KUVjJ8k7BHNwHudt1rERwR4WK2X3PneWrt0oKGtAsSonjj6mREZYTcaEetWUqwj
         olrPaKZBbTm2etvY/nZoaAJViqVt6H4laZyTQP6Tb26bgJ0fz0CdvlXpXbt4p5gmLKum
         yKPRJwDaYd/JXzss5V2U4BUCQ/UCe5i+ibUT0roV1QNhPiXy6+1NX7C5FimEV6EQ9uso
         kBF04kweX54Wj9tZwToa3D9JjTMcj85YpAWi4JID6yznIsjpjDPnHQR14vG7oYA6CXZb
         f2Lw==
X-Gm-Message-State: AG10YOSfRpAqsDvwPCgEEs3ZtnWXvWqS5brav8Kq/461xwOW0ZA6tHFP+FljPKtD3SC2zRHYi974x7VcFyMsZg==
X-Received: by 10.182.92.234 with SMTP id cp10mr47470537obb.79.1455221433356;
 Thu, 11 Feb 2016 12:10:33 -0800 (PST)
Received: by 10.157.34.134 with HTTP; Thu, 11 Feb 2016 12:10:33 -0800 (PST)
In-Reply-To: <xmqqtwlfvyau.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285994>

On 11 February 2016 at 11:31, Junio C Hamano <gitster@pobox.com> wrote:
> So it should suffice to mention it in the release notes as one
> bullet item that describes one positive change, among all other
> updates described in a simlar way.  And there is no special
> "warnings for existing users" necessary, I would say.

It's unlikely anyone would move the merged window to the top as a
preference only without being aware of the original inconsistency.
If someone has been using a workaround, it would be fairly obvious
as to what has changed, and definitely more so than when they first
encountered the original behavior. Any adjustments to the new behavior
would probably be a workflow change rather than a system configuration
or scripting change.
