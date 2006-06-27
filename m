From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: CFT: merge-recursive in C
Date: Tue, 27 Jun 2006 14:17:05 +0200
Message-ID: <81b0412b0606270517y199fbc5cn9e19639b01813a7f@mail.gmail.com>
References: <20060626233838.GA3121@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>,
	"Fredrik Kuivinen" <freku045@student.liu.se>
X-From: git-owner@vger.kernel.org Tue Jun 27 14:17:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvCVR-0000F0-4i
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 14:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWF0MRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 08:17:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWF0MRK
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 08:17:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:16117 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751318AbWF0MRH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 08:17:07 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2548030ugf
        for <git@vger.kernel.org>; Tue, 27 Jun 2006 05:17:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U7mz221S2FzIH58nolSJDPj604Q/fwTYiiK2zzFGEZq3Z6HXtRuhbGRiEdTBY8Q0slZ4RdlQIOqPLDApFc6C1v/bMpUFoqwEBkPF64Kf+9OAbCEwHHoRMNgpgdOJ0pfo+pnbPEep0rhIVU6E24NWKen2EvDqri7q9W3GXTrBvzs=
Received: by 10.78.151.3 with SMTP id y3mr2479137hud;
        Tue, 27 Jun 2006 05:17:05 -0700 (PDT)
Received: by 10.78.37.7 with HTTP; Tue, 27 Jun 2006 05:17:05 -0700 (PDT)
To: "Alex Riesen" <raa.lkml@gmail.com>
In-Reply-To: <20060626233838.GA3121@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22734>

On 6/27/06, Alex Riesen <fork0@t-online.de> wrote:
> Hi all.
>
> I finally got pis^Witched enough by my platform at work and decided
> to start the effort of converting Fredriks git-merge-recursive to C.
> At the moment it is the only one annoyingly slow thing there.
>

Just tested it on my project. It's still the slow thing (even a bit
slower, looks CPU bound).
