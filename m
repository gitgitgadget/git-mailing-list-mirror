From: Brent Goodrick <bgoodr@gmail.com>
Subject: Re: How do I force git to forget about merging a binary file that is 
	to stay deleted on the target branch?
Date: Sat, 28 Mar 2009 07:29:24 -0700
Message-ID: <e38bce640903280729u4f582a19ydaa70f619a9911e1@mail.gmail.com>
References: <e38bce640903272226l3facf47br9b1849bf708c3881@mail.gmail.com>
	 <20090328192300.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 15:30:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnZYn-0001AD-31
	for gcvg-git-2@gmane.org; Sat, 28 Mar 2009 15:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbZC1O30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Mar 2009 10:29:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbZC1O30
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Mar 2009 10:29:26 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:41884 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbZC1O30 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Mar 2009 10:29:26 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1735131rvb.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2009 07:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/LhdK1MRs0+mNT9ow4BbWONf4076oPonUWJRKZn4fU8=;
        b=AhifhFocSYW6AmNR/pT/Jo21a7SA4V3/Ivw0go3CfkKyZYGVTcnLIzf6hmlF6nFxzb
         VpzTD7rJDUgXajvCTPX+hNh0rFe2BkCMRCZwvgTaP0P9CZY8bcIWXMjZLf/z62ffwWe0
         CnwtejEBGS7RWSBHJ7g5uXF/zs2PShj7M7xOI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BTfUQK6Kj4TJ76LeM8HRDevdv+1q3aAcL3CJu8NJD3aiS3gOAMZS9ByQj9WgHHGV4D
         KkHzIR0Xh/Z4yhh3W6HUlSjxo3W3Ga0IckyHsfXNl5jBibjsxUBGVCSszSn/KQTNFS29
         jzSKbHgvHYBdG4uTiAwxMYrEiA33QuLy/z76o=
Received: by 10.141.12.15 with SMTP id p15mr1708424rvi.43.1238250564197; Sat, 
	28 Mar 2009 07:29:24 -0700 (PDT)
In-Reply-To: <20090328192300.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114958>

On Sat, Mar 28, 2009 at 3:23 AM, Nanako Shiraishi <nanako3@lavabit.com> wrote:
> I think the standard answer is "you don't".

Thanks, but unfortunately, that won't work for me, since I have too
many commits with useful history that would get lost if I started over
and set up the work and home branches that are branched separately off
of master.  Also the "work" fileset and the "home" fileset are 80% the
same; its the 20% that causes me puzzlement each time I want to merge
changes made on one branch onto the other.

bg
