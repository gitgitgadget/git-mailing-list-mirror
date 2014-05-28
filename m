From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Bug in shallow clone?
Date: Wed, 28 May 2014 16:29:24 +0200
Message-ID: <1401287364.3329.0.camel@seahawk>
References: <5385EC5B.8050400@web.de>
	 <CACsJy8AmxNDcxtT0XiR8-j=sO0Eo8t5E2apf5SuYU6+EogNm7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Thomas Kieffer <ThomasKieffer@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 16:29:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WperH-00005J-BD
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 16:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbaE1O3b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 10:29:31 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:52434 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932191AbaE1O3a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 10:29:30 -0400
Received: by mail-wi0-f178.google.com with SMTP id cc10so3836491wib.11
        for <git@vger.kernel.org>; Wed, 28 May 2014 07:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=NCnrJjccLTU3QRE56JWWdIndN3VibDCR8yRGOSTYwg4=;
        b=F3KuUHaHZjwQ3+lrK/++P3u/Db1Dp+oGufWcSVB67R5LSpOVfNK8KRq1zM4rDRKLmq
         NHylcXQ7Tk7+XNg+XALEA0exMcRI2r4qZsnPjJylCcpRkpV3JDoDGw/ESq9GPuXbqJzt
         9ZwwcgD5CTPgDk4t61jK14pIkPK7V/n586Ut5pReuUPrUo4BC85FfsOV669Jr1rJul1V
         p5NQ6hNNZ1KeBf+tqz1Y5xdEhj/62r7ZoazAatFOI8JOBB6iQmrXl9FO4t2PEMPzMEXK
         l0lJwqzk0uOvjzXz+514LqXHUfelRZoaZ0qooYM99MSmsVJKefxjXsRD3XIXzz47jSDP
         13eg==
X-Gm-Message-State: ALoCoQm0RoRUJUq8bsb5hRq5bMGoecoxTSRVFjhOoaYPyX0/CfD+H//JChu+59xp8kpB4hPLCS/e
X-Received: by 10.180.100.129 with SMTP id ey1mr48775308wib.60.1401287367614;
        Wed, 28 May 2014 07:29:27 -0700 (PDT)
Received: from [10.155.73.156] (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id f2sm3071357wiz.11.2014.05.28.07.29.25
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 07:29:26 -0700 (PDT)
In-Reply-To: <CACsJy8AmxNDcxtT0XiR8-j=sO0Eo8t5E2apf5SuYU6+EogNm7w@mail.gmail.com>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250284>

On wo, 2014-05-28 at 21:16 +0700, Duy Nguyen wrote:
> On Wed, May 28, 2014 at 9:02 PM, Thomas Kieffer <ThomasKieffer@web.de> wrote:
> > I then clone the bare repository with --depth 1.
> >
> > git clone file:///path/to/bare.git ./clone --depth 1
> >
> > It always returns the last two commits. If I specify --depth 2 it returns
> > the last 3 commits.
> >
> > If I use --depth 1 on a Github repository it works as expected.
> >
> > Am I doing something wrong or is it really a bug?
> 
> Depth calculation has been corrected lately. It depends on your
> version, maybe it's older than 1.8.2? If it's the latest, we screwed
> something up again..

2.0.0-rc4 does this correctly.
-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
