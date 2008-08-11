From: "Reece Dunn" <msclrhd@googlemail.com>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 17:26:04 +0100
Message-ID: <3f4fd2640808110926w13104a08l687c8accc29e332@mail.gmail.com>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
	 <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <38b2ab8a0808110718x2f63608ga3d2d77e317ce4eb@mail.gmail.com>
	 <3f4fd2640808110859r148550d2h833dae05b9e6544e@mail.gmail.com>
	 <38b2ab8a0808110923u21d543f0qbc9dee0f99c97311@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Francis Moreau" <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 18:27:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSaEh-0003nR-Kr
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 18:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751749AbYHKQ0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYHKQ0H
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 12:26:07 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:18443 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbYHKQ0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 12:26:05 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2326481rvb.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2008 09:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=YVOxpOp/tLcGTKpiI72QDbmA6p3DoXPwOmOAGEvWVpI=;
        b=PbzcIRuB804YVgQBhMetGyas5mqmHiI1Zs/ZnfWpE9Mu95jeMT595pHgsbeQlRuOfd
         OXuf+PeROmkXgMbTnS+P8bfcexPPlyE+ivFiugTmsqzTsU0UM2JGSt9KzhaEi6FE4YIz
         gwY99abmB2X0EwbHgE9q84OVK+CGCwP3BRPRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Hm4lo8t1RJQd2Jyadwbw+uUgCYfNZ6eEDFG+ZL9dlqZHNunaus4fmBEa/kJItOWqpN
         iA9IeoB/X1Gr5KpqZ1PykbAE08N1SFIm4kwpyIkfYY6P4aF2MQYJWlkwQjTQkVRdpABI
         owfrxDbZ80KmyKZWnrZd7usNfORyZc0UkZxME=
Received: by 10.141.50.11 with SMTP id c11mr3619301rvk.222.1218471964320;
        Mon, 11 Aug 2008 09:26:04 -0700 (PDT)
Received: by 10.141.87.10 with HTTP; Mon, 11 Aug 2008 09:26:04 -0700 (PDT)
In-Reply-To: <38b2ab8a0808110923u21d543f0qbc9dee0f99c97311@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91958>

2008/8/11 Francis Moreau <francis.moro@gmail.com>:
> On Mon, Aug 11, 2008 at 5:59 PM, Reece Dunn <msclrhd@googlemail.com> wrote:
>> $ $(read yesno) && echo yes || echo no
>> n
>> yes
>> $ $(read yesno) && echo yes || echo no
>> y
>> yes
>
> funny, seeing these 2 cases I'm wondering why Bash is not complaining...

I don't know; it could be an issue with cygwin.

I'll try it on a Linux box later and post the results then for comparison.

- Reece
