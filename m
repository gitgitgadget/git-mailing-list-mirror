From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Wed, 19 Aug 2009 00:48:33 +0200
Message-ID: <40aa078e0908181548t5df05b1ct8013b99ea703ebba@mail.gmail.com>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>
	 <1250600335-8642-1-git-send-email-mstormo@gmail.com>
	 <7vtz05dq0p.fsf@alter.siamese.dyndns.org> <4A8AE7C5.7050600@gmail.com>
	 <4A8AED8B.9080604@gmail.com>
	 <alpine.DEB.1.00.0908182349220.8306@pacific.mpi-cbg.de>
	 <40aa078e0908181502v32cbd223xcde1cd363dc76345@mail.gmail.com>
	 <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	"Johan 't Hart" <johanthart@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 19 00:48:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdXTv-0000WS-9f
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 00:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbZHRWsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 18:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbZHRWsd
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 18:48:33 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:58338 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbZHRWsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 18:48:32 -0400
Received: by ywh3 with SMTP id 3so5681661ywh.22
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 15:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=yrC9vF9YE207bcrKsPpZJao4p0c1DxcxgLu+ikDZLv8=;
        b=ZjdeKt7fCWrP33M0CsNoOEazkwJIVmkIUTonzWgz5pERIFyEajxiLDb8tU9Pl1owJN
         Mbf1aNCUg0sZzJ20CBZohAc3GntKA5f7tk0Fr1+o+uC+hRFOx6LTmURkWfSUNEb/erly
         zR4giFsqP155QFL57crkAxYh6PbtGjef31JX0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m0NpCnm1DqUC6qnyfINb9PE1bBP4Kkg6z+wsXZqAyRZ1PU3W7mAgivbuXcJDvAddOJ
         dKtqsj7/BvdVAnJU4Mk0aj3f1x13Ub7QGYyPBKninEm9iFT/VVY8gDhtNrDez1w8bGhS
         FfYElrfjdQlC9i+FCWMC/q9IXJpPreEhMmx/0=
Received: by 10.91.122.11 with SMTP id z11mr69044agm.111.1250635713598; Tue, 
	18 Aug 2009 15:48:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908190038110.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126479>

On Wed, Aug 19, 2009 at 12:38 AM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> Nope, you're still able to skip through the erros (with F4) as ususal.
>> I've been using a sed-script to translate gcc-style errors to msvc-style
>> errors for makefile projects before with great success. In this case,
>> the errors are already in msvc-style, so that part should really not be
>> any issue.
>
> At this point you are just piling work-around on work-around.

At what point? This works out of the box for makefile projects that
use msvc for compilation. Sure, for my gcc-setup, yeah. But how is
that being a stack of work-arounds relevant in this context?

I'm not arguing either way here - I'm perfectly happy to stick with MinGW.

I'm just saying that one of the problems you pointed out is not really
a problem. The rest of them sounds like very much like real problems
to me - not particularly big issues, you're the one who just said that
perfect is the enemy of the good, no? ;)

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
