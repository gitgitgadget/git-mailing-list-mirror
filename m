From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC] Add --create-cache to repack
Date: Fri, 28 Jan 2011 14:15:30 -0500
Message-ID: <AANLkTi=f34Q2VUrzA0dEG0KCFcHcd_Yq=UN6RSDPVS+p@mail.gmail.com>
References: <1296201984-24426-1-git-send-email-spearce@spearce.org>
 <4D42878E.2020502@viscovery.net> <AANLkTim+AUY9SdeAFfkny2_a3qQ9SCDLUHR3s9Q3M98u@mail.gmail.com>
 <4D42E1E3.4060808@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Hawley <warthog19@eaglescrag.net>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Jan 28 20:16:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pitnr-0003Qv-7b
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 20:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755224Ab1A1TQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jan 2011 14:16:03 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56076 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754360Ab1A1TQB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jan 2011 14:16:01 -0500
Received: by iwn9 with SMTP id 9so3403014iwn.19
        for <git@vger.kernel.org>; Fri, 28 Jan 2011 11:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=UJoJeGQdfqvT639l+GZDyHOuztE1qF8SM4tzfLKZZ5M=;
        b=opUTzbBawhdae9YeypmEAxHyOUR8/eQ8aqFo8seizVV6xpLw9SZbfLyLC4Yu3R+rxv
         ps7TR5gbqPCvft94QjFBBPldV9JfZh5xif3p9ZB43evMTMjXWudgIQX6EbdP+Ll5nCz2
         LW3fqr111fYBhM+ffsvsu5jmw+LtXvsOjhAqM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=jyvr0jre+k17Rre486TNoafgGeNSDimrUw77WLUR1QUnGSd94TR3e3ON/2MRYFSb4/
         YN+qki5L4ikU5aeZtx97ffWWpvhy3R6GYV3aDCC4FAm9M00iaHXPlFA6KVPerzSJ9uEE
         LDULSiG6yS563ugTFZjNiOEdYt9U3NffibKKQ=
Received: by 10.231.207.71 with SMTP id fx7mr3082304ibb.127.1296242160549;
 Fri, 28 Jan 2011 11:16:00 -0800 (PST)
Received: by 10.231.30.65 with HTTP; Fri, 28 Jan 2011 11:15:30 -0800 (PST)
In-Reply-To: <4D42E1E3.4060808@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165635>

On Fri, Jan 28, 2011 at 10:33 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Let's define a ref hierarchy, refs/cache-pack, that names the cache pack
> tips. A cache pack would be generated for each ref found in that
> hierarchy. Then these commits are under user control even on github,
> because you can just push the refs. Junio would perhaps choose a release
> tag, and corresponding commits in the man and html histories. The choice
> would not be completely automatic, though.

This is just for bare repos, right? Why not just use HEAD?

j.
