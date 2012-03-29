From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 5/8] gitweb: Move HTML-formatting diff line back to process_diff_line()
Date: Thu, 29 Mar 2012 17:49:42 +0100
Message-ID: <201203291849.42583.jnareb@gmail.com>
References: <1332543417-19664-1-git-send-email-michal.kiedrowicz@gmail.com> <1332543417-19664-6-git-send-email-michal.kiedrowicz@gmail.com> <201203291814.42803.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?q?Micha=C5=82_Kiedrowicz?= <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 29 18:51:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDIZl-0005QJ-9U
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 18:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759905Ab2C2Qvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Mar 2012 12:51:47 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:62731 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758338Ab2C2Qtp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 12:49:45 -0400
Received: by wibhq7 with SMTP id hq7so239405wib.1
        for <git@vger.kernel.org>; Thu, 29 Mar 2012 09:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=6lVWdirKA58ZlKxRJKvuGMPEgjKEpmbPOVEodEfQf4E=;
        b=O9HMQd1d9gYlL94vjz342+LlKeFORRKwpe9ZojzNfSp1KmbiM8Y1j2yDrv0O656j0w
         hEnJXgmy+OgUympcTck81JX84lFTm1g+omlmdbll++ObNPzTE98ot4oKAUrGKddoxnGq
         Lv22waIyXcnrr53YN6t0ftAUopXwPD1FT7Ki6FSHNi+conM7/CyePEs/V/0JJ7QOgdG8
         w+7Xe152/5Z2R8gzFW8ZDE/8vLBqe+kDgTvW8+rKnw1l0Z4daXT+ttvzNxkeQo1tqAdw
         Cva8g7ZsVuDTW7Xz3necYXq1Vqi97opXZu5pPlj8Cszk/ZKsOmzUorhIIpPgrY1QeN/s
         njwQ==
Received: by 10.180.102.102 with SMTP id fn6mr7305370wib.10.1333039783517;
        Thu, 29 Mar 2012 09:49:43 -0700 (PDT)
Received: from [192.168.1.13] (aeh224.neoplus.adsl.tpnet.pl. [83.25.111.224])
        by mx.google.com with ESMTPS id gg2sm30766242wib.7.2012.03.29.09.49.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Mar 2012 09:49:42 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201203291814.42803.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194269>

Jakub Narebski wrote:
> On Fri, 23 Mar 2012, Micha=C5=82 Kiedrowicz wrote:

> > The more long-term purpose of this patch is to move formatting diff
> > lines down to print_diff_chunk(), to allow processing lines without
> > HTML-formatting.
> >=20
> Excuse me, but from this commit message (and from the patch itseld)
> I don't see how this commit (patch) can help with this goal (and
> don't remember details of discussion).
>=20
> Please explain it in more detail, or simply remove above paragraph.

Or just squash it with next patch in this series.

--=20
Jakub Narebski
Poland
