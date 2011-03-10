From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] i18n: add stub Q_() wrapper for ngettext
Date: Thu, 10 Mar 2011 10:24:10 +0100
Message-ID: <AANLkTinfsiJHbkpy4BW8yFYzc7qdUZ16iT8W85hMe4Nh@mail.gmail.com>
References: <4D7223A9.6080105@colin.guthr.ie>
	<7vsjuz520w.fsf@alter.siamese.dyndns.org>
	<7vhbbf50vu.fsf@alter.siamese.dyndns.org>
	<20110306225641.GB24327@elie>
	<AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
	<20110309103104.GA30980@elie>
	<20110309105236.GC30980@elie>
	<7vfwqw9g9b.fsf@alter.siamese.dyndns.org>
	<20110309205155.GC22292@elie>
	<7v7hc89fp7.fsf@alter.siamese.dyndns.org>
	<20110310031734.GA24781@elie>
	<7vd3lz76eq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 10:24:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxc6X-0001Xm-8E
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 10:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123Ab1CJJYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 04:24:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63701 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751856Ab1CJJYM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 04:24:12 -0500
Received: by eyx24 with SMTP id 24so426867eyx.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 01:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Vg2aFC7bx0jAkugbkHNuhX/KESpgQNL1Ngt/x5Jfak4=;
        b=RZS7bMcEmCPmAY/o1DqzREhfIFeijfX/D2nSACIT3aDHDeEF09w2FyN3JccHqtHBhX
         zJ07bfuG7Dm3RYMhpmM77EQlc60wRTw2uoWANpzCiv6wy0eCXMlijkFX8pvn1dmA7Lyb
         Asn4UJveyxaAJ6C+x7zXiyzD1hfwYTN/FPxnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Bs3Y9dpKeLBIJZBn9dDKPc3fqZ0vWYeZFyTbYKfAVZ0D6okEKdfQ69fIhUweR/dO15
         HIGKXyVF5GQetttXoNJX9FpikNdXXujnZR5t/8e1gpYd9ofJ2ncytgQ3jf0h9wYf7p/F
         GzPy+OUjcoLwDrLEVDFZ+/0uO8acvno8HdiPI=
Received: by 10.223.96.137 with SMTP id h9mr4312458fan.141.1299749051050; Thu,
 10 Mar 2011 01:24:11 -0800 (PST)
Received: by 10.223.108.130 with HTTP; Thu, 10 Mar 2011 01:24:10 -0800 (PST)
In-Reply-To: <7vd3lz76eq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168801>

On Thu, Mar 10, 2011 at 08:59, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> I suppose Q_ is as good a name as any.
>
> Ok, let's run with this for now, as we hopefully don't have too many
> places that might want to use ngettext(), and they should wait until the
> early parts of the series settles and in-flight topics are adjusted to the
> barebones infrastructure.

Yeah, it looks good to me. You can add my Acked-by to it if you'd like.
