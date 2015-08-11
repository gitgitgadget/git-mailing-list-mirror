From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH v2 1/2] refs: refs/worktree/* become per-worktree
Date: Tue, 11 Aug 2015 15:26:28 -0700
Message-ID: <xmqqlhdho417.fsf@gitster.dls.corp.google.com>
References: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
	<xmqqvbclpm3h.fsf@gitster.dls.corp.google.com>
	<1439329355.5283.34.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, pclouds@gmail.com, mhagger@alum.mit.edu,
	Christian Couder <chriscool@tuxfamily.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 00:26:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPI0C-00082v-Pk
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 00:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933085AbbHKW0c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 18:26:32 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33912 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932837AbbHKW0b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 18:26:31 -0400
Received: by pawu10 with SMTP id u10so173131446paw.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 15:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Jw9yVyUGtnqPyHcSBXBCA7KafxEt9vXyDLKpy/WD7jk=;
        b=Ia+QBb1YGBgZQlMsWeHyAjioAhIrC7z0Ah9tu4neU6kpdYNnDq47V246GkAKMPs/O4
         sp1BynEDWgpzKXe3Ve6VnbD3d8e7Jpxn6E7013y11SUioDInH9ce8+UyBQ/9sRmWtaOQ
         Mm/N4MwPt9OlZ9pKKh7HEucOfgvtHvjorxgTLTcDBn3zJ92vDb4CeC9YUFgL1miqmYFh
         UfHDokLQ1TaMhIwRIdYYjbAjDblWcOO8RgDWV45uQf4Is6Ds1M0P1vEs8HBiHW0xFCAe
         R2IcN3On3mCziSdFGKnqTrCVUfNBHIiNXnJ7BHjYamJP1j7krbYs/3oi6kFxMHnxXAkt
         W6oA==
X-Received: by 10.68.68.233 with SMTP id z9mr41920333pbt.140.1439331991432;
        Tue, 11 Aug 2015 15:26:31 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:894d:5945:d51a:995b])
        by smtp.gmail.com with ESMTPSA id oc2sm3910450pdb.45.2015.08.11.15.26.30
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 11 Aug 2015 15:26:30 -0700 (PDT)
In-Reply-To: <1439329355.5283.34.camel@twopensource.com> (David Turner's
	message of "Tue, 11 Aug 2015 17:42:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275737>

David Turner <dturner@twopensource.com> writes:

> What does gitk do that's relevant here?

Ahh, my mistake.  "gitk" spawned from "bisect visualize" is not even
aware of the fact that it is showing the revision ranges delimited
by the bisect references.
