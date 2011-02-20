From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/72] t/test-lib.sh: add always-set NO_GETTEXT_POISON
 prerequisite
Date: Sun, 20 Feb 2011 16:10:33 -0600
Message-ID: <20110220221033.GD32142@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <1298143495-3681-4-git-send-email-avarab@gmail.com>
 <20110220021031.GB17305@elie>
 <AANLkTik9ieR=pWLQ9JEabNm2trSsyfFuYgfKMojnbzfb@mail.gmail.com>
 <20110220215533.GB32142@elie>
 <AANLkTikJbwp+-=sgX2RLo-aXA_gmmO2gLsC=+MxEYxXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 20 23:10:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrHUR-0000ed-7t
	for gcvg-git-2@lo.gmane.org; Sun, 20 Feb 2011 23:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754981Ab1BTWKi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Feb 2011 17:10:38 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:52181 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754920Ab1BTWKh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Feb 2011 17:10:37 -0500
Received: by gxk8 with SMTP id 8so250683gxk.19
        for <git@vger.kernel.org>; Sun, 20 Feb 2011 14:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e+LvC1t9hb2eW5kb+l91DfaXYIa/q40Ext2vmCRW04M=;
        b=xHcXjKTaST5+U+o0hdkk3w/2uYhpxWWa4T4UddxrGFz5eGAkVf5UnO9vTKFVzt2wq/
         IhIdxReayRQWz/rDlDzLcLE6Ffj5F0ZOyqTnlBWw5zMBVtD6JSnlQ9Mzx4qRoZrSK0cF
         nOalCUCSvC7ioZX67SKOnUTco4sZ5DNcvQUo8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=A9k1uiOURHoIIae9Nx4ToV0/iNNEH8AEQ+pm6alKVx7bLwe1C9R2VNk9EYR5XmhAl3
         QvyZEIXgVnPsTZBAnL7a8h8JxSTJL4ENQZ5YljiKnRgcs/FhLtm2ldW73CcYsHnSP93s
         oXnRLtyaAYLgHL0+vvPLEHVQg/1NEG7U2jmkc=
Received: by 10.151.79.13 with SMTP id g13mr898219ybl.51.1298239837145;
        Sun, 20 Feb 2011 14:10:37 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id j3sm2801081yha.7.2011.02.20.14.10.35
        (version=SSLv3 cipher=OTHER);
        Sun, 20 Feb 2011 14:10:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikJbwp+-=sgX2RLo-aXA_gmmO2gLsC=+MxEYxXg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167432>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Well, the feature I have is to inject garbage into the gettext string=
s
> in an effort to smoke out when I break the plumbing. So I think given
> that functionality calling it NO_GETTEXT_POISON makes sense.
>
> But I plan to add something to smoke other languages etc. later. Then
> I might name that other prerequisite something else.

On second thought, another possibility would be _two_ prerequisites,
one NO_GETTEXT_POISON one and one ENGLISH one.  The weird edge cases
could require NO_GETTEXT_POISON, causing the reader to look to
t/README to figure out what is going on.  The others would just use
ENGLISH.

Does that sound reasonable?
