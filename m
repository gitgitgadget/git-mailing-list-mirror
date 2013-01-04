From: Adam Spiers <git@adamspiers.org>
Subject: Re: What's cooking in git.git (Jan 2013, #02; Thu, 3)
Date: Fri, 4 Jan 2013 17:23:37 +0000
Message-ID: <CAOkDyE-f-8XZAzWrQgh_DG=fZctqBFXqpog-FSDU_yeXfwWTwA@mail.gmail.com>
References: <7vmwwqvzy4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 04 18:24:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrAzu-0008Ck-PN
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jan 2013 18:23:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121Ab3ADRXk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2013 12:23:40 -0500
Received: from mail-wg0-f53.google.com ([74.125.82.53]:54766 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab3ADRXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2013 12:23:38 -0500
Received: by mail-wg0-f53.google.com with SMTP id fn15so154861wgb.20
        for <git@vger.kernel.org>; Fri, 04 Jan 2013 09:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Ny1vuRb5rhAWN0DUx8ZXJumcA25B/QdrNSOpJP2cMe8=;
        b=G1LjiXFRSsITazTdxCmSSU1be2QRoaoL/xkDldzyFX2od8u3OBhCNtcTVF5O1abBMC
         coN2NSvrGUCZf6/zE/V8TWe21oLn+gpXEkmjF4J5whYfolCbIsJ9PeSMvQyjSLb+rO62
         sokY1iEwiNM8XB3zQ/NivWBPBYsRdasZMbirfeD5JepIfRX9pKXFGimQ7C/+Lm1mwl1B
         o+72qt3siGx8CSu4OTT5iyw3lYXkS1r78cRcP0N+BRmf3BWRyMSxs/fh1qul9hrO7hPx
         Yx3BdFfMRd8RssQv7T9bZ4J9ddJy3zI7RHNSBBc4OR++UMSNwR3+TEU4WEZFYIG9z4hA
         N+RA==
Received: by 10.194.88.98 with SMTP id bf2mr85272220wjb.49.1357320217289; Fri,
 04 Jan 2013 09:23:37 -0800 (PST)
Received: by 10.194.84.97 with HTTP; Fri, 4 Jan 2013 09:23:37 -0800 (PST)
In-Reply-To: <7vmwwqvzy4.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: IndNKQUQney9bXHJCUX56qb7dZ4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212633>

On Thu, Jan 3, 2013 at 7:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> * as/check-ignore (2012-12-28) 19 commits
>  - Add git-check-ignore sub-command
>  - setup.c: document get_pathspec()
>  - pathspec.c: extract new validate_path() for reuse
>  - pathspec.c: move reusable code from builtin/add.c
>  - add.c: remove unused argument from validate_pathspec()
>  - add.c: refactor treat_gitlinks()
>  - dir.c: provide clear_directory() for reclaiming dir_struct memory
>  - dir.c: keep track of where patterns came from
>  - dir.c: use a single struct exclude_list per source of excludes
>  - dir.c: rename free_excludes() to clear_exclude_list()
>  - dir.c: refactor is_path_excluded()
>  - dir.c: refactor is_excluded()
>  - dir.c: refactor is_excluded_from_list()
>  - dir.c: rename excluded() to is_excluded()
>  - dir.c: rename excluded_from_list() to is_excluded_from_list()
>  - dir.c: rename path_excluded() to is_path_excluded()
>  - dir.c: rename cryptic 'which' variable to more consistent name
>  - Improve documentation and comments regarding directory traversal API
>  - api-directory-listing.txt: update to match code
>
>  Rerolled.  The early parts looked mostly fine; we may want to split
>  this into two topics and have the early half graduate sooner.

Sounds good to me.  As already mentioned, I have the v4 series ready
and it addresses all issues already voiced in v3, but I have postponed
submitting it as per your request.  Please let me know when and how to
proceed, thanks!
