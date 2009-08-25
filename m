From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: gitosis-lite
Date: Tue, 25 Aug 2009 08:30:26 +0530
Message-ID: <2e24e5b90908242000t212347fbkec6a01396d784736@mail.gmail.com>
References: <2e24e5b90908240528v56fdf30cq4c046fca321a3b17@mail.gmail.com>
	 <m3ab1pmk1c.fsf@localhost.localdomain>
	 <2e24e5b90908240735n5f754c87u960493c92769c0a8@mail.gmail.com>
	 <20090824151051.GB1033@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tommi Virtanen <tv@eagain.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 05:00:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfmGy-0006NL-QV
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 05:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbZHYDAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Aug 2009 23:00:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754221AbZHYDAZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 23:00:25 -0400
Received: from mail-iw0-f204.google.com ([209.85.223.204]:40264 "EHLO
	mail-iw0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754219AbZHYDAY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Aug 2009 23:00:24 -0400
Received: by iwn42 with SMTP id 42so1166421iwn.33
        for <git@vger.kernel.org>; Mon, 24 Aug 2009 20:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7+xzs0lpE2tWGF+0HEeJPRUHJ6fe0KfxZwENCRFriSw=;
        b=Q/GEgr8+/spLKqGGpOUD5PZqeh/v6mJX6OwTD8zjl1oL7qsVdBA9nmqrqkiEKmJRsC
         9+g8NsD60DMIt5KgJPOPl2LVULTpHWLviel6Ap4O7/Ar3OtECRqD567X9YNJGIn1L/yp
         /xZDRPmb9RZnKYsUV/A8nf7/nhd4Kbn6Oc5NA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p4LW3gy4JJFyoi2U9jhPA4nnUfRifNnwtpvKYH+4czZiilYZ9X8GovWJV7d4m2xhaM
         J0GbIDkw+Ae4pISTCDQOGlVC0FNj1oA5aJgZrtyx5ZFZ7/uo0VCP1lfD9erG30Ozced3
         FXE1bf7pQ1kUl5Qu6r/WGQ25o0zGtS5HAfWqs=
Received: by 10.231.15.194 with SMTP id l2mr2576925iba.25.1251169226505; Mon, 
	24 Aug 2009 20:00:26 -0700 (PDT)
In-Reply-To: <20090824151051.GB1033@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126992>

On Mon, Aug 24, 2009 at 8:40 PM, Shawn O. Pearce<spearce@spearce.org> w=
rote:
> Sitaram Chamarty <sitaramc@gmail.com> wrote:

>> I'll be honest: I
>> came away feeling very stupid after trying to read and
>> understand that program. =A0It was... humbling :(

> *sigh* That's not good, the hook is meant as a practical example,
> if it was too complex to understand, I did a poor job of writing it.

Hmmm no.  It was just doing too much to grasp in one
reading, especially by someone whose perl seems to have
rusted a wee bit, if you've seen Jakub's reply :)

I took a slightly longer look after your mail and I grokked
it a lot better.  And wow... I guess you called it
"paranoid" for a reason :-)

In the environments I'm catering to, every commit will be
reviewed by someone else (usually someone more experienced,
and having a bigger picture), so "you're not allowed to
touch this file" type of thing will all come out.

All I need is to make sure the important branches can only
be pushed to by certain people; the "process" will take care
of the rest.
