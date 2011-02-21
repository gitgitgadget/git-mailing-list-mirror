From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 02/15] tests: add GETTEXT_POISON to simulate unfriendly
 translator
Date: Mon, 21 Feb 2011 06:58:10 -0600
Message-ID: <20110221125810.GA18427@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
 <20110221101352.GC32137@elie>
 <AANLkTikCvaWOQaE8628RVeAsdizVBr3vHawjwKdVJK5N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 13:58:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrVLM-0004HJ-Lr
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 13:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755708Ab1BUM6T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 07:58:19 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:50084 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598Ab1BUM6S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 07:58:18 -0500
Received: by iyb26 with SMTP id 26so688406iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 04:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=hb98p6saUIN267bOJ/hGO1oYisU/wrqLj9m+hNzCLqY=;
        b=kXYOyjX74SwTxVxyEfO4tfWSDDYzYmKXHocvvpVBHfp13sa/JOD+YRPkLAlKO0FvGn
         jsImYQXt4SFP8CPccVnJ/XZa/mFGzr2Bgq/8C0YD997Cw6rsEKxKYoZsIrrb+oBFKwaX
         ymY5BiioUnPNyRMdzOPhgEF4f98VWXCGIXovw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Qz1PWnpl+g4lp0fe46harx1fo3UGctnVa6bvtF9Bhsjd40mSJqtFSa+ihj7XfiO0jf
         kCBcg6LIVs+BlmXRop1vOFgGKecZzcCUFM/h1/AqJ+tqC5MjhxDp6Ro3/fOankButfMk
         kFvRTq6DQoaBudZRN6Vir9C6CFeC+iDv0xEeg=
Received: by 10.231.30.76 with SMTP id t12mr1118834ibc.163.1298293097389;
        Mon, 21 Feb 2011 04:58:17 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id d21sm5198961ibg.21.2011.02.21.04.58.15
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 04:58:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTikCvaWOQaE8628RVeAsdizVBr3vHawjwKdVJK5N@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167480>

Hi =C3=86var,

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Why did you change this from "# GETTEXT POISON #" to "Malkovich"?

I forgot to mention that change in the cover letter --- thanks for a
reminder.

> Do those tests still pass with this new string, and is there any
> reason to change this?

Yes, all the tests in this series still pass (on this machine, at
least).  Which is why I changed it --- it is a lot easier to explain
having the '#' at the beginning and end of a magic string as part of a
patch that would break tests without that change.

Of course the specific string is arbitrary.  All caps sounds fine to
me, too.

Hope that helps,
Jonathan
