From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 3/3] cat-file: add --follow-symlinks to --batch
Date: Tue, 12 May 2015 11:43:09 -0700
Message-ID: <xmqqk2wdzlfm.fsf@gitster.dls.corp.google.com>
References: <1431384645-17276-1-git-send-email-dturner@twopensource.com>
	<1431384645-17276-4-git-send-email-dturner@twopensource.com>
	<xmqqoalpzn3s.fsf@gitster.dls.corp.google.com>
	<1431455779.16652.20.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 12 20:43:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsF9G-0002Vt-Gr
	for gcvg-git-2@plane.gmane.org; Tue, 12 May 2015 20:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933801AbbELSnN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 14:43:13 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35585 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932870AbbELSnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 14:43:11 -0400
Received: by igbyr2 with SMTP id yr2so117083239igb.0
        for <git@vger.kernel.org>; Tue, 12 May 2015 11:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=7oEyj5uqLP33MCMMEUyH25GSZNlA9g8NBjlEb9A1m0w=;
        b=ynWYdX03ceAKY6BOlc81W9Se9yLvWxCSMRXpmDvEy9pKGXxtGcXx0m3ThcX/Ily76i
         XJ9B7S2TA4eK6ZpecMqOXGV4Ao/yoKJcHgtGQJcyPe7FKMkDLbL5W+OkesKbIWDj4Cgh
         zyNyAPSUDGJWYQB/8W6fW8QRj3N455hSbcetC5BNV5Gi6Ou3DIIr8CZ1Lk9aC+4nVknk
         I6rn2Qy2TIpuh/7OM+WhS+HPjUT3bDsXG79XwxzVDsrAuneEm3wgTxyKWNZPDceCq4zB
         nOrqYkInHvEGB13aW7p4zBTfCPSBI6qFAKLpFRYVR2nKxq5ne67j8w6XjrUP4Xui4rYB
         wn9Q==
X-Received: by 10.107.3.106 with SMTP id 103mr2608729iod.60.1431456190747;
        Tue, 12 May 2015 11:43:10 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d41:fac7:b879:7542])
        by mx.google.com with ESMTPSA id o21sm12439137ioo.31.2015.05.12.11.43.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 12 May 2015 11:43:10 -0700 (PDT)
In-Reply-To: <1431455779.16652.20.camel@ubuntu> (David Turner's message of
	"Tue, 12 May 2015 14:36:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268869>

David Turner <dturner@twopensource.com> writes:

>> We need to also say something about the "missing" vs "loop" case, if
>> we choose to leave that part broken.  I'd rather see it fixed, but
>> that is not a very strong preference.
>
> Will add an example.

I do not think we need an example.  By "also say", I meant in
addition to "This and that does not currently work", we also need to
say that loops do not work well.  In other words, it is enough to
just mention that it is a current limitation (or a bug, whichever we
choose to call) that loops are reported as missing.

Thanks.
