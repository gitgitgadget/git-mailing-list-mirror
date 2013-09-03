From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH v2 6/8] refs: add update_refs for multiple simultaneous
 updates
Date: Tue, 03 Sep 2013 07:59:49 -0400
Message-ID: <5225CF35.2040209@kitware.com>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com> <xmqqob8dul99.fsf@gitster.dls.corp.google.com> <5224C8C6.4050500@kitware.com> <522568D9.3080808@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 03 14:01:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGpIr-0001lI-3L
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 14:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781Ab3ICMBp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 08:01:45 -0400
Received: from na3sys009aog129.obsmtp.com ([74.125.149.142]:38449 "HELO
	na3sys009aog129.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932733Ab3ICMBo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 08:01:44 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]) (using TLSv1) by na3sys009aob129.postini.com ([74.125.148.12]) with SMTP
	ID DSNKUiXPp9mehHQOIGs/7cb6RvHcuOcN4OYU@postini.com; Tue, 03 Sep 2013 05:01:44 PDT
Received: by mail-ob0-f177.google.com with SMTP id f8so5653518obp.36
        for <git@vger.kernel.org>; Tue, 03 Sep 2013 05:01:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=BlWLQQtJstMG176MeKrZCQLYY+QSjsZJ7MCI4xbGikw=;
        b=PxgVRntX02PnhbilTbNLG5zLmWDq8fw8PfgWN5LA8I2TDqQrGy8CAy60ANnNlKjgfU
         7RmRgV6JAYEyYh3XwBTd977phhfH1UTIlxeszc/ywJgxnGa7YF3bkZkV5TDd0Vv9TeM0
         EA+ZLuok3TJrxcfKNjE8QkqB2j6jvSv5SuDQ7TnTTYWvY2Wd9AoGMNjuKcKOXlFQjr6M
         VvKCvA5ZwazZFTwl4+lGWuJrf5RQj/zZ/9tyBVmbTZSuLqCcd5Wjod9UhrKuwKh1++ob
         rfxIcqb1p6ncXwRTa9OnN10Nffwee9zM9KdwijewgZTrMUFIvRlYLK6rNgSuhTUjkaV7
         jrFg==
X-Gm-Message-State: ALoCoQm0oHeQC7asMLOjvgG+jpIvb2gwe85PXhmRdMZgo+OaoXOeuHpOZYc+lqM6+Q8yzkhg5ffZ76dPqSjn2pJ5fO5ogKjyKS+mDU0VY3PgwnfryT/fhNus/6PFo05tC2aQ6XcIiD2PaJcFCrx3JUwUCvqoW/SU1A==
X-Received: by 10.60.60.5 with SMTP id d5mr20734909oer.0.1378209700216;
        Tue, 03 Sep 2013 05:01:40 -0700 (PDT)
X-Received: by 10.60.60.5 with SMTP id d5mr20734901oer.0.1378209700129;
        Tue, 03 Sep 2013 05:01:40 -0700 (PDT)
Received: from [192.168.1.225] (tripoint.kitware.com. [66.194.253.20])
        by mx.google.com with ESMTPSA id z5sm17872849obg.13.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Sep 2013 05:01:39 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.12) Gecko/20130116 Icedove/10.0.12
In-Reply-To: <522568D9.3080808@alum.mit.edu>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233720>

On 09/03/2013 12:43 AM, Michael Haggerty wrote:
> Hmmm, I see that you changed the signature of update_refs() to take an
> array of pointers.  My suggestion was unclear, but I didn't mean that
> the function signature had to be changed.
[snip]
> However, your approach is also fine.

Okay.  Thanks for reviewing!

-Brad
