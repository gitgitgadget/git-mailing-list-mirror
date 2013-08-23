From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 15/24] read-cache: read index-v5
Date: Sat, 24 Aug 2013 06:52:57 +0700
Message-ID: <CACsJy8CdEvs1o0-iDbtojLC3tMVXWp64X9zaYy7=LT5cxxN_SQ@mail.gmail.com>
References: <1376854933-31241-1-git-send-email-t.gummerer@gmail.com> <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 24 01:53:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VD1Aa-0003fk-1o
	for gcvg-git-2@plane.gmane.org; Sat, 24 Aug 2013 01:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754792Ab3HWXx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Aug 2013 19:53:28 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:62337 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754678Ab3HWXx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Aug 2013 19:53:27 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so1511590oag.3
        for <git@vger.kernel.org>; Fri, 23 Aug 2013 16:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=pYFyO9LEHQ8YLr60UYG6LruxLLuDMVvyjqS5lzUaWl0=;
        b=ew37zvLdngfmvaQcy2A06IQfPnAl3odlSVj5o2qnyMinOzZ5GtaCr/E0VLa6SRQ6eG
         usIc0Xr6JlFYgmbP9vjlccWHFWUTQd9PrZBvOStMciK0tYk1gMD/GIMEzeYBhYWuGdgl
         qFiSQbb5JOHple49v8NNVUaytvat5JVZAlhpfWdb/60H38c7dTp8bh4y0QgN1XLzYQAG
         9p9M7Obh4MqSIc0foVCEMouNdYYUs1tflyezg09KJWWyZmzKewmyBD8jA5sfn09QdpLX
         z92mMxUSSnmq7MHHReFK7C8+/qho4bds81Bo2YTj6/i8VyFZLqsgcXXnbp5xMvhzyvoF
         HYig==
X-Received: by 10.182.60.194 with SMTP id j2mr1982381obr.2.1377302007285; Fri,
 23 Aug 2013 16:53:27 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Fri, 23 Aug 2013 16:52:57 -0700 (PDT)
In-Reply-To: <1376854933-31241-16-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232841>

Nit, add_part_to_conflict_entry(), create_new_conflict() and related
structures/macros are not used in this patch. The first caller is in
the next patch (read resolve-undo data).
--
Duy
