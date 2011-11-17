From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/8] cmd_merge: convert to single exit point
Date: Thu, 17 Nov 2011 04:44:06 -0600
Message-ID: <20111117104406.GB5277@elie.hsd1.il.comcast.net>
References: <1321522335-24193-1-git-send-email-pclouds@gmail.com>
 <1321522335-24193-5-git-send-email-pclouds@gmail.com>
 <CALkWK0kME4fgLK0S+sFRXmDX1uj_N5+PZnvLFJp33qNssPptWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 17 11:44:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQzS7-0006Hv-HN
	for gcvg-git-2@lo.gmane.org; Thu, 17 Nov 2011 11:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756594Ab1KQKoP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Nov 2011 05:44:15 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:56044 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756516Ab1KQKoO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Nov 2011 05:44:14 -0500
Received: by yenq3 with SMTP id q3so847400yen.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 02:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=XID0bSkh79e3mjrEMyNWiuswA2opoTUDzVv9e+6dvkQ=;
        b=bR26iaW2Cki9bJzhgv6znPyq+nq4eCYS8bPEZcWk4hI+4cwtES5mgOUgHSgqM2nxSX
         WFahb0p1QIx+QN/+MacoQ5z4krnYocr12BbgYHHiv+tyoYk0myoB1z09SPwSuAjVDn7J
         q2YTJphx4SDUu2Ta74nLsz+na6byyQiNz2kvw=
Received: by 10.50.47.168 with SMTP id e8mr42448154ign.15.1321526654046;
        Thu, 17 Nov 2011 02:44:14 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id ai7sm22613895igc.0.2011.11.17.02.44.12
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 02:44:13 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CALkWK0kME4fgLK0S+sFRXmDX1uj_N5+PZnvLFJp33qNssPptWQ@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185594>

Ramkumar Ramachandra wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

>> [Subject: [PATCH 4/8] cmd_merge: convert to single exit point]
>>
>> This makes post-processing easier.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
[...]
> Um, (how) does this seemingly unrelated patch belong to the series?

It's as Duy says --- it makes post-processing, for example to free()
a variable before returning, easier.  Which simplifies the next patch.
