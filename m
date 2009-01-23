From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Merging adjacent deleted lines?
Date: Fri, 23 Jan 2009 10:59:46 -0500
Message-ID: <76718490901230759k25c4d0c9t57c648f3e373c5bb@mail.gmail.com>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
	 <200901222113.31082.robin.rosenberg.lists@dewire.com>
	 <76718490901222318l7c3559ecje4a627fe2ff2ad12@mail.gmail.com>
	 <200901231132.36543.robin.rosenberg.lists@dewire.com>
	 <76718490901230751uef27274sf7b44e6718f861ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan del Strother <maillist@steelskies.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jan 23 17:01:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQOT4-0003mG-Do
	for gcvg-git-2@gmane.org; Fri, 23 Jan 2009 17:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756167AbZAWP7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2009 10:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbZAWP7s
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jan 2009 10:59:48 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:32978 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755992AbZAWP7r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2009 10:59:47 -0500
Received: by rv-out-0506.google.com with SMTP id k40so4761608rvb.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2009 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w5JT9nuc3/OZ0Fn62mCc/Cl/szXXR+geqDIS+nWwiHM=;
        b=Ri84qq/BKGB2X4YpzqQesJ5fJyBHEER33Ju800BvCofd5PsWRxXYqjJabtyTgS+Q42
         JoGZWoE9fl5NG6Tr/nyRRQD9mpbA9DQ3OQbGqUaPkzYWVztRcGqZ99Nb37jya0RaZV2f
         rNWEZCI5MBJZnw/k1GXcekGQ531/Dwg+EHUUo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=w9bp+b3J84Le4vwXc1ciobFvWREvhLvfXF3L9ttlOeRJBONsq85onVlakp5wj2+HT9
         V28ucXFOddmMZ49gRUY3lE/XeRh1wdk59FzWqpse/Tyr35hA06Ky5LC0R0Hz81wrIVYf
         D11SaDCZEeBvU10PVMrV+41dNA0lTbsUxfg08=
Received: by 10.141.210.13 with SMTP id m13mr1141204rvq.181.1232726386694; 
	Fri, 23 Jan 2009 07:59:46 -0800 (PST)
In-Reply-To: <76718490901230751uef27274sf7b44e6718f861ae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106885>

On Fri, Jan 23, 2009 at 10:51 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> opendiff/meld/vimdiff don't show the ancestor directly, but they are
> still using it in order to show how one version differs from the
> ancestor in the left pane, and how the other version differs in the
> right pane.

Hmm, okay. I see that meld/vimdiff are apparently not doing a 3-way
merge. So I guess after all this, I don't have an explanation about
opendiff. It claims to do a 3-way diff and mergetool is passing it the
ancestor as an argument. Sorry for the confusion.

j.
