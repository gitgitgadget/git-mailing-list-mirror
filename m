From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 33/47] remote-hg: add test for new bookmark special
Date: Tue, 14 May 2013 17:09:31 -0400
Message-ID: <CAPig+cS0eA8wZfUWz2MQooUzrdw8h4RWcaR4haeZHQJkL+nS9g@mail.gmail.com>
References: <1368506230-19614-1-git-send-email-felipe.contreras@gmail.com>
	<1368506230-19614-34-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 14 23:09:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcMTa-0003m1-9p
	for gcvg-git-2@plane.gmane.org; Tue, 14 May 2013 23:09:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758532Ab3ENVJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 17:09:34 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:41211 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758529Ab3ENVJd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 17:09:33 -0400
Received: by mail-la0-f54.google.com with SMTP id fd20so1024232lab.41
        for <git@vger.kernel.org>; Tue, 14 May 2013 14:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=1qyRAX+ELazHMKlVRRAzdfz8vnaCamkkd33s3gvZKlo=;
        b=lpfWI4tg+TBQhdkpzHPY8oIZ/Wouod7LSac3jn6rA+PrfDBcdUcBjTdcHEGkLXtHWe
         vleTW+sJ+tFb4Vd0WXyunr+fb/67kv5sykRMactTeXAmg/j4rO1snM+Vuufb9xXIEQvs
         6+TMThlsQEtJ6wR4BcroGRqsN9mM9IGbMoeGKd9HmRrpEolrGpokcVzWqPj+JW1Yuj6r
         uZCM6oAnLSdKDdrNvfa6HC0GMFnoHXzs1EXmqp8nyOGgww7QlEcMXBmdpjPzptQk7qib
         r2oJwb1O6J/XNNlezgUQPtP4AhDgOQhDGY0BcFpjTlpw4IeduY45PVISzxElhYXPXvSK
         HfsQ==
X-Received: by 10.112.157.231 with SMTP id wp7mr8859430lbb.91.1368565771814;
 Tue, 14 May 2013 14:09:31 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Tue, 14 May 2013 14:09:31 -0700 (PDT)
In-Reply-To: <1368506230-19614-34-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: FPAaKEPWk6JWx4_Y_u8j1UZV-Co
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224346>

On Tue, May 14, 2013 at 12:36 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> From the point of view of Mercurial, this creates a new branch head, and
> requires a forced push.
>
> Ideally, whoever, we would want it to work just like in git; new

Did you mean s/whoever/however/ ?

> branches can be pushed without problems.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
