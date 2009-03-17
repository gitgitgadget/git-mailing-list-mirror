From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: fetch and pull
Date: Wed, 18 Mar 2009 06:31:03 +0900
Message-ID: <20090318063103.6117@nanako3.lavabit.com>
References: <450196A1AAAE4B42A00A8B27A59278E70A2AEF9A@EXCHANGE.trad.tradestation.com>
 <76718490903161303h45e47a8co83159e32ae749352@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A2AF023@EXCHANGE.trad.tradestation.com>
 <76718490903161514ubbdc948o1a0251212fe65fea@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A2AF0A9@EXCHANGE.trad.tradestation.com>
 <76718490903161709v6d8d09f6k17d2fe1a5e56fb03@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A2AF22F@EXCHANGE.trad.tradestation.com>
 <76718490903170921r36843c11y5aac537d53384298@mail.gmail.com>
 <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: John Dlugosz <JDlugosz@TradeStation.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 22:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ljgut-0000Na-91
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 22:33:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755568AbZCQVcC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 17:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755442AbZCQVcB
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 17:32:01 -0400
Received: from karen.lavabit.com ([72.249.41.33]:35901 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755381AbZCQVb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Mar 2009 17:31:58 -0400
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id 3228B11B846;
	Tue, 17 Mar 2009 16:31:56 -0500 (CDT)
Received: from 3365.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id SZSKSZXD6XSF; Tue, 17 Mar 2009 16:31:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=EEsnFRc990rPHzEu+pkGp29/vfdbu6ORNy47+X08SDVS3VXiBqblGceswRQAaLwrXpVexWLcSU/J2mOcm6PvLmI1tV3cZfqerzkcCR8+P17lycyirTMmw6UE3pGGQj00YBlTOqA+32GP6DFMqMBdYZ6pP/0zHEVzQU4Z37kgQVc=;
  h=From:To:Cc:Subject:In-Reply-To:References:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <450196A1AAAE4B42A00A8B27A59278E70A3FC0A5@EXCHANGE.trad.tradestation.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113528>

Quoting John Dlugosz <JDlugosz@TradeStation.com>:

> My concern is that you establish your working state based on the local 'master', only to immediately change it again when the pull updates master.  But that's the way it's supposed to work?
>
> I think the documentation for git-pull might also be garbled from text being of different eras.  "Normally the branch merged is the HEAD of the remote"?  That will be basically random since the last thing the upstream repo user did will control what his HEAD is.

That's how it's supposed to work, and the documentation isn't from a different era, either. Majority of users clone from a central repository and keep pulling to update their clones, and in that kind of setting, HEAD will never change. A HEAD in a bare repository tells people which branch is the primary branch of the project.

I think you are confused because you are thinking that it's typical to pull from a live repository that has a working tree somebody else uses to grow his history, and you are correct that you can't predict which branch HEAD points at at any given moment. But that isn't how a typical workflow uses pull and push between repositories.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
