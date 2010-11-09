From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Nov 2010, #01; Tue, 9)
Date: Tue, 9 Nov 2010 14:38:04 -0600
Message-ID: <20101109203804.GA26785@burratino>
References: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 21:38:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFuxb-0003Xj-13
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 21:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753463Ab0KIUiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 15:38:25 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59259 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179Ab0KIUiY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 15:38:24 -0500
Received: by fxm16 with SMTP id 16so5328096fxm.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=l81oC8AQfbsLECuYDTTUCb13ITbpoX9pLHCxiUINKIo=;
        b=LuU2lQFztSKsyAtBnL6L5KXMqlMhqyeuzqo8kNBoMIL3Xc7HLt8dFLSIlFFrfd9wYu
         afQ7D5TX0fFy1t3waxEywvXGlq2G5Q0LVEqPkjR/qX0Om3z6zopvgMUZaN/FflOnT3P0
         eCkVfvG0seUujeNrSxHMgrxEAxYclUCx3FZtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dByPP+aJ4FSRWK7iEgWvG7pSWal0l/GFZz25kdthRzCGEo0mXF/ijTxNIqhERUV20J
         3HVFOB7g19MT2ToDX3H2bNIUFXkiL+4I4AUc0LWiA8JNmO1DUpMwg4uhuQoqX2AzsvF1
         cqE8YO8QE/+jdsFizLyZmK+7CBmxtrrIeafIo=
Received: by 10.223.93.202 with SMTP id w10mr4903407fam.22.1289335103055;
        Tue, 09 Nov 2010 12:38:23 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id y19sm929433fau.17.2010.11.09.12.38.21
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 12:38:22 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vbp5ymfyo.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161072>

Junio C Hamano wrote:

> * jn/cherry-pick-refresh-index (2010-10-31) 1 commit
>  - cherry-pick/revert: transparently refresh index
> 
> Looked Ok; will merge to 'next' soonish.

Thanks for fixing up the tests.  (There's a missing && after
"git clone . copy", but until a checker lands to make sure the
&&s stay, I find it hard to be too worried.)

> * jn/parse-options-extra (2010-10-24) 4 commits
>  - update-index: migrate to parse-options API
>  - setup: save prefix (original cwd relative to toplevel) in startup_info
>  - parse-options: make resuming easier after PARSE_OPT_STOP_AT_NON_OPTION
>  - parse-options: allow git commands to invent new option types
>
> Looked Ok; will merge to 'next' soonish.

I'd like to clean this up along the lines Stephen suggested soon.

> * mm/phrase-remote-tracking (2010-11-02) 10 commits
[...]
> Is everybody happy with this round?

Yes, at least I am.
