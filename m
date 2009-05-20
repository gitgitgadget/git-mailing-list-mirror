From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 20:08:19 +0200
Message-ID: <fabb9a1e0905201108q3939ebdm9bf60a344319daef@mail.gmail.com>
References: <4A136C40.6020808@workspacewhiz.com> <20090520032139.GB10212@coredump.intra.peff.net> 
	<alpine.LFD.2.00.0905192328310.3906@xanadu.home> <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> 
	<alpine.LFD.2.00.0905200853010.3906@xanadu.home> <96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com> 
	<alpine.LFD.2.00.0905201144040.3906@xanadu.home> <fabb9a1e0905200913u5252973aia9a20983b20243d3@mail.gmail.com> 
	<20090520165854.GA23031@coredump.intra.peff.net> <alpine.LFD.2.00.0905201358000.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 20 20:08:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6qDg-0007a7-QD
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 20:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755079AbZETSIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 14:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754893AbZETSIk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 14:08:40 -0400
Received: from fk-out-0910.google.com ([209.85.128.185]:1988 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167AbZETSIj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 14:08:39 -0400
Received: by fk-out-0910.google.com with SMTP id 18so276132fkq.5
        for <git@vger.kernel.org>; Wed, 20 May 2009 11:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=v3ZTUpZQxjs+t/Wkk/qAlmhWBdjkTTLU5FeF85ItURk=;
        b=aJgWLl3CAGWr0OPjB0DbBFJr/F7AOCLz0xe5sVd/9jE8c0FO7Y6t5VGSKFpa4EZXig
         d4WRVnq/za9UPvpAaBagdNRseVyK85aygEQJc6H9j1YBYDl+u7zX4+TMBChQsU9i5QPm
         FXGsjA20GpCUR6wdp/XNI8c9o2FF0k00jBV24=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mQUPwl7N00mFYnRQctNgScsjrRy/l7iqfzcfhMeyu6W0kttIbScQQD/iPSADqbx1oa
         AHSdsfp/Frk54MM32/voI66JyKDxAM15UgX89uv29VZ/fjtTb7qi41Xaa+3fJUDI42Lq
         f4A01EWlrRY4woWVnavCxXQQOtz2BuMfauufo=
Received: by 10.103.198.20 with SMTP id a20mr878111muq.29.1242842920111; Wed, 
	20 May 2009 11:08:40 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.0905201358000.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119625>

Heya,

On Wed, May 20, 2009 at 20:04, Nicolas Pitre <nico@cam.org> wrote:
> Even simpler (for the user) would be to create a full commit with a
> synthetic message.

FWIW, I really like this idea, and it would automagically put the
'trash reflog' into the reach of git's
awesome-cherry-pick-and-the-like-commit-handling powers.

-- 
Cheers,

Sverre Rabbelier
