From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Running interpret-trailers automatically on each commit?
Date: Fri, 28 Aug 2015 10:06:03 -0700
Message-ID: <xmqqk2sf2vic.fsf@gitster.mtv.corp.google.com>
References: <55E07CB1.0@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 19:06:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVN6T-0005eK-W4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 19:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753254AbbH1RGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 13:06:07 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35183 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207AbbH1RGF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 13:06:05 -0400
Received: by pacdd16 with SMTP id dd16so68375702pac.2
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 10:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=omzrTj/23wG1wjTkkTn8iqU98NbOlOVaSOjAluyN3vg=;
        b=QC51KLa6Eh9keCHfnIrxW2TaipNZFMMjVT8lTEy2Xj45kQaG6/tgHNJ+TWU+GWLdsQ
         LMokluqYK0uirX4EyRbf8oVCcYuj5e7/DVp2bKsbxoHoQkswkfE6AnTyhCTyyzMWB9aN
         m3sp3gtOYivltUd/O6XmlY06UPoiNllGUst2OebC4t4eCxJNBrYEzYeeejMnZz92lJke
         Csev2fnjzsxomYWIPHUJ14XPP+IRV6yZg/5qZyk64AhqgfpgIWkFJo66v9PL0v3kQSDg
         KbeYIs83jlsMUquqZdci+Zc7JAjGRxl4nEbC8WzMz/3wI3Y71eq8KZpC6Et5YoRqQj1U
         aJ/g==
X-Received: by 10.66.162.229 with SMTP id yd5mr17174807pab.102.1440781564977;
        Fri, 28 Aug 2015 10:06:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c919:3f20:8560:5a06])
        by smtp.gmail.com with ESMTPSA id cy10sm6321129pdb.13.2015.08.28.10.06.03
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 28 Aug 2015 10:06:04 -0700 (PDT)
In-Reply-To: <55E07CB1.0@game-point.net> (Jeremy Morton's message of "Fri, 28
	Aug 2015 16:22:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276732>

Jeremy Morton <admin@game-point.net> writes:

> I see that interpret-trailers has been added by default in git
> 2.5.0. However the documentation isn't that great and I can't tell
> whether it gets run automatically when I do a "git commit".  My guess
> is that it doesn't - that you have to set up a hook to get it to run
> each commit.

All correct, except that it happend in 2.2 timeframe.

A new experimental feature is shipped, so that people can gain
experience with it and come up with the best practice in their
hooks, and then laster we may fold the best practice into somewhere
deeper in the system.

We are still in the early "ship an experimental feature to let
people play with it" stage.

Thanks.
