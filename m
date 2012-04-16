From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tests: add tests for the bash prompt functions in the
 completion script
Date: Mon, 16 Apr 2012 11:01:24 -0500
Message-ID: <20120416160124.GL5813@burratino>
References: <1334521909-32581-1-git-send-email-szeder@ira.uka.de>
 <CAMP44s3LJO_Ryc-ONjF+rEHCb1hB8+4Muar6pzjD3zrazYqK+A@mail.gmail.com>
 <20120416094938.GE2900@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:01:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoMz-0004we-Tx
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078Ab2DPQBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Apr 2012 12:01:33 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:35189 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751002Ab2DPQBc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Apr 2012 12:01:32 -0400
Received: by gghe5 with SMTP id e5so2531549ggh.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 09:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LgH+ze0+6MuJtWpGDTckMjYjdyBn4xYCoJhTQffmRqo=;
        b=pJ7NHmPw9enFdO/7EiLzp9qNAwkSuGiZRoBxDwaFKlzEMn6H3EG4jj/CqfoK5O1J/t
         H75+pu0jvs4WBcCi/FKgsAJ0tPCTKCrDNtMAkpkkl5LGv2dhBwoNApg+tHjuMbZPdybO
         wJ3y8CkpPxW87Cyjln3VgcrjnmGrL8zzbTiLA4xh2LrVl05q3nVHItIq/tisoDpNc11x
         ZWd6Yw3nkuXwDJUcaE1l4/rlydAO+JfOx70sV97HrVyvb5ajfnQY/Wj+aIg3U3TMbfTu
         hOOxa7OM9ZIt+9i5DulB/ltduP8Wm1XSB2jBFt4TqAgYbwiMCzYyGbp6llITeoQIujoX
         /cew==
Received: by 10.182.44.97 with SMTP id d1mr10405006obm.28.1334592092241;
        Mon, 16 Apr 2012 09:01:32 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id h5sm19767247oba.17.2012.04.16.09.01.30
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 09:01:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120416094938.GE2900@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195653>

SZEDER G=C3=A1bor wrote:

> I thought about that briefly but decided against it to avoid
> duplicating the bash-specific checks at the beginning, but I don't
> care that much either way.

Maybe a t/lib-completion.sh would take care of that.  FWIW a clean
split in the test script so it doesn't grow into something like the
current fast-import tests sounds like a good idea to me. :)
