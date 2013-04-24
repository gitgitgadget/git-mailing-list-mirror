From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/5] git-diff.txt: fix ordering of the [--no-index] form
Date: Thu, 25 Apr 2013 01:07:11 +0530
Message-ID: <CALkWK0=KWu3=j5sLK3hr=Gx5xLnLaPAY+E=J0_izRCj9YcBTEg@mail.gmail.com>
References: <1366821216-20868-1-git-send-email-artagnon@gmail.com>
 <1366821216-20868-6-git-send-email-artagnon@gmail.com> <7vmwsndbve.fsf@alter.siamese.dyndns.org>
 <CALkWK0kaFc8cj-=1NbEwC_61U7qUCye70d9MZR66TpKB3i9XyA@mail.gmail.com>
 <20130424190638.GE29963@google.com> <CALkWK0n2zFp1t7qtKp8-Ohoz0QEn4BQrfvxzqt+qwLS5+sNdHQ@mail.gmail.com>
 <20130424191453.GG29963@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 21:38:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV5Vs-0004ov-Oa
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 21:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757399Ab3DXThw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 15:37:52 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34818 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757359Ab3DXThw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 15:37:52 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so2621912iec.22
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 12:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=2MWgAGeFxIwwEm2jK+SZauQtuK0WtVb64s+CtiIYI+c=;
        b=mOIVaUjofi4MWKpBBiR0tXQaUs7oH2TbIEDUsbZaajBRYqG8dca4TwCy277wLEbN18
         YUTIxcSHJgA3Yy4MrQq3K0GBmkmJPZnFd6utjwtrAt+bcHfWx6GsoPWbwbrGciy3wW0y
         vwNX6/tU5recQX6Slrf6ipy6P1xsaCy//rHwsDXjMqp0uYmovLTlWV/CVHhjz7ZP10Av
         FX0W8dc+b8FScmB8nCXdY066E6Fd6R2WKls+HIa/xP6RZCIRhMxAPAIGXbC7AqTdvYs1
         h3zVhSqS5cM2nlTEE8aHe8wM9+dZEq9M7w0oS+9lYfl9wc/DknfBOZ/B9a59ABncLKs/
         ojNA==
X-Received: by 10.50.57.200 with SMTP id k8mr29066495igq.44.1366832271685;
 Wed, 24 Apr 2013 12:37:51 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 12:37:11 -0700 (PDT)
In-Reply-To: <20130424191453.GG29963@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222309>

Jonathan Nieder wrote:
> Because typing paths does not make my intent perfectly clear.

I'm not able to understand this.  Doesn't your prompt tell you which
directory you're in, and if you're in a git repository?  When you type
out paths, you know what is inside and what is outside your
repository.  By extension, you know when --no-index is implied and
when it isn't.

Can you explain what your problem is?
