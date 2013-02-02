From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools: Enable tortoisemerge to handle filenames with
 spaces with TortoiseGitMerge
Date: Fri, 1 Feb 2013 17:59:57 -0800
Message-ID: <CAJDDKr4L3efzp6eBdTKQxXu8sfvyT91bK6MNh5OhXzWvms8TtQ@mail.gmail.com>
References: <50FBD4AD.2060208@tu-clausthal.de>
	<7v4nibjrg0.fsf@alter.siamese.dyndns.org>
	<50FCFBBB.2080305@tu-clausthal.de>
	<7vfw1qbbr4.fsf@alter.siamese.dyndns.org>
	<5101B0A5.1020308@tu-clausthal.de>
	<51024B02.9020400@tu-clausthal.de>
	<CAJDDKr7eNyJp1ffBYEJaZkmnVWqd0AMpnm1kdjnrrhPtuGNL_w@mail.gmail.com>
	<5102837C.9000608@tu-clausthal.de>
	<7v622l5d87.fsf@alter.siamese.dyndns.org>
	<51032E96.2040209@tu-clausthal.de>
	<CAJDDKr6OhZOitTdDkHWnhVhdAis0U+95xUtaNn6nwkQ-k+bA+w@mail.gmail.com>
	<5104F009.5020606@tu-clausthal.de>
	<7vzjzuwm7s.fsf@alter.siamese.dyndns.org>
	<510C1872.3090304@tu-clausthal.de>
	<CAHGBnuNpHtfnD6D+sji6e1yp2x6iLxjAbawwO6USF2iWW17nuQ@mail.gmail.com>
	<510C229E.2050705@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Sat Feb 02 03:08:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1SWU-0007zp-3r
	for gcvg-git-2@plane.gmane.org; Sat, 02 Feb 2013 03:08:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757370Ab3BBCHo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 21:07:44 -0500
Received: from mail-wg0-f45.google.com ([74.125.82.45]:51660 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757296Ab3BBCHn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 21:07:43 -0500
Received: by mail-wg0-f45.google.com with SMTP id dq12so3273290wgb.0
        for <git@vger.kernel.org>; Fri, 01 Feb 2013 18:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=3AJj/ontQYFcYqR23ZOjsn93H92cs3uITPJ/iXG49VM=;
        b=Bo7r762Jt3mXNjKyGAiLAFPlfEI8Ch0DyjZEM601Sb4TcW2XbuEGhgFnKGz784Ff29
         fa/vL5Faozz6JWypRKmVUZbZvYO93EmrT9b9a14oOI9DZbzQlzV4I3VFKkCe8ruViJbq
         u+5gFj+y7/Y0xR2nRwR6Gq5Aamuf7jQdGaQafgnNxMP7xcYDPnt3Tby3gboh//BeHT+S
         v59hZaBTDoy27tblaQPC/OkKuFAsRwZl0quumCSP1l01ir/O/2pAnIhxvBmu6y/+seck
         qcFnLEDj4yXDJohd0r/YUagIaNtKovZ0hDmnRsiUCJ2bI6aW5iqWpR2dzBBlVfjWzcLC
         N+8Q==
X-Received: by 10.194.240.233 with SMTP id wd9mr24946653wjc.54.1359770397978;
 Fri, 01 Feb 2013 17:59:57 -0800 (PST)
Received: by 10.194.63.9 with HTTP; Fri, 1 Feb 2013 17:59:57 -0800 (PST)
In-Reply-To: <510C229E.2050705@tu-clausthal.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215283>

On Fri, Feb 1, 2013 at 12:16 PM, Sven Strickroth
<sven.strickroth@tu-clausthal.de> wrote:
> TortoiseMerge caused to whole
> argument instead of just the file name to be quoted

s/caused to whole/caused the whole/

I think this commit message is very nice.  Is it too late to replace
the current patch with this one?
-- 
David
