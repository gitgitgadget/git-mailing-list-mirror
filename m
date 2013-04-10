From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 6/7] completion: get rid of __gitcomp_1
Date: Wed, 10 Apr 2013 14:23:37 -0400
Message-ID: <CAPig+cQyyokpKP8My=1j=eaa3cc50h1_rwqDmOdOkCGFesrW-A@mail.gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
	<1365577077-12648-7-git-send-email-felipe.contreras@gmail.com>
	<CAPig+cR4_ZB=s8JVT2LRJGcNhM9ZaESWZQ5v6Wa20=bWGoMydg@mail.gmail.com>
	<20130410113531.GJ2222@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Apr 10 20:23:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPzgO-0003dp-10
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936178Ab3DJSXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 14:23:40 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45117 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934446Ab3DJSXj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:23:39 -0400
Received: by mail-lb0-f179.google.com with SMTP id t1so845996lbd.10
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 11:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=gshsbso0p807THGeIDXGemm0W9O9c3pAsmQQ6B1osFA=;
        b=CmYlDYMTBmM9pWYa5S2SCLScXaTKMdExvS3TlpMkB414DC0gw7aqk2YAg6/n19QmlG
         /bgDd5ASLna1tmINykpMq8VlrI26Lp0Vjwsy6+Tcbyj/K6qs3O9HyNxbLVW1BJJGpiuv
         +W5sJtZHQBnw9smB19N57uE/oOK1G5YKhiXFFzyzV0GeeWzdw4QAfxctd6K6glINQPx2
         J98TOU5pyhdMZOZ6ACwhdLUyrZxdiJUE0U6mZr5AOKKLgIioavr9TgT6oyk+hlb6b0t3
         sp74PawKhzxL42NTUhYTAIkQvUKEaEV5Qcr2PKXI/ZtyBLs9V72B+0s+0Z6yzeXMI6ak
         54+Q==
X-Received: by 10.112.75.197 with SMTP id e5mr1785461lbw.6.1365618217657; Wed,
 10 Apr 2013 11:23:37 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Wed, 10 Apr 2013 11:23:37 -0700 (PDT)
In-Reply-To: <20130410113531.GJ2222@serenity.lan>
X-Google-Sender-Auth: cjua-dZUaXLKAnGeNrYTKvF_PIc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220714>

On Wed, Apr 10, 2013 at 7:35 AM, John Keeping <john@keeping.me.uk> wrote:
> On Wed, Apr 10, 2013 at 06:13:06AM -0400, Eric Sunshine wrote:
>> On Wed, Apr 10, 2013 at 2:57 AM, Felipe Contreras
>> <felipe.contreras@gmail.com> wrote:
>> > we traverse the words ourselves both in __gitcompadd, and __gitcomp_1.
>>
>> s/ourselves/ourself/
>
> Huh?  "we traverse ... ourselves" is correct since "ourselves" is
> associated with the "we".  I don't think "ourself" is ever correct in
> normal usage - the dictionary notes that it applies only to the "royal
> we".

Late-night lapse. Thanks for the correction.
