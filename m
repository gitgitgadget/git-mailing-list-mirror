From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 24 Sep 2013 01:59:21 -0500
Message-ID: <CAMP44s0RPgVOo4qN-Nb2Mqkemk53gi_pu7Ft25e3gtFciNOEgw@mail.gmail.com>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
	<20130924045325.GD2766@sigill.intra.peff.net>
	<CAMP44s1tirA5w91L2YomaduZVkqL3=n1j79eoueB6XeGuyY3Mw@mail.gmail.com>
	<20130924053712.GA6114@sigill.intra.peff.net>
	<CAMP44s1-AXKRz4pqQsyCMLZgnxmxTaoeBGt8aNDFM0ttDTmBRQ@mail.gmail.com>
	<20130924061830.GB6114@sigill.intra.peff.net>
	<CAMP44s3ee_SmY=NOeMW31D4E01-Ft9qY5wa9VhRQWrY0fo7S=A@mail.gmail.com>
	<20130924064604.GA7257@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 24 08:59:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VOMak-0000yH-T4
	for gcvg-git-2@plane.gmane.org; Tue, 24 Sep 2013 08:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763Ab3IXG7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Sep 2013 02:59:23 -0400
Received: from mail-la0-f52.google.com ([209.85.215.52]:32908 "EHLO
	mail-la0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716Ab3IXG7W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Sep 2013 02:59:22 -0400
Received: by mail-la0-f52.google.com with SMTP id ev20so3257603lab.39
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 23:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uyylvce02V8Y1HuYxkVUmx/Wy+RZd013GqNoXp4xuEI=;
        b=GKFhzlD4nXcnDnrQaYD+3RU2VVoLhcTS+NZV2iyaSKttEpw+dpgOt9Hdy7AnuhASFT
         4k6v9XhQqZn4tf7g37SPA9VgTI5tQdmjgyPq7Brrkmbxn4VeggIN1ZefA9X6FXH7ktuz
         MbLPuH04hoWbp7rxLhru+PRu6JeElGikzIvJPk3ovnQE/Ghho4wD4dtgIsgRUPX53sjV
         W2m056Ry9IOCCXhCXNgZJ/FQgtFjmQSTekFLU8RQt95/tUKmHmLar1/8IR0hCLdcCSA0
         Wp6G/vTfCIR38DU5AE0WLxX9KX8GzLcCIUNM6knBL7XUZm8OVSns3819DWw3SKiQa0wH
         yKFw==
X-Received: by 10.152.116.7 with SMTP id js7mr23773190lab.11.1380005961525;
 Mon, 23 Sep 2013 23:59:21 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Mon, 23 Sep 2013 23:59:21 -0700 (PDT)
In-Reply-To: <20130924064604.GA7257@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235279>

On Tue, Sep 24, 2013 at 1:46 AM, Jeff King <peff@peff.net> wrote:
> On Tue, Sep 24, 2013 at 01:41:19AM -0500, Felipe Contreras wrote:
>
>> > People who have different aliases for
>> > the same terms are unaffected on existing boxes, but slightly hindered
>> > on new boxes as the aliases do something else.
>>
>> Less hindered than in the current situation.
>
> I do not agree, but I've already explained my reasoning.  I think we
> must agree to disagree on this.
>
>> cvs ci = cvs commit
>> cvs co = cvs checkout
>>
>> svn ci = svn commit
>> svn co = svn checkout
>>
>> hg ci = hg commit
>> hg co = hg checkout
>>
>> And somehow you think this is not natural and sensible?
>>
>> git ci = git commit
>> git co = git checkout
>>
>> I think it's as clear as day.
>
> If it is natural, sensible, and as clear as day, then why do people
> alias the commands to something besides what you show?

For the same reason people would do alias.commit='commit -a' if it was possible.

[1] http://article.gmane.org/gmane.comp.version-control.git/147517

-- 
Felipe Contreras
