From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] tree.c: update read_tree_recursive callback to pass
 strbuf as base
Date: Mon, 8 Dec 2014 20:30:09 +0700
Message-ID: <CACsJy8BXjDqB0vGMw0QijaBKq0hsC8ZR4Teu=P7xUZFG7rjvag@mail.gmail.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
 <1417338302-8208-2-git-send-email-pclouds@gmail.com> <xmqqk32bp3nk.fsf@gitster.dls.corp.google.com>
 <CACsJy8B7G9xQerZ+6GTPQuG2v1DuJLXfsKFobuz_vyFahnXuYQ@mail.gmail.com>
 <CAPig+cS1OK6pv5A0vuJf=j6eFrNv70=AYgVz3zQny-md15_xKg@mail.gmail.com> <xmqq1toglnjf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 08 14:30:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxyOj-0006nc-R3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Dec 2014 14:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080AbaLHNal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Dec 2014 08:30:41 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41990 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751594AbaLHNak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Dec 2014 08:30:40 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so4475182ieb.37
        for <git@vger.kernel.org>; Mon, 08 Dec 2014 05:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1afzFTLZurIJintGWXwxMPfphcZHiae+nT7+/Nd6kzg=;
        b=cvqFhB1YBPH/PDeyH0WBPL2HKZWkON2Cetqbq2jvdA2Auw5KHhxRu/IIS0mmfpPNzd
         /QhHCGCrg1yaBY/Qg8vCSOCZRIJaeoG8W5yRwQsTFytoJrvyNddEOvaLAQSNJwjFpV0D
         KYW8G6EYkmZeMdTZd7T143etSUyr3g1objEySisT4hKcVu2iibGAUsrTcdaI1pbPP52s
         s/TOAlwsOOKKz06N8gTs9ZIMPsrDLlfIJP2Rs3W26c12cDTdzYGT/xEpJt/y1jf9YZg0
         qTlFkYhfNFpD0UcD9SXTe4jzvh+BS4LHHxIm2FHw2ggdcdeDYjlnR/h/pZTe939ygfV9
         ow9Q==
X-Received: by 10.42.167.1 with SMTP id q1mr25714131icy.48.1418045440105; Mon,
 08 Dec 2014 05:30:40 -0800 (PST)
Received: by 10.107.176.3 with HTTP; Mon, 8 Dec 2014 05:30:09 -0800 (PST)
In-Reply-To: <xmqq1toglnjf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261014>

On Wed, Dec 3, 2014 at 11:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> A question during the review, especially on proposed log messages
> and documentation changes, is rarely just a request to explain it to
> the questioner in the discussion. It is an indication that what is
> being commented on needs tweaking to be understood.

I do the same at work and somehow forgot to apply the same principle
here :D Do you want to me resend with Eric's wording?
-- 
Duy
