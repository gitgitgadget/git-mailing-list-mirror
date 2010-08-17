From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 03/24] t7600 (merge): do not launch gitk for --debug
Date: Tue, 17 Aug 2010 07:31:55 +0000
Message-ID: <AANLkTimx2bn_Z+MMK_abYin9vdNaBnw7egjdszu4PqGx@mail.gmail.com>
References: <20100817065147.GA18293@burratino>
	<20100817065459.GC22057@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
	Tay Ray Chuan <rctay89@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Clemens Buchacher <drizzd@aon.at>, Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 17 09:32:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OlGeW-0001cd-6B
	for gcvg-git-2@lo.gmane.org; Tue, 17 Aug 2010 09:32:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550Ab0HQHb5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 17 Aug 2010 03:31:57 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:44647 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751536Ab0HQHb5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Aug 2010 03:31:57 -0400
Received: by ywh1 with SMTP id 1so2281686ywh.19
        for <git@vger.kernel.org>; Tue, 17 Aug 2010 00:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ezZol/i8UZtrB6Wdchyv2Og4CYJI7b6fZLla99TY69M=;
        b=neS4Y05254WxZACLBiN1qiBIs7wy9+fBaOrfb1NbA4SieTB2yynrkDMKpN2i5jWN2e
         Vp50/8R4XT0ZjsAAWZvZddW2ippzShjipK9CLE/9JKarsUUUzYURMz3QWI9yIRwBrxJ5
         jUNTCKbR8X4KRMbhUaRWLwjy8UFxkfY7HYrP8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=f5nByuhBNSr5qpXi7qBxZNn2IgwyqnvNoHifEFeOY+fcqQNaeGbNSMpGkxa4nXCGw4
         jPLQN/HoJLFAaswnY6rxZEzQIhPoN1eq27cYcX89Oss/6QLLd8lYZSh7f6q4Cz3lrf+7
         nsjFx/5iG5cG/KKiXov8RWvv8GefWxXOjl0G4=
Received: by 10.231.139.212 with SMTP id f20mr6647212ibu.166.1282030315496;
 Tue, 17 Aug 2010 00:31:55 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Tue, 17 Aug 2010 00:31:55 -0700 (PDT)
In-Reply-To: <20100817065459.GC22057@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153728>

On Tue, Aug 17, 2010 at 06:54, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> Probably as a development aid, this test script runs gitk --all
> to allow the driver to inspect history between tests when run
> with --debug. =C2=A0As a result, running all tests with --debug
> requires closing a long series of gitk displays, one at a time.

Yes!, I was going to fix that myself sometime. Thanks for doing it,
that behavior was very annoying.
