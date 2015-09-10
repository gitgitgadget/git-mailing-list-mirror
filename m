From: Junio C Hamano <gitster@pobox.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 11:44:18 -0700
Message-ID: <xmqqvbbi2jy5.fsf@gitster.mtv.corp.google.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
	<xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xq9P2NHqQe-y+2n38ZvbR74UxR0Rik=btgy=JtEoZbX2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:44:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6pe-0007su-Og
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbbIJSoV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:44:21 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33002 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753462AbbIJSoU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:44:20 -0400
Received: by pacex6 with SMTP id ex6so50460207pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 11:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7SSe/khUkASRCC1I4p3C1g5bJ34+O8C71gx/2HTbDWs=;
        b=KRr5D676RoHW4oTTiukA4dQS+Dgu03fr+vMZKHSNRpY+JaRdib09pr1Uu29izkSfKq
         lpyy18QeIj/la8BWRzvGSHppwbiR1B9Fi5EFEzvpijeE1A1P+2iaUXIRkQJeUZygqj27
         in2dY7UKtz9gcQEdEUEvUsufcAyY07Bq1vCGxrQZrx/y+8pAH60X9wQiYPjhA2XnQ8cm
         qVLiZHpPzk8xlNbgNpJ569KsOwhi7YbQOeRJDb4/+kZkDorU3w2u9KrKDE57MS4sYXs8
         OyvOMjoYrvrsNZUWEFAh5UqaSTwpq9owZs2EXLTvs6SVDJOKAjMy0uJYdmyqIYqqmyxN
         swew==
X-Received: by 10.66.219.102 with SMTP id pn6mr76040142pac.80.1441910660037;
        Thu, 10 Sep 2015 11:44:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:8419:5a5:3940:dfa0])
        by smtp.gmail.com with ESMTPSA id iv2sm13346004pbd.88.2015.09.10.11.44.19
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Sep 2015 11:44:19 -0700 (PDT)
In-Reply-To: <CA+P7+xq9P2NHqQe-y+2n38ZvbR74UxR0Rik=btgy=JtEoZbX2A@mail.gmail.com>
	(Jacob Keller's message of "Thu, 10 Sep 2015 11:32:35 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277625>

Jacob Keller <jacob.keller@gmail.com> writes:

> I hadn't thought of separating the cover letter from git-send-email.
> That would be suitable for me.

Yeah, I said this number of times over time, and I said it once
recently in another thread, but I think it was a mistake to allow
git-send-email to drive format-patch.  It may appear that it will
make things convenient in the perfect world where no user makes
mistakes, but people are not perfect in real life.  Expecting them
to be is being naive.
