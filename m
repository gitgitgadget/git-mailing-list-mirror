From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Tue, 11 Jun 2013 12:26:42 -0500
Message-ID: <CAMP44s3OG2MSO=zwAvzTnTLYOJmhsmbjrVJOxP-0ZSaxgMuUXA@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
	<20130609191518.GB12122@paksenarrion.iveqy.com>
	<7vhah4d3sk.fsf@alter.siamese.dyndns.org>
	<20130611170815.GA20009@paksenarrion.iveqy.com>
	<CAMP44s0VksnZmi21u6T79AvMebWA3gXmWbQ6pp=FAHL=D4q6+Q@mail.gmail.com>
	<20130611172416.GB20009@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Jun 11 19:26:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmSLO-0000uB-Qe
	for gcvg-git-2@plane.gmane.org; Tue, 11 Jun 2013 19:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754961Ab3FKR0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jun 2013 13:26:45 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36196 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab3FKR0n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jun 2013 13:26:43 -0400
Received: by mail-lb0-f178.google.com with SMTP id y6so6246307lbh.9
        for <git@vger.kernel.org>; Tue, 11 Jun 2013 10:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=iR0OXxBRks/vPpi47KKvskNytPz3MswqAIOuiIlRYiI=;
        b=tJg2uAPc4hQ5VhepT6MO7HBh7DZNpLHmlOqor/qXqGMWbFsTqviN9yqDUXwU1QdcM4
         N7oj+lEp5Va4CwrhWssLd2qlGZ39+VU1/YHzv6HKmWi0C2lzmBWqE0NXIzrdyLQ/pbfI
         abEe44cl2gMOUr6vl3SBoBjQvqsfN+I8RFviGktxhZZQcs5qc3WDeg4zpilLjS8NI0ec
         vcuBf3USoVqBucGOoxJmhmO3MnaAuER3qKBiG7XXdgBaIw5vQan/g9nascod8fWdJITv
         9nbmlJxKTD7nI4gaIcyDiQBiJku3hi4GSgrDYs+PkkfdLJYoAd1YHIRSYqL8d3pK7CK8
         6TWw==
X-Received: by 10.152.28.162 with SMTP id c2mr3399802lah.45.1370971602148;
 Tue, 11 Jun 2013 10:26:42 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Tue, 11 Jun 2013 10:26:42 -0700 (PDT)
In-Reply-To: <20130611172416.GB20009@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227472>

On Tue, Jun 11, 2013 at 12:24 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> On Tue, Jun 11, 2013 at 12:09:32PM -0500, Felipe Contreras wrote:
>> It's not removed. It's simply moved.
>
> Sorry about that, I wasn't paying enough attention. But why are you
> moving it?
>
> All other arguments to git am is set in git-rebase.sh, why just set
> -q just before the invokation in git-rebase--am.sh?

Because the next patch checks if there's any arguments meant for 'git
am' to switch to am rebase mode. We shouldn't switch to that mode if
the only argument to 'git am' is going to be -q.

-- 
Felipe Contreras
