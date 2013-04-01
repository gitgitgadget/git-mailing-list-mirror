From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/3] remote-helpers: fix the run of all tests
Date: Mon, 1 Apr 2013 23:46:00 +0200
Message-ID: <CALWbr2wAqudzbfiSHmD1uAVQX3mtbf5vgr2JXbXEg7yzaKXJcw@mail.gmail.com>
References: <1364850872-21135-1-git-send-email-felipe.contreras@gmail.com>
	<1364850872-21135-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 01 23:47:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmZE-00037i-2q
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758707Ab3DAVqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:46:04 -0400
Received: from mail-qa0-f41.google.com ([209.85.216.41]:62956 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758663Ab3DAVqB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:46:01 -0400
Received: by mail-qa0-f41.google.com with SMTP id bs12so1111938qab.14
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6uRRKYk172lNEKG/JBcwcgWa52PJyubRWFRAPpxPS64=;
        b=GW748glcg/QFGulCBERUlxRKlUrOOaH0bzv8OGz2VZ00qJLomEHs+7IlbfXPNqhdK3
         TQHpo0325ZvVgTspDXZuDnWvW77walqbHItocwst8eb0PzZE3dJt7W3uWg5VuvSwIDlt
         k8EIeIxG/Re7Ro7oxgQHFXzjAJQwd1Kq44aDPfl+rLTEeMcPpooNj/jyz7bA/AoPuoGi
         KDcs415dl/do/fMdGW6VYV3vpyCCnEeugg+kJ+D70GmFjeyqKIOIBt4agzPTwoor5Spc
         7M9Vba1hynv82WYLExK3kLVgkc3n5aFrM19B8MCddfwGQSDa/Srdxo32YSj+eYxDEpUa
         CSWw==
X-Received: by 10.229.180.2 with SMTP id bs2mr5346961qcb.52.1364852760637;
 Mon, 01 Apr 2013 14:46:00 -0700 (PDT)
Received: by 10.49.70.163 with HTTP; Mon, 1 Apr 2013 14:46:00 -0700 (PDT)
In-Reply-To: <1364850872-21135-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219712>

Hey Felipe,

On Mon, Apr 1, 2013 at 11:14 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> +export TEST_LINT :=

I think "test-lint-executable" still makes sense here.
