From: Junio C Hamano <gitster@pobox.com>
Subject: Re: sh -x -i -v with continuous integration, was Re: [PATCH 1/4] t7601: test for pull.ff=true overrides merge.ff=false
Date: Mon, 18 May 2015 13:58:16 -0700
Message-ID: <xmqqzj51a9hz.fsf@gitster.dls.corp.google.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
	<1431510740-9710-2-git-send-email-pyokagan@gmail.com>
	<2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
	<xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
	<81926313e0a131cd7224f0f6f8984dd2@www.dscho.org>
	<xmqqh9rf84we.fsf@gitster.dls.corp.google.com>
	<20150516152858.GA19269@peff.net>
	<xmqq1tigfij8.fsf@gitster.dls.corp.google.com>
	<20150518184528.GA11463@peff.net>
	<xmqq8uclbouc.fsf@gitster.dls.corp.google.com>
	<20150518205008.GB30217@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 18 22:58:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuS7E-0000S5-Gq
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 22:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932693AbbERU6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 16:58:19 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:33118 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932674AbbERU6S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 16:58:18 -0400
Received: by igbpi8 with SMTP id pi8so90668199igb.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 13:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ABQZyPixgg+l6Onj7q/pApq1fd3ynaL7pYQO7HhkeJY=;
        b=0/9a+02K/H3PCLZDzxVKwhstjnSjK02OedX08nkOTEpEDnfuouWdsRqoKpRT79C56t
         aKchLZuwKDSJtj40iqnICo6LEqmq007lMW7zJEdKOw9NWwsUWp+IZFm0n6IBlRqFzcFa
         hPMfCtdNpJNVvOoH21UlgcRNENeHS4DNi0S5uZzPBIg+84LljFfnSfuytTSFnaySgAme
         s0OV/Vgur1cHxlhOSscJPpPHkd+ZdzhOLJW4v2j3BvNxbnA+3oiz+rsz2SiPDoxa1Qhv
         NXcVaDzcyxjX6Q69wY2uhumAThBR0GhekI4ZEHI/5QBo0aGwsRUkPaA/SnPHFiS9OSfY
         Dn/w==
X-Received: by 10.50.30.69 with SMTP id q5mr17122661igh.11.1431982698252;
        Mon, 18 May 2015 13:58:18 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:799e:649b:b86b:7c03])
        by mx.google.com with ESMTPSA id p196sm8466640iop.15.2015.05.18.13.58.16
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 18 May 2015 13:58:16 -0700 (PDT)
In-Reply-To: <20150518205008.GB30217@peff.net> (Jeff King's message of "Mon,
	18 May 2015 16:50:08 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269318>

Jeff King <peff@peff.net> writes:

> What do you want to do with the "verbose" calls I have been sprinkling
> through the test suite (and the function itself)? Leave them or remove
> them? A grep for "verbose " (with the trailing space) shows some
> examples.

That was one of the things I wanted to do next, as I suspected that
the small number of existing ones might be mostly "obviously good"
ones (I never said any 'verbose test' is automatically bad; it is
just 'verbose test "$a" = "$b"' that hides what $a and $b were are
as useful as without 'verbose'), but I didn't offhand think of
examples of obviously good ones.
