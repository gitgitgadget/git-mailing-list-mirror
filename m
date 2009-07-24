From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [RFC PATCH v2 1/3] Introduce git-unstage
Date: Fri, 24 Jul 2009 19:59:34 +0200
Message-ID: <36ca99e90907241059l1d06681v1490a89fbbcaaf8@mail.gmail.com>
References: <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch>
	 <683ed99f389d643d21bda6750bd2ee9caf287625.1248452530.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Jul 24 19:59:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUP3b-0005ec-Iq
	for gcvg-git-2@gmane.org; Fri, 24 Jul 2009 19:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbZGXR7g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jul 2009 13:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbZGXR7g
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 13:59:36 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:40746 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440AbZGXR7f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jul 2009 13:59:35 -0400
Received: by bwz28 with SMTP id 28so1569783bwz.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QOGNiuKpW1kaDNCaKfzc4n+tY6tKI8DaVzP5Bw/I6gk=;
        b=Be1x8AIpryDMkiRGh9AXS63vdPE0mFJ+BA2AWFJlv5dMeUBZyb72QFJAvUCS4HPo3a
         RqntGh1ThbBnVa5i3zSbpLVp165DlSEl89FwMZphu52sevv4YOXkVTshxuRhBO1BgQE4
         hyeMNObmoI19wZCGnIoJAn6NNn2f/SPtaZU5w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Otq3nbVQvC+9hPJslEbltYUY5Y//SF7nKbwO2cYgC8Sh6Rmp6t9AxXU8kaqCxFq8PP
         KRvCskl2mm6ukmwYwWPdXRK+knmmbg5E+tKu3uC3f+Sv+AZRlPGjdQK7BE1TurumkHpj
         PybG5tExmzIosvQ+y5WAWAwIyYD7LhQtgZiC4=
Received: by 10.223.119.198 with SMTP id a6mr1882274far.42.1248458374649; Fri, 
	24 Jul 2009 10:59:34 -0700 (PDT)
In-Reply-To: <683ed99f389d643d21bda6750bd2ee9caf287625.1248452530.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123934>

On Fri, Jul 24, 2009 at 18:24, Thomas Rast<trast@student.ethz.ch> wrote=
:
> As such, it is the same as 'git reset --' ...
Nope!

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 exec git reset "$@"
See!

Bert
