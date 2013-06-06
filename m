From: Moritz Bunkus <moritz@bunkus.org>
Subject: Re: Ignoring pattern in un-ignored directory not working anymore
Date: Thu, 6 Jun 2013 23:08:20 +0200
Message-ID: <CANPayMQXw9noi-SJa0hZSsUzPd_fN6eVEXwW=uJdwqPPZmVCxw@mail.gmail.com>
References: <CANPayMS19-bjgWRMYrRcGYzKgEo_0Az_8emeDrKwxx9RguDbwg@mail.gmail.com>
	<7vfvwvyudh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 06 23:08:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkhQA-0003pa-I3
	for gcvg-git-2@plane.gmane.org; Thu, 06 Jun 2013 23:08:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab3FFVIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jun 2013 17:08:30 -0400
Received: from belgarath.bunkus.org ([78.46.80.115]:41035 "EHLO
	liselle.bunkus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753111Ab3FFVI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jun 2013 17:08:29 -0400
Received: from mail-pb0-x233.google.com (mail-pb0-x233.google.com [IPv6:2607:f8b0:400e:c01::233])
	by liselle.bunkus.org (Postfix) with ESMTPSA id 8D3E61BC0DB0
	for <git@vger.kernel.org>; Thu,  6 Jun 2013 23:08:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=bunkus.org;
	s=mail2013040101; t=1370552908;
	bh=sAdMdI1XMypNvJyJUYaWRC3Qec15DtGCM+5xfDlo4jo=;
	h=In-Reply-To:References:Date:Subject:From:To;
	b=M76Ba7p4KPbN45F6xs5S7vdUAjK8VKqHYjwzLPqUoeg8DhgKg4JRfnFXzeJEpqcCJ
	 iZ8yKqluMsJ+7FXuYyJwXfa9OoE/QAY1feUS5cHWp/qHXuaV4FJ8IhVCZYDeLwwk7w
	 No7CORQU1TfL0Zc59izkTqil+Hc0XjeDFDYHSkjI=
Received: by mail-pb0-f51.google.com with SMTP id um15so3757156pbc.24
        for <git@vger.kernel.org>; Thu, 06 Jun 2013 14:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=sAdMdI1XMypNvJyJUYaWRC3Qec15DtGCM+5xfDlo4jo=;
        b=WfKTrVkoX+z0mcuemJZMWRtDmgGhi7ApT1r7N0DUnNNeSE46vvRuZ6XwIf517HkU8L
         M/ZwuAsq+xs4wlnqwTeT4dsMBulOimHmhpZjc9II2b02d4EpYtSAvspvnxDoEorsIQEk
         jkQyg7H7pcSFofF4yoTK/Ov7J8/+hVGELD5FI7+x5tnzKTjogxaBl/WErHbDSKUSGhq1
         +VwOqdUM+gs58XnHO4g88HztNIvBQGcX8l71EvVVUybHFGvE6JNZbP3idhIa2jFudh6u
         nLc9QhDvKkvCEAL3pjBlJwatlyNrAnVeugDnIMmM3zKJ86EcxfTqrGORyUux2MRFJuyz
         PRPQ==
X-Received: by 10.66.100.231 with SMTP id fb7mr40007132pab.162.1370552900651;
 Thu, 06 Jun 2013 14:08:20 -0700 (PDT)
Received: by 10.70.1.5 with HTTP; Thu, 6 Jun 2013 14:08:20 -0700 (PDT)
In-Reply-To: <7vfvwvyudh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226559>

Hey,

yes, the problem is gone at 3684101a654d. Thanks.

Kind regards,
mosu
