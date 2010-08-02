From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] t/README: Document the Smoke testing
Date: Mon, 2 Aug 2010 17:13:28 -0500
Message-ID: <20100802221328.GA3826@burratino>
References: <1280780684-26344-1-git-send-email-avarab@gmail.com>
 <1280780684-26344-3-git-send-email-avarab@gmail.com>
 <AANLkTim2EY7AACe=UzbG-k7oteV6UMmfPAQMEOFn0iZ7@mail.gmail.com>
 <4C5732CE.10906@gmail.com>
 <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Sverre Rabbelier <srabbelier@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 00:14:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og3HZ-0002Cw-Lc
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 00:14:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248Ab0HBWOt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Aug 2010 18:14:49 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48165 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab0HBWOs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 18:14:48 -0400
Received: by qyk7 with SMTP id 7so82017qyk.19
        for <git@vger.kernel.org>; Mon, 02 Aug 2010 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zeMVpS9FTtKrNAVCYOk0n9MGsagIsjw6Wuet22tIi6o=;
        b=FgWQtQbHUl9QBY4+xT/4NFeTavLvuOQSuC08Ube+sW//AIHvwuFqiDRCxJwyiwyPVS
         Op9D4fSTxre3SuR4rKmVmJoieeKjCioCSWdTah7du1GT5vPv5YfS6az0k6aA+baRiCmK
         CTgAaXRnzl5ttoDAGqI2B/6IwbUB+fY+ujs9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=n9hd5JZTY2beyIlfs59dKq84ox/l1U5Fyp9VxlA5CsYYq8AuG2CxH2arUg4Irz8O82
         MqyDZ6wpK6lHk8o2FYRSxgbxWaEnEsjBerfLiiGZbzk3Hn9riDZpnVcrF3cP71UsorP9
         V62OFIUuxqP7bbUEbvruz0LW355mHxpk6qU+E=
Received: by 10.224.19.140 with SMTP id a12mr1735867qab.217.1280787287147;
        Mon, 02 Aug 2010 15:14:47 -0700 (PDT)
Received: from burratino ([66.99.2.25])
        by mx.google.com with ESMTPS id r29sm642607qcs.13.2010.08.02.15.14.44
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 02 Aug 2010 15:14:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=EuTD0M3eNo+PXW7Z2Ra2yzf-i+L4DFQVg8JZ7@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152471>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Mon, Aug 2, 2010 at 21:04, A Large Angry SCM <gitzilla@gmail.com> =
wrote:

>> And what's on the site tells us almost nothing about the tested syst=
ems.
>
> Can you be more specific? What information do you find lacking at
> http://smoke.git.nix.is/app/projects/smoke_reports/1 ?

Operating system (i.e., distro).  Precise CPU architecture.  Number of
CPUs.  Available memory.  Which tests were skipped and which had expect=
ed
failures.  Configuration used to build git.

(I understand that requiring all that information could prevent people
from running smoke servers, so I don=E2=80=99t mean to say it all shoul=
d be
required.)
