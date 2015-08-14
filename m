From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] 2.5.0 build with NO_PERL is broken
Date: Fri, 14 Aug 2015 14:02:31 -0700
Message-ID: <xmqqoai9h9co.fsf@gitster.dls.corp.google.com>
References: <loom.20150814T171757-901@post.gmane.org>
	<loom.20150814T184447-932@post.gmane.org>
	<xmqq7foxiqu6.fsf@gitster.dls.corp.google.com>
	<CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Renato Botelho <garga@freebsd.org>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 23:02:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQM7Y-0002gY-Us
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 23:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751988AbbHNVCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2015 17:02:33 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33392 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751722AbbHNVCc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 17:02:32 -0400
Received: by pabyb7 with SMTP id yb7so66684996pab.0
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 14:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=PbR/CZhGEVR78fbIOfU7rH7gqXAOjiX97SN4jKb+pp0=;
        b=f0GtCEVGADNKyB7x2ZgVcjqhp3CNWMq3jjL4V6prZrhKIGhWnkSVZloFB7YywGEDmp
         vRmQBPYjwA259K6+s3AjRwjxN2kfFzPNDUolCLkYBZHXhlMJeSurH97CusfXddu7dhUp
         mWnIxs5s0Ujr4wsv3z5KR5Oov9Aq+ekkC2Xa4oqjrgXDwFEcxyYLcJnk12Mw+JnvVi/f
         eiJ5JsuwZbs+7namQKGQqaXWxw70+Zo6S9Q+wtP0FKevHo7yTl5eYG7bYRMj4XKy7kOP
         hvSvc/UxTyjOYlebJkEYUpHSCLJHxSOPqttQOIW90wYrOxjkZV7hgzXF6oe7OIvVXNhc
         DSBA==
X-Received: by 10.68.105.163 with SMTP id gn3mr69930077pbb.86.1439586152177;
        Fri, 14 Aug 2015 14:02:32 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id q1sm7058146pap.20.2015.08.14.14.02.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 14:02:31 -0700 (PDT)
In-Reply-To: <CAPig+cR77oFo6D3f8BjAB_yM-xPt+3EUGK4vZr3eYWJGTtksAQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 14 Aug 2015 16:49:38 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275952>

Eric Sunshine <sunshine@sunshineco.com> writes:

> Nevertheless, there's still the problem, due to 527ec39
> (generate-cmdlist: parse common group commands, 2015-05-21), that git
> doesn't build at all anymore when Perl is unavailable.

I do not think that is anything new.  We always have assumed "some"
version of Perl available in order to run t/ scripts.
