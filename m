From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH v9 0/1] http: Add Accept-Language header if possible
Date: Sat, 31 Jan 2015 02:23:32 +0900
Message-ID: <CAFT+Tg_-Ka7qcPfXJd7QC+VwEY6Mgmq5TNvzv3GoLimrqfPnHQ@mail.gmail.com>
References: <CAPc5daXEFZ+3Qr8fg0g9Mi6V+3r5yNmAFpAwVXciaMTwK244kg@mail.gmail.com>
	<1422446677-8415-1-git-send-email-eungjun.yi@navercorp.com>
	<xmqq7fw6f6s6.fsf@gitster.dls.corp.google.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>,
	Michael Blume <blume.mike@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 18:23:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHFIA-0003wJ-0x
	for gcvg-git-2@plane.gmane.org; Fri, 30 Jan 2015 18:23:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762646AbbA3RXe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2015 12:23:34 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:39214 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825AbbA3RXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2015 12:23:33 -0500
Received: by mail-qa0-f53.google.com with SMTP id n4so20880695qaq.12
        for <git@vger.kernel.org>; Fri, 30 Jan 2015 09:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=0115mDEsEIfxT/44lC3c3+OR/8tZcerQnihpx2YZX8w=;
        b=Ll5YSfHvFwUrutMV4awHIzBAs8MiuKuzNm9n5MWB/J87kbU6hQSrVEcqc+tHjYD1Y0
         ehVSmfwh/OIINX2lh9kswGfLKK+6RioAYZNJQ8hX8QxPLeSvWv1obgvAlmmax3J82Xd5
         3iG1Mn60sYCOVUJiJWGdVAkXvicKauXbglY92rR1bQec4WuuufJUm5PxpIsuyyD1mxr2
         11uh9MKmChK8Fi9iaZymSMMo93nLZ7QR1QS1A/YaG1wif7ct2xtnwBucfx0Tojr+wpqi
         TCfMRF/Ak63p9dtpJ6iAROMokp/bwjkSO6bu4BZHiXSC+AHxdyNK/OThi1+5cpyaDgdT
         jL9A==
X-Received: by 10.140.85.211 with SMTP id n77mr13509176qgd.17.1422638612899;
 Fri, 30 Jan 2015 09:23:32 -0800 (PST)
Received: by 10.140.95.19 with HTTP; Fri, 30 Jan 2015 09:23:32 -0800 (PST)
In-Reply-To: <xmqq7fw6f6s6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263184>

I'm very glad to hear that. Thanks to all reviewers!

On Thu, Jan 29, 2015 at 3:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks; queued.  Let's run with this and try to make it graduate
> early next cycle.
