From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH 2/2] doc: command line interface (cli) dot-repository dwimmery
Date: Tue, 21 May 2013 16:21:53 -0500
Message-ID: <CAMP44s3G5BPbw3MO8W3rmDabJ-ewf-C5FH8HHO_o0cPf0f55BA@mail.gmail.com>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
	<1368964449-2724-3-git-send-email-philipoakley@iee.org>
	<20130519173924.GB3362@elie.Belkin>
	<7v38thwn6l.fsf@alter.siamese.dyndns.org>
	<BDA138F1A58247F4A4940B3436A94485@PhilipOakley>
	<7v1u91uw95.fsf@alter.siamese.dyndns.org>
	<08847FEAFB00489695F31AA651F5EA2E@PhilipOakley>
	<7vfvxgqp3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	GitList <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 21 23:22:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueu0O-0000tF-9X
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 23:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407Ab3EUVV4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 May 2013 17:21:56 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:54803 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab3EUVVz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 May 2013 17:21:55 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so1253110lab.35
        for <git@vger.kernel.org>; Tue, 21 May 2013 14:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=6O4lERU7227VbZuBIVFZIczjeiE3OFMz1lt57CYBnq4=;
        b=thVKmNS1zXMjnuW9ldJypCTDaLmjPYlPhybXYjkAczlhVT5uKKm3iR8twyJADrqZBc
         mkh5BJU3gJQxkF7sWhzFZG7RwndUpG+kOx8AkyOcHZJstOXd1PbTjMThV5p+UMaWPYEA
         t8qwEWadUqqMDzomcaqe5H518y2L5Lrs7d/eho2Dc/g6fM/OPeFAjoZFwQ+OPCfq7pIp
         gTOxrcQBWRirfn7IbBQ2b8L7ZzzCNiejZTJTkeCptaKTu/H5IVzjez5PwSluzosAEn8V
         X+ipWU2s77LoOsH3XOjaDJR9b3DWE+3e7BKne6vQZcydHDk2Yk/9CFkDQlpka0Wx0IHe
         12IA==
X-Received: by 10.112.166.101 with SMTP id zf5mr2517850lbb.59.1369171313654;
 Tue, 21 May 2013 14:21:53 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 21 May 2013 14:21:53 -0700 (PDT)
In-Reply-To: <7vfvxgqp3m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225080>

On Tue, May 21, 2013 at 11:23 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Philip Oakley" <philipoakley@iee.org> writes:

>> On Sat, May 4, 2013 at 2:51 PM, Jonathan Nieder <jrnieder@gmail.com>
>> wrote:
>>> Another trick is to use "git push":
>>>         git push . $production_sha1:refs/heads/master
>
> It all falls out naturally from the "Git is distributed and no
> repository is special" principle.  I think that word "trick" merely
> refers to "those who do not realize that the local repository is not
> all that special and merely is _a_ repository just like anybody
> else's may not realize they can do this", nothing more.

Nobody cares.

>> Filipe gave 'git fetch .' in [PATCH 1/3] fetch: add --allow-local
>> option, 16 May 2013
>
> That patch came from a mistaken suggestion from me that was
> retracted with

You say it's "mistaken", but you are not the arbiter of truth; the
fact that you say it's so doesn't make it so. It's just rhetoric.

You haven't shown that it's indeed mistaken.

-- 
Felipe Contreras
