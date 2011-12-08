From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] parse-options: introduce OPT_SUBCOMMAND
Date: Thu, 8 Dec 2011 22:13:34 +0530
Message-ID: <CALkWK0ksMPjjh8EJjJz6wKS6ciF9x59n3KFauJvnB-1D4d4N1w@mail.gmail.com>
References: <1323349817-15737-1-git-send-email-artagnon@gmail.com>
 <1323349817-15737-2-git-send-email-artagnon@gmail.com> <20111208163049.GA2116@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 08 17:44:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYh4i-0003Kb-Gn
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 17:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab1LHQn4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Dec 2011 11:43:56 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52034 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751597Ab1LHQnz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Dec 2011 11:43:55 -0500
Received: by qcqz2 with SMTP id z2so1447622qcq.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 08:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=f7MR2HEyrRsEBrT/DkxzLO1bbAVcTTbNgikyv9Gyj/E=;
        b=FV5L886X1ffIM9h4i2nJz+SD5oY4MdeOInAP9bml+yxiOPvcriaknaf+mNNX0i1B4J
         losF3w6Z4Zmzt4b+zPug2tRJcD+nBoQPBgZgeB6ukxfOC8FyzIzlzfL//a2V0NjlH169
         wW2qQX1F22Hs8e9UJhht2aTd6R9SyY1rjsu68=
Received: by 10.229.67.142 with SMTP id r14mr977682qci.240.1323362635157; Thu,
 08 Dec 2011 08:43:55 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Thu, 8 Dec 2011 08:43:34 -0800 (PST)
In-Reply-To: <20111208163049.GA2116@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186571>

Hi,

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>> , and create a new
>> OPT_SUBCOMMAND; this is built on top of OPTION_BIT to allow for the
>> detection of more than one subcommand.
>
> This part I am not convinced about. =C2=A0Usually each subcommand tak=
es its
> own options, so I cannot see this OPT_SUBCOMMAND being actually usefu=
l
> for commands like "git stash" or "git remote".

Hm, what difference does that make?  We still have to parse the
subcommand, and subsequently use an if-else construct to parse more
options depending on the subcommand, no?

-- Ram
