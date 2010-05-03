From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] diff: add a 'path' meta header for non-renames and 
	non-copies
Date: Mon, 3 May 2010 09:37:51 +0200
Message-ID: <z2m36ca99e91005030037jb880e65w73efa551a53d7be6@mail.gmail.com>
References: <1272852221-14927-1-git-send-email-eli@cloudera.com>
	 <1272868072-12120-1-git-send-email-bert.wesarg@googlemail.com>
	 <7viq75tpaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eli Collins <eli@cloudera.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 03 09:38:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O8qEB-00051C-OY
	for gcvg-git-2@lo.gmane.org; Mon, 03 May 2010 09:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752624Ab0ECHhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 03:37:55 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:43409 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486Ab0ECHhy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 03:37:54 -0400
Received: by bwz19 with SMTP id 19so1125975bwz.21
        for <git@vger.kernel.org>; Mon, 03 May 2010 00:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ocaXpNkDVWpQw5zb/D4pAeBmkBA/o3/UN9Pj8AJ6bMU=;
        b=c3xE8Q4LbpsgMmZ8HQe+6ov6xDpR6mYnM++PXmGFfMhiyBsmtF1l7fFD5SorSJkw//
         p4o//Yr9YxyCFTrQwBMAS45ecUiYmbNZjUvWGKsoRxe+6NOv8ND1HMydDFBrvbvi0xTf
         bq21MH0HLFtj7YEO7W42qoQHZKXqHSpy63nAM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=YHLHWIzCKT3zjILen6/pQSomqYgsH/NxZquRHmTrtX8yXlnRlQ6Udn5tJ4KFXKLeEO
         OC4xM96fjYkCzKJKQBrt+n9kVT/lsBGeELiZwvVVQ1wc4yCpMSCpSeJp9nYsig31rsqs
         wTZLHa+SGqRBamvmd67vEsm2qHh9y5FYMLvgE=
Received: by 10.204.131.80 with SMTP id w16mr2070512bks.35.1272872272014; Mon, 
	03 May 2010 00:37:52 -0700 (PDT)
Received: by 10.204.121.144 with HTTP; Mon, 3 May 2010 00:37:51 -0700 (PDT)
In-Reply-To: <7viq75tpaw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146220>

On Mon, May 3, 2010 at 09:30, Junio C Hamano <gitster@pobox.com> wrote:
> Sorry, but none of these configuration variables are acceptable as-is.
>
> Many scripts (the ones shipped with core-git, in contrib, or written by
> users) depend on their invocation of "git diff-*" family without any funny
> command line arguments like --no-prefix nor --src-prefix to produce a
> patch that can be applied without giving a custom -p value to "git apply".
>
> Letting the user break that promise is already bad, and not giving the
> scripts any way to protect themselves from these configuration variables
> by overriding from the command line makes these doubly bad ideas.

As far as I understand git_diff_ui_config() applies only for "git
diff" not for any of the plumping "git diff-*" tools. Also I thought
that these extended headers are exactly there to support arbitrary
meta information. Therefore I think your arguments don't hold for my
'path' extended header, do they?

Thanks,
Bert

>
