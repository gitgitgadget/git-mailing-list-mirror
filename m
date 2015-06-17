From: Junio C Hamano <gitster@pobox.com>
Subject: Re: co-authoring commits
Date: Wed, 17 Jun 2015 15:44:03 -0700
Message-ID: <xmqq381q551o.fsf@gitster.dls.corp.google.com>
References: <CAOvwQ4i_HL7XGnxZrVu3oSnsbnTyxbg8Vh6vzi4c1isSrrexYQ@mail.gmail.com>
	<xmqq4mm66r99.fsf@gitster.dls.corp.google.com>
	<CAOvwQ4j2bjR1jnLVyZbw1OCE=xQxbCEFGKcK1bpuv1K3s_Y2EQ@mail.gmail.com>
	<20150617205931.GB24079@cloud>
	<xmqqegla57hl.fsf@gitster.dls.corp.google.com>
	<20150617222828.GB24438@cloud>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: josh@joshtriplett.org
X-From: git-owner@vger.kernel.org Thu Jun 18 00:45:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5M5A-00048M-Ju
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 00:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752837AbbFQWpL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 18:45:11 -0400
Received: from mail-ie0-f179.google.com ([209.85.223.179]:36458 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751947AbbFQWoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 18:44:05 -0400
Received: by iecrd14 with SMTP id rd14so43810415iec.3
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 15:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/JhcC/ZK90VOgZoSP9CV7JO06R7Q2x4c9Sqe6Cg/rFw=;
        b=BY1+nHwxxk/z65+eIhdluY3nNoFBas47Jl25FzOxuvwFuwYSRx5B6+/B0z4k7uXkyd
         1eywXqqAws7nfbh01gi8f0gGCy7dGvCB+w2qgbnvgYfWdAReKyccH2D27RlXqUBzHG+Q
         2ibMGu/I+UT4zrC/FZvb2ca+dMAx6R7kLcDqhSYSArxI4MK3Wjn3TK8fBYmPpnavSEWy
         Lsh3qgsug9n3Ylbx5fNzy8AxHfs9wYBDokg4iyoB1Xfd8FrJIPAqmB8wcRloycQhnCrt
         XacsCe+MzL+L8d0NsiHy0hhwuGecqrxSkZbHN0mjnzTwKaduUbAbn4+jmUWxWduvkzm1
         v5Uw==
X-Received: by 10.42.153.137 with SMTP id m9mr2746333icw.56.1434581045011;
        Wed, 17 Jun 2015 15:44:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a4d4:8fab:953e:ec65])
        by mx.google.com with ESMTPSA id 140sm3541254ion.16.2015.06.17.15.44.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Jun 2015 15:44:04 -0700 (PDT)
In-Reply-To: <20150617222828.GB24438@cloud> (josh@joshtriplett.org's message
	of "Wed, 17 Jun 2015 15:28:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271925>

josh@joshtriplett.org writes:

> Author and committer are used by many git tools; if they weren't part of
> the object header, they'd need to be part of some pseudo-header with a
> standardized format that git can parse.

Yes, the same goes to the address on Signed-off-by: footers.  There
recently was a series to enhance the footer list handling (Christian
Cc'ed) for the generation and maintenance side, and I do think it is
reasonable to further add enhanced support for footers.

That does not argue for having a new "coauthor" as a new commit
object header at all, though.
