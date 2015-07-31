From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add ls-remote --get-push-url option
Date: Fri, 31 Jul 2015 12:02:14 -0700
Message-ID: <xmqq4mkk5ex5.fsf@gitster.dls.corp.google.com>
References: <1438364321-14646-1-git-send-email-mathstuf@gmail.com>
	<xmqqfv445fxv.fsf@gitster.dls.corp.google.com>
	<20150731185619.GA24622@megas.kitware.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ben Boeckel <mathstuf@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 31 21:02:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLFZc-0002OH-HS
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jul 2015 21:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752024AbbGaTCR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 15:02:17 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34420 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbbGaTCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 15:02:16 -0400
Received: by pacan13 with SMTP id an13so45909734pac.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 12:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=FXfxPh7sQfIz7Rf6YBKz82yHTcxHfmXSk95wmy/mlSI=;
        b=oxn5zawwCJ6iw08YUE3TfWvnqLz8/E5jy+xSBw/JxfA95WYevCvtpExkRIRSeASxJq
         28cpijE7Dlkib6JViTjDi3uWDdGDGDwDOtv+o4qC6QZj428y63USlc0BHRLsfXbOksAr
         mMPqmcdhvjM2Nt7/+OzuEwYB5RCp2FJ/RdwrvYKbJA3ZZu9KgdnXa93NX3SnI+98T/2Z
         vn8imqNImZ5tAwcHT86RJ4/Np8SeRsShi1wzEIT4S+4PnEt1SXSaiFWvv+WGFBSBdK3r
         YRET8uDbYsTfcYMlT6gcIWFQi8/u32n/q5sEdkKCUt7e2MMgeHnVMU9Q24pka6pQdiGJ
         g1pg==
X-Received: by 10.66.221.226 with SMTP id qh2mr10249246pac.64.1438369335761;
        Fri, 31 Jul 2015 12:02:15 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1b0:46e8:ba02:35e3])
        by smtp.gmail.com with ESMTPSA id jg7sm9108552pac.1.2015.07.31.12.02.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 31 Jul 2015 12:02:15 -0700 (PDT)
In-Reply-To: <20150731185619.GA24622@megas.kitware.com> (Ben Boeckel's message
	of "Fri, 31 Jul 2015 14:56:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275066>

Ben Boeckel <mathstuf@gmail.com> writes:

> With some sed, yes, but then so would `git remote show` just as useful
> too (and in that case, "why does --get-url exist either?" comes to
> mind).

Either carelessness let it slip in, or it came before 'git remote show'.
