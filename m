From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 11/18] revert: Save command-line options for continuing operation
Date: Thu, 4 Aug 2011 14:55:33 +0530
Message-ID: <CALkWK0kCR_GsGN-GUTypR=6TWEtzk4OfUPbfRVzwh0F+Zbyh+g@mail.gmail.com>
References: <1312222025-28453-1-git-send-email-artagnon@gmail.com>
 <1312222025-28453-12-git-send-email-artagnon@gmail.com> <201108040605.46420.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Aug 04 11:26:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QouBi-0003l9-UK
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 11:25:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753008Ab1HDJZz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Aug 2011 05:25:55 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:49055 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787Ab1HDJZy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Aug 2011 05:25:54 -0400
Received: by wwe5 with SMTP id 5so1700273wwe.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2011 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=v+EujG5SS/8kqW9wwqqLzPuty1LsGfrCqolBu5Tm3YI=;
        b=rSuKjHFKYjwQx2doZJmoOyUwbHWa9JUjK96o24TBdgHRNiwErSrnR+fz3EmvVTFM6f
         KS9wPNVIYjJi9SvHdVMZyElMSd9pnVngggvx23cLQId4y1QH+Hsiw4ed6uW90IGCWK5T
         zWf9ejBNHC7NRpAqTuA9xhN65jaKgze54Aezs=
Received: by 10.216.192.196 with SMTP id i46mr1578155wen.79.1312449953084;
 Thu, 04 Aug 2011 02:25:53 -0700 (PDT)
Received: by 10.216.137.134 with HTTP; Thu, 4 Aug 2011 02:25:33 -0700 (PDT)
In-Reply-To: <201108040605.46420.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178710>

Hi Christian,

Christian Couder writes:
> On Monday 01 August 2011 20:06:58 Ramkumar Ramachandra wrote:
>> +
>> +test_expect_success 'cherry-pick persists opts correctly' '
>> + =C2=A0 =C2=A0 rm -rf .git/sequencer &&
>> + =C2=A0 =C2=A0 pristine_detach initial &&
>
> pristine_detach() does a "rm -rf .git/sequencer" already.

=46ixed.

> "&&" is missing at the end of the line.
[...]

=46ixed all.  Thanks.

-- Ram
