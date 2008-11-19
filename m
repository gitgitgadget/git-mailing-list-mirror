From: "rae l" <crquan@gmail.com>
Subject: Re: [RFC] On how to manage tags fetched from remote?
Date: Wed, 19 Nov 2008 12:03:58 +0800
Message-ID: <91b13c310811182003o451c8222kc336aea7ed6eeb6@mail.gmail.com>
References: <91b13c310811181827y4e37815egaa34ba164d9f4269@mail.gmail.com>
	 <7vzljwsads.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 19 05:07:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2eLk-0003kE-TR
	for gcvg-git-2@gmane.org; Wed, 19 Nov 2008 05:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751483AbYKSEED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 23:04:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbYKSEEC
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 23:04:02 -0500
Received: from fk-out-0910.google.com ([209.85.128.190]:59409 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbYKSEEA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 23:04:00 -0500
Received: by fk-out-0910.google.com with SMTP id 18so3746844fkq.5
        for <git@vger.kernel.org>; Tue, 18 Nov 2008 20:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=mbTn9nt4OcDppY9qGr0rcKs12WSfddD2g7QfRAVSbxY=;
        b=rprmx+ra0vTHcbFQgYi5z7rQ6jHW4lzJSRQE4Cjr1ClxkK/VQyykXfwO9z93XywRj9
         bQR6/F6TDNoQrIGr8KB3EvYAK4+usknylfBPaOkv2Fx4S65ZRw0YTw94eqwcuInARA4I
         A0XrESG64XsE2UITk3KuQTGHbhqH78fqAbvDw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=HbEBTsj6nUylrcJk6EY2hV5v3m0EvsW9N95Uu5nfkkUTjocrkIelwQKDVfFX8MgVBc
         cynB/yeYXvWcaQCdOKItKusqyQ6zFIfiZue9CFih/aumsfVt0lMvb9Lp+0raCePoPFNV
         fRTuHKHl3htw0shnLVf/ZerKfbdZyElxA4LPU=
Received: by 10.103.221.5 with SMTP id y5mr216943muq.66.1227067438661;
        Tue, 18 Nov 2008 20:03:58 -0800 (PST)
Received: by 10.103.191.7 with HTTP; Tue, 18 Nov 2008 20:03:58 -0800 (PST)
In-Reply-To: <7vzljwsads.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101313>

On Wed, Nov 19, 2008 at 10:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Slurping very many (possibly unrelated) projects into one repository is
No. They are all kernel development related. You know the linux kernel
has many subsystem,
from http://git.kernel.org/, hundreds of repos, most are kernel
development related.
Every subsystem has a single maintainer git repository, with linus's
git repos is the center,
So if one want to track the kernel development, he needs to track many repo.

The kernel is in developing at a very high speed, so always complex
and different than other projbects.

> your choice (I wouldn't comment if it is a sane choice -- I do not have
> time to ponder the pros and cons.  If it suits your needs, that's good
> enough) If you do not want tags from some repositories but do want from
> some others copied to that repository, per remote configuration feature is
> exactly how it was designed to be used.

I think this is a good idea for me and I will implement it. Thanks for review.

-- 
Cheng Renquan, Shenzhen, China
Lily Tomlin  - "The trouble with the rat race is that even if you win,
you're still a rat."
