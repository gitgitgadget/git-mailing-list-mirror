From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Merging adjacent deleted lines?
Date: Fri, 23 Jan 2009 02:18:15 -0500
Message-ID: <76718490901222318l7c3559ecje4a627fe2ff2ad12@mail.gmail.com>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
	 <7vy6x4cqq1.fsf@gitster.siamese.dyndns.org>
	 <57518fd10901220257p62b6d1efof97ba3fcf90dbfda@mail.gmail.com>
	 <200901222113.31082.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 08:19:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQGKO-00065Y-Hw
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 08:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752469AbZAWHSS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 02:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752406AbZAWHSR
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 02:18:17 -0500
Received: from rv-out-0506.google.com ([209.85.198.238]:53459 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbZAWHSR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 02:18:17 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4561592rvb.1
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 23:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0gjxkDM8WVLgR7rtnhnSAl+8jvYhH2lzK3YcP4HU7Gc=;
        b=iQGKaoADH/KWkoTu6FAQFWRerx9Wc9+00bcna/pHDURUNKhQm/1Rt/EbGztzA+vyc0
         BmCyTsh+TPJhfUUF3HLbrDX3naMj1OBt1gBL0gxs8+ZWCdQ/Ezucfk5jLmlABlmXJ2eK
         Cw3oLuynRkapMvqVB992ZAeMcVc4fDtKWk6kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ffuI4soWXgUU5p+GgfArvEZVTgG8GzDNRpDK5cijl6YIfdGv75B5A1dxM6Rgk5/4hf
         GvAXpnclarokxtQrEUlBC/D1TWVsROT8CsPWVSAuq6QC6EWTR5cdKQ4X7g2hyyyEXHCU
         ac+BJV68eZnAe6rylQSwO5ea8MpXpnyiwxOug=
Received: by 10.140.157.1 with SMTP id f1mr1092649rve.196.1232695095766; Thu, 
	22 Jan 2009 23:18:15 -0800 (PST)
In-Reply-To: <200901222113.31082.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106847>

On Thu, Jan 22, 2009 at 3:13 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> torsdag 22 januari 2009 11:57:41 skrev Jonathan del Strother:
>> Mmm.  I use opendiff, which is generally ok, but in this case produced
>> a merge looking like this :
>>
>> http://pastie.org/paste/asset/367587/Picture_6.png
>>
>> Which, in my mind, isn't any clearer about the fact that both lines
>> ought to be deleted than the text conflict markers are.  Do any of the
>> other graphical tools present conflicts like that differently?
>
> Try a three-way merge tool instead like, e.g. xxdiff.

opendiff (aka FileMerge) *is* a three-way merge tool. If the
screenshot above is not clear, I'm not sure what would be. The left
pane shows your copy of the file with only line1, line3, and line4.
The right pane shows the other copy, with only line1, line2, and
line4.

The lower pane shows the merge resolution, which currently has the
single conflict highlighted, and is being resolved toward the right.
You can use the Action drop down menu to resolve the conflict one of
five ways: left, right, both (left first), both (right first),
neither. You've currently got "right" selected. The appropriate
resolution is "neither", which keeps neither line3 from the left, nor
line2 from the right.

Shrug.

j.
