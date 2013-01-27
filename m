From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 6/8] git-remote-testpy: hash bytes explicitly
Date: Sat, 26 Jan 2013 21:30:16 -0800
Message-ID: <CAGdFq_icLDEdJJKHZsht8bXpZzSNProLt3F_u=0en2rFBvxLKw@mail.gmail.com>
References: <cover.1358686905.git.john@keeping.me.uk> <611a44568bdc969bcfa3d7d870560855e00baf1e.1358686905.git.john@keeping.me.uk>
 <20130126175158.GK7498@serenity.lan> <7vwquzzkiw.fsf@alter.siamese.dyndns.org>
 <5104B0B5.1030501@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Jan 27 06:31:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzKpq-0007oZ-CL
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 06:31:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457Ab3A0Fa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jan 2013 00:30:58 -0500
Received: from mail-qc0-f181.google.com ([209.85.216.181]:47229 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab3A0Fa4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jan 2013 00:30:56 -0500
Received: by mail-qc0-f181.google.com with SMTP id x40so823736qcp.40
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 21:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=66x8V0bdvMPu8/hjlu52Y9J1E95mc3qV7njA2pvtgzQ=;
        b=SF/j9PmejRF/hUc9tt0eWHZC/AMNRZ7/aUxNDf2HUS/+TnaBvnbPuyVwWdexm/ZEqo
         OGe2+cu0PZYPhWV3lDDm8dYFjgyQ3pBP2/AwpwL6TubUJCwTHaNiAkDb+QXy6qq9mCd8
         deOpoyMT2zhvxhyYRzm3UIioNVFOkZdcpI0JSBPwZA46Eg2tUdYMzGcOG9Hi0RGFc/5k
         7DSXmA+4SCGg3aYnK6+45L11ioZoMdFlQ27On1REUk/IRTwDTT+E6fg+8fG4IbER3Zsq
         9wQPOIdLkbwgpV64vLx8huJGiIB/lDSKbMwYVrKjRfPTC5wzhHStljRvFjopwpIrWT8P
         fpig==
X-Received: by 10.224.183.197 with SMTP id ch5mr11607547qab.27.1359264656243;
 Sat, 26 Jan 2013 21:30:56 -0800 (PST)
Received: by 10.49.51.227 with HTTP; Sat, 26 Jan 2013 21:30:16 -0800 (PST)
In-Reply-To: <5104B0B5.1030501@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214679>

On Sat, Jan 26, 2013 at 8:44 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> So to handle all of the cases across Python versions as closely as
> possible to the old 2.x code, it might be necessary to make the code
> explicitly depend on the Python version number, like:

Does this all go away if we restrict ourselves to python 2.6 and just
use the b prefix?

--
Cheers,

Sverre Rabbelier
