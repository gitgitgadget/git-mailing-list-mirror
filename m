From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] test: improve rebase -q test
Date: Mon, 10 Jun 2013 12:01:06 -0500
Message-ID: <CAMP44s33khUaAWV+UrkS2CVRy2aCCk8kv3h5HXROySoocKrL8w@mail.gmail.com>
References: <1370637143-21336-1-git-send-email-felipe.contreras@gmail.com>
	<1370637143-21336-3-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8DHeqOz=WbxurCvPiDq73k4eftwrEEZzWBbifS51PDbLQ@mail.gmail.com>
	<7vd2rvqgra.fsf@alter.siamese.dyndns.org>
	<CAMP44s3Pny7JkyHbLZ3kUemNK70JhdYWdpELTjNLz0y3Z2V3+A@mail.gmail.com>
	<7vy5ajozuj.fsf@alter.siamese.dyndns.org>
	<CAMP44s38T9EUOe8EBKy1kxa-rEu7g0jb7+HB019AgCub+2SVnw@mail.gmail.com>
	<7vfvwrowd0.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Qr54+8hbkZ+jmXB628SCPwg1zZo80UBhFe2PCrgQP4Q@mail.gmail.com>
	<20130610093904.GG2091@goldbirke>
	<7vppvuj6wl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 19:01:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um5T0-0003Px-F2
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 19:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406Ab3FJRBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 13:01:09 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:34888 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260Ab3FJRBI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 13:01:08 -0400
Received: by mail-lb0-f169.google.com with SMTP id d10so6575557lbj.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2013 10:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GNzGe4133j07dmxjXa0Sczga5EgO4FIqJ8TO32zbNOA=;
        b=yHZGf8EOMOY699d8OJVcifvpmkmkE01UgI0GeeV99Uv8cuOJDboI83a7DXje/u/q9D
         LycmYs92Gn1gvXgCabx9IaTmpryh0TFPv/RTpRw4wPHyF/TgwCYiUWFenoa0+F6a9SDQ
         u9J5NDnCVoBuP/pIlwU98vwB28aP44tl44A9jOA9XFf7JmK0DLNb555r30oopUYl245f
         AH2EtuuqR8gonzx0GsGAyWVkSGsc1W9q51nCbBybsD3pzPGzb/D0IO751fGDeeBHeR6t
         XBG1Klx5uI94OAjLS8DwDF5FD+SZahaW+kuuJd5UeLC9s72O+zpJ122uAWCVIeW9rZD7
         mQJQ==
X-Received: by 10.112.140.231 with SMTP id rj7mr7104963lbb.16.1370883667056;
 Mon, 10 Jun 2013 10:01:07 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Mon, 10 Jun 2013 10:01:06 -0700 (PDT)
In-Reply-To: <7vppvuj6wl.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227324>

On Mon, Jun 10, 2013 at 10:56 AM, Junio C Hamano <gitster@pobox.com> wrote:

> By the way, test_cmp() is a replacement for the "cmp" command and
> that is why it does not have "file" in its name.

That's an irrelevant implementation detail. But if you want to be
driven the the implementation, call it test_zero().

-- 
Felipe Contreras
