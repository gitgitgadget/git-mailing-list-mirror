From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v3] build: add default aliases
Date: Tue, 15 Oct 2013 22:43:42 -0500
Message-ID: <525e0b6e25aeb_81a151de7495@nysa.notmuch>
References: <1379791221-29925-1-git-send-email-felipe.contreras@gmail.com>
 <20130924045325.GD2766@sigill.intra.peff.net>
 <xmqqy55ub1ud.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 16 05:58:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWIFa-0003Ei-UG
	for gcvg-git-2@plane.gmane.org; Wed, 16 Oct 2013 05:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759016Ab3JPD6T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Oct 2013 23:58:19 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:64201 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754653Ab3JPD6S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Oct 2013 23:58:18 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so142634obc.17
        for <git@vger.kernel.org>; Tue, 15 Oct 2013 20:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=piOEtkXShKkWQ8bDdLpwMQq5NbV6FqT+veML632MdEg=;
        b=gdBBZO45MOrxyy20snLqZcbd8xrSeYPA/9eaPy/mn4MUO4jhmV8GG03sgA7n0gaILj
         bDKqaxMjI8RRJ4dMiGd6XAUsnGJRv0CBUteJoWrhLSWuZpRsNhX0TOGHisERdOiysXyv
         ZGNxl9TQ/DA/jSZHJ1yOkMa+mtqlfIzLIhTHGfWuubmDkpSPNB2OcfZtM4RPpTLQHHO6
         LP++cvqm0vB/+u3ScsBZUA4s4HsfVN3pHR9EwbMdIOV+R16Xli/vrWQWY2RV1ucVwugn
         iBBOmqgsKu7ED9Cq+puW1RDPUi7P0fqFOtalQ1cV9rTe9fgEcnN9SrjlB2okMbAS+eho
         I9DQ==
X-Received: by 10.182.230.135 with SMTP id sy7mr1064760obc.24.1381895897642;
        Tue, 15 Oct 2013 20:58:17 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id hl3sm57502625obb.0.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 15 Oct 2013 20:58:16 -0700 (PDT)
In-Reply-To: <xmqqy55ub1ud.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236230>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > It seems[1] that some
> > people define "ci" as "commit -a", and some people define "st" as
> > "status -s" or even "status -sb".
> 
> These option variants aside.
> 
> Just like thinking that committing must be the same as publishing,
> it is a cvs/svn induced braindamage to think that "checking in" must
> be the same as "committing".  The former is a sign of not
> understanding the "distributed", the latter "the index".
> 
> In a world with both check-in and commit as two words usable to
> denote possibly different concepts, it may make sense to say "you
> check-in the current status of the working tree files into the
> index, in order to make commits out of it later".

Yet a wide amount of users do use 'ci' to mean 'commit', so basically they are
just wrong. So you are saying they are just ignorant.

Personally I don't care if it's 'ci', or 'co', or 'cm', or 'ct'. I just
want/need a shortcut, then I can train my fingers to type that.

If you have a better alias than 'ci', then by all means, throw away your
suggestion.

Now, if you are commenting on the aliases, that would mean you are not against
the idea of aliaes per se, but more about values of those aliases. So if we
agreed on the right values, you would welcome this patch.

Is that correct?

-- 
Felipe Contreras
