From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 20:51:35 +0200
Message-ID: <81b0412b0908011151p7206226fi8bea97c7b2c5f876@mail.gmail.com>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>
	 <4A714F5C.70000@eaglescrag.net>
	 <81b0412b0908010043y51680392r69a0090aba520b13@mail.gmail.com>
	 <87tz0rinrv.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog19@eaglescrag.net>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Sat Aug 01 20:51:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXJgG-0006uc-5p
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 20:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752076AbZHASvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 14:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752046AbZHASvg
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 14:51:36 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:50175 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbZHASvg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 14:51:36 -0400
Received: by bwz19 with SMTP id 19so1746443bwz.37
        for <git@vger.kernel.org>; Sat, 01 Aug 2009 11:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/DLbh7swEDe0t4HNZ/SWL7aWQKy41nzFgx620znVfbE=;
        b=RIJgA0i8tj7kIw61UH7hOCebyAngBBdi8PQvRn+LD25bkbXMTkyn6PbzduN3jtYZqv
         RdjtlC5SfVSoYtDbCoh6hELl0wtsxHwDUZuO5TmwTPxZciuFT0K/ao9hOMmIEwv/fxCM
         xwTqmYas1/5LOkgKpPYaSYTyfncJOepGHEQLc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jkS1ZXsWvO7OkwdswpfIpX+QJoEbS4KG+Hd2nBebuiSMIyLHmtucuJvYXsdE2dJf3m
         tjOnqLxlXSBwSRJyF7rr2Ww4YkgUkuNKJQZsJCQFLXWQbhhrUiZg7zQAvW2t/Il5hR6E
         XTgxGrm+Q4vTxSZrO5bk5mMSQeGKWEgvGjTCM=
Received: by 10.204.112.12 with SMTP id u12mr4924917bkp.159.1249152695648; 
	Sat, 01 Aug 2009 11:51:35 -0700 (PDT)
In-Reply-To: <87tz0rinrv.fsf@meyering.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124644>

On Sat, Aug 1, 2009 at 16:58, Jim Meyering<jim@meyering.net> wrote:
> Alex Riesen wrote:
>> And it is not in current stable distributions. Exotic thing.
>
> XZ is young, but worthy, imho.
> It was added to Fedora 11 in the last few days.

Well, then maybe we should do by its good example and
support xz. In addition to .lzma, .7z, .cpio, etc.
