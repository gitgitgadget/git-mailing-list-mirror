From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Subject: [PATCH] Push to create
Date: Tue, 3 Mar 2009 03:02:48 -0500
Message-ID: <76718490903030002u5a7babe2k6f26b4cc4b48c9d1@mail.gmail.com>
References: <1235865822-14625-1-git-send-email-gitster@pobox.com>
	 <1235865822-14625-3-git-send-email-gitster@pobox.com>
	 <20090301031609.GA30384@coredump.intra.peff.net>
	 <7v63itbxe7.fsf@gitster.siamese.dyndns.org>
	 <20090301100039.GD4146@coredump.intra.peff.net>
	 <20090301170436.GA14365@spearce.org>
	 <7vwsb7gkvt.fsf_-_@gitster.siamese.dyndns.org>
	 <20090303070937.GB30609@coredump.intra.peff.net>
	 <76718490903022337n79a0c11cw95e80d99cd598d17@mail.gmail.com>
	 <7vtz6bf392.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 03 09:04:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LePbu-0001hI-Aj
	for gcvg-git-2@gmane.org; Tue, 03 Mar 2009 09:04:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753743AbZCCICw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2009 03:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbZCCICv
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Mar 2009 03:02:51 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:20695 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbZCCICu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2009 03:02:50 -0500
Received: by rv-out-0506.google.com with SMTP id g37so2685045rvb.1
        for <git@vger.kernel.org>; Tue, 03 Mar 2009 00:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kTj0oplF0Qmc6pKhVLDOcUrsD4g8tgatclxkl0/cFio=;
        b=CiHLR6/jvwXCP6aZOjEgQ4uxPKTYK/Iv9R0TQF9loy57nQX7b6QdP+nhP1LbKL6VCT
         VcXUhEBEI6g2rdG1ZwFrxRGx2j4/n1jFDNxN5FB3X3LFQ6Mihn2nKsOaJICPZVQDSBZx
         fuiS/nB4T7sdNXQjyP8usq5XZvER9iZPD3D0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dxUM/ZL84Uwu3sOCO9oLZRmU0q4ZNhZ+s6NVv099gqgZP4wlSenEuU1be9IP23PkEU
         fP3QbQXF1lvgmx6Kzh2OlYNyEw80eqW5PhBmiOipJXKPbXR4pntGZP+2ZKMf1/4K8BVo
         /dqkFiqIxw1oBX/r7INutvZDlzkzjwCWi01PU=
Received: by 10.141.29.14 with SMTP id g14mr3381961rvj.150.1236067368436; Tue, 
	03 Mar 2009 00:02:48 -0800 (PST)
In-Reply-To: <7vtz6bf392.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112021>

On Tue, Mar 3, 2009 at 2:56 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> I concur w/Jeff and I think git probably should not as well. I think
>> that instead adding it to init might be interesting
>
> The thing is Jeff and Shawn already rejected that route.

Okay. I missed that, so I'll go search for it, but it still seems like
"init [<path>|ssh://]" should be the basis for "push --init".

j.
