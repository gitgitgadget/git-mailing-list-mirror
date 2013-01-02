From: Dan McGee <dan@archlinux.org>
Subject: Re: Test failures with python versions when building git 1.8.1
Date: Wed, 2 Jan 2013 15:25:55 -0600
Message-ID: <CAEik5nPL1J8m3_CyF0m1=4HWran4+6nRGZKtHOEdD_FWBHX6bA@mail.gmail.com>
References: <CAEik5nOqge8ix4WGf-h+0Dmz1CanH_XtQdB-CxvPsggSu1-LzQ@mail.gmail.com>
	<7va9ss5fhq.fsf@alter.siamese.dyndns.org>
	<20130102065345.GA8685@sigill.intra.peff.net>
	<7v1ue459yh.fsf@alter.siamese.dyndns.org>
	<20130102085935.GB9328@sigill.intra.peff.net>
	<CAEik5nMRAoHdx166Q7Zb5Yve6DiyVgN6EXQWGF=GgUtSyjiuSA@mail.gmail.com>
	<7vehi34k5s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, GIT Mailing-list <git@vger.kernel.org>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	David Michael Barr <b@rr-dav.id.au>,
	"Eric S. Raymond" <esr@thyrsus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:26:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqVpI-0007IR-3C
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 22:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752771Ab3ABVZ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 16:25:57 -0500
Received: from mail-vc0-f171.google.com ([209.85.220.171]:63898 "EHLO
	mail-vc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867Ab3ABVZ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 16:25:56 -0500
Received: by mail-vc0-f171.google.com with SMTP id n11so14624243vch.16
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 13:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=cbczGfzqWj9EaQ/5h3qa6j9wUiiJ6UOm5dP3NG0EPbc=;
        b=cw5227lRs85vt9sXgK/L+J7GinBnraWAy5xB5gFAI0wkJTbYjidJ0nVnptW0EDFgW0
         t9HJCvGnQyvhMzn5uZKnUqgMNIlEOpg3Dq9UGt8tlGl4E8OqOVkG41KcNFHYE42buhIc
         79y+Y2oqLQrUyl5NIvjCOpzXu8jEoetxjWrOboA1eO0RI6sJsIccRY9yd9tgN6NL+QMx
         nYo86tLTRT9ykbpW7uAKlBrVf1AO0SGpOeEbN7pTFe9L0khHF0KxMiVEHxfGZHM211HD
         hPiGiwu8HUeqNFvdmaYhskXhfjaWyFoqaJgjeg2ydLeRvIEtANjg48irOXpFK+vUDB83
         W3/g==
Received: by 10.58.233.210 with SMTP id ty18mr60530065vec.46.1357161955543;
 Wed, 02 Jan 2013 13:25:55 -0800 (PST)
Received: by 10.58.34.11 with HTTP; Wed, 2 Jan 2013 13:25:55 -0800 (PST)
In-Reply-To: <7vehi34k5s.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: k6nDDHickj35u49VQU-d6CeCJS4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212545>

On Wed, Jan 2, 2013 at 10:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Dan McGee <dan@archlinux.org> writes:
>
>> This works great now, thanks! I ran it through our package build
>> scripts and all tests now pass as expected.
>
> If you have a chance, could you try tip of the 'next' branch without
> this patch applied?  We had an equivalent patch cooking there for
> some time by now.

Yeah, this worked great as well. Thanks again everyone.

-Dan
