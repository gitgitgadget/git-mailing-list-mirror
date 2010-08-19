From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] t/t9010-svn-fe.sh: add an +x bit to this test
Date: Thu, 19 Aug 2010 20:30:20 +0000
Message-ID: <AANLkTimkMqpXRY2OF8ri096oep8YC_fLnMLdQPm6rxQ1@mail.gmail.com>
References: <1282233230-17323-1-git-send-email-avarab@gmail.com>
	<7vpqxe74aq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 22:32:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmBmN-0005XX-IN
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 22:32:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752697Ab0HSUaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Aug 2010 16:30:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63339 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752585Ab0HSUaW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Aug 2010 16:30:22 -0400
Received: by fxm13 with SMTP id 13so1384580fxm.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 13:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Ms/rNp1EhsEWeTes74pXUGhMjJA7MHlTHpr+c08UO+U=;
        b=mbjgeG4jiY63tINOR8Cc63ovymYtYUP+7Zvpewe49wafizytnl4tjebv7B/Nt5amJi
         gXcQVVShHaJnV6cbpxIlO5EQ5hfNirz8c+cdIGwyMRqLYXHAmuk7vCIy6p6Bfv7rDELd
         olQldNO2k6pD17ZAHytfq0pP121TDfeKGveh0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GYX9S4Ohxhmwk7HN3g6KLV+FUFqq1YhK6DPo88eRfehoU1/QDeLgPo/v9+bGPdMY5r
         m4RW+UFeDprXWoscSi2Y8rQe0B/4BiNmpTUaGDAm9NvGLvTU7gpoEoSwIcK0cyeGh8qm
         q/I2EGBZFoiPXJqtOvNKUrvGxMQHvTpYgjzQA=
Received: by 10.223.121.19 with SMTP id f19mr294134far.73.1282249820510; Thu,
 19 Aug 2010 13:30:20 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 19 Aug 2010 13:30:20 -0700 (PDT)
In-Reply-To: <7vpqxe74aq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153956>

On Thu, Aug 19, 2010 at 20:09, Junio C Hamano <gitster@pobox.com> wrote:
> Heh, why does a topic need to be merged to 'next' before this kind of
> trivial bug in it gets discovered X-<.

Actually I only test pu these days, but I didn't test it on Solaris
recently where this was triggered for some reason.
