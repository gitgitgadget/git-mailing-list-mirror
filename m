From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [WIP/PATCH v4 8/8] ref-filter: add 'ref-filter.h'
Date: Mon, 1 Jun 2015 00:34:17 +0200
Message-ID: <CAP8UFD1RnP1pk-MdzEBtiqTtpjaDyn-UZnEjCthrmHPYi1WCAA@mail.gmail.com>
References: <5569EF77.4010300@gmail.com>
	<1433008411-8550-8-git-send-email-karthik.188@gmail.com>
	<CAPig+cR88O=STcJDrB+96uJ0Y60mO49QxoJfbOY8Xk4hPvNxGA@mail.gmail.com>
	<556AC40C.5020205@gmail.com>
	<vpqlhg4jx0d.fsf@anie.imag.fr>
	<556B740A.5030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 00:34:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBoF-0007go-2o
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:34:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758610AbbEaWeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:34:20 -0400
Received: from mail-wi0-f181.google.com ([209.85.212.181]:36827 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758574AbbEaWeS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:34:18 -0400
Received: by wibdq8 with SMTP id dq8so13593216wib.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cT5DmzknXtTLcFRZZcrS4ZjQ0E0KMyZcdLqG2Lhh4cc=;
        b=zy6VWosDSWs1tBMy5gUkO9yeQb6qDh9/fvKCF/E1ha4OFX2T4sDMPgqxcCN4X9aGoH
         y5iCVoV3LTckN1iycjbi32DDuJ5+XaZSI9JYNHhqp6IoSLcp0bEenmvPJdK421fKRkbF
         azKwdDDXKR8FSfeG+bB2FwWf4E/glCWycws9ApdPSXuf9/deYTmkpULok+bebEvXfI4q
         eFQOWMoDb8H/nIq8v/GRhZNWxLLWDBFR5WwLutQ/sFIgENIB8n8DjBE2WFxi7nOrE95Z
         bYpV9SZbYYNmy2YR9U22hqDb/1ZG54P8F+UCaVKQbc05aWGybJxQb0pbos9/mrXktIKQ
         JD9w==
X-Received: by 10.180.88.99 with SMTP id bf3mr15086609wib.75.1433111657336;
 Sun, 31 May 2015 15:34:17 -0700 (PDT)
Received: by 10.194.40.8 with HTTP; Sun, 31 May 2015 15:34:17 -0700 (PDT)
In-Reply-To: <556B740A.5030404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270365>

On Sun, May 31, 2015 at 10:50 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On 06/01/2015 02:16 AM, Matthieu Moy wrote:
>>
>> You can have a preparatory patch that adds ref-filter.c containing just
>> "#include ref-filter.h" and ref-filter.h with proper content. After this
>> preparatory patch, you're in a rather silly situation because you have
>> an almost empty .c file, but it's still passing all tests and
>> compileable.
>>
>> Then, the next patch can be just code movement.
>>
> Would it be okay, If I just include the Makefile addition along with the
> code movement
> from 'for-each-ref' to 'ref-filter.c' like Eric suggested?

Yeah, I think it is ok as well.
