From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v4 04/73] Makefile: "pot" target to extract messages
 marked for translation
Date: Fri, 25 Feb 2011 20:53:21 +0100
Message-ID: <AANLkTim72p3H5zrELsApN8EM1CAU1H=FdjaoL+s=cJzH@mail.gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
	<1298418152-27789-5-git-send-email-avarab@gmail.com>
	<20110225072212.GC23037@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 20:58:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt3oV-0002LA-81
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 20:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932864Ab1BYT6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Feb 2011 14:58:50 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:39323 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756368Ab1BYT6t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Feb 2011 14:58:49 -0500
Received: by fxm17 with SMTP id 17so2020377fxm.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 11:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Nw4HAG0n1OGZr/1DnD75mZIsLhZQMDHoFIG57OkUuCw=;
        b=D6Hh6rrIkMfDbRbrEGW5aUfzj/OEr0YhMuoEDGWppDcqYrt1njd1/NaO1iVFl5+3Dd
         l///YqGddSR1oeud/KbbWiwUTg6AUuOBDgXLl9k7BOOjW+ZZ/dpPWAFhF3yJ5vb7p2lM
         0i0v2GmLlVHbRbKf98MsyQkmKHfYa8hqi5Wko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=vQZERL9kzI0tytmwjzJgJqJaggW/uMRMQ8x09lpdLvGg+7I7Z1uq1GzSXH1Am7jEFR
         BV26016Oy59GmhWz78F70YX8jEoZ+kSGdAHIJoyxjbPccF1Wf4xcKRbXVeCcEr3Zi+K0
         yAoeiuKvfh0WJz5sm7+ZKKh8E52utLoSYAYMQ=
Received: by 10.223.103.66 with SMTP id j2mr3177994fao.83.1298663601803; Fri,
 25 Feb 2011 11:53:21 -0800 (PST)
Received: by 10.223.2.201 with HTTP; Fri, 25 Feb 2011 11:53:21 -0800 (PST)
In-Reply-To: <20110225072212.GC23037@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167929>

On Fri, Feb 25, 2011 at 08:22, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> A forgotten piece. =C2=A0Not urgent at all.

Yeah, noticed this. Meant to sent a fixup for it. Thanks for beating
me to it.

There's also one other (future) issue your `mv $i+ $i` trick confuses
xgettext, which complains about invalid CHARSET in a later patch when
there's more than one xgettext call. I.e. it doesn't like to append to
files that don't end in *.pot for some reason.

The output is still the same though, so the warning doesn't have any
real effect.

Just thought I'd mention it.
