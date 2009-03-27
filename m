From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: On git 1.6 (novice's opinion)
Date: Fri, 27 Mar 2009 15:24:37 +0300
Message-ID: <37fcd2780903270524y39456c5fre0a2f8f9c5f4d160@mail.gmail.com>
References: <49CC8C90.12268.242CEFCE@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
	 <20090327090554.5d6160f2@pc09.procura.nl>
	 <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "H.Merijn Brand" <h.m.brand@xs4all.nl>, git@vger.kernel.org
To: Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
X-From: git-owner@vger.kernel.org Fri Mar 27 13:26:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnB8W-000898-4U
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 13:26:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbZC0MYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2009 08:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752689AbZC0MYk
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 08:24:40 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:35334 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbZC0MYk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 08:24:40 -0400
Received: by fxm2 with SMTP id 2so997311fxm.37
        for <git@vger.kernel.org>; Fri, 27 Mar 2009 05:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PsFEA1C5ezvOy1jvmFU3K0XL0abVF3ctNaecK0xPsfk=;
        b=CMV0h/sw2u2s72Axyb4YSTJ/18RXm6DLNI1CRLsQGNJ3c4CueIhmhEwOiCxk+n+zUS
         7GHB3NcQo7PAhsJt20y+LzPVquejLPQFPchcI5B5PfVP72VxypMJ1s6ZFvYDnmgtuqkB
         Oa9ecB0o3dTMSge0/FDoyt0x1seWOWYqc6U3M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Fk9QWKSmwLVxz5rKEBiCczTPRH1Mw7wRMLmAknyPhfHNSktvNrus/kVM3vbrC0IDIl
         +lXDFDYjOJ+N8sWhQyyQQP+T3vyEYdib/+FWtuKrxJgNXrmbPmeWFiW9anR1DDcXfFPw
         wYxWxI/nNm8vEEhw2hZ9E9psjke5VkW85jVMU=
Received: by 10.86.79.19 with SMTP id c19mr429401fgb.13.1238156677590; Fri, 27 
	Mar 2009 05:24:37 -0700 (PDT)
In-Reply-To: <49CCAF5D.21814.24B4DE63@Ulrich.Windl.rkdvmks1.ngate.uni-regensburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114884>

On Fri, Mar 27, 2009 at 12:50 PM, Ulrich Windl
<ulrich.windl@rz.uni-regensburg.de> wrote:
>
> what made me wonder is this (about item 1): I thought I've read that blobs store
> content and attributes, so very obviously I wondered why not store thr "right
> attributes" (i.e. the time of the file). My reasoning: You make some changes, then
> test them (which might last several hours or days). The if I'm happy I'll
> "commit".

With Git, you usually commit your changes immediately (without waiting
the result
of testing), because you can always undo commit until you publish your changes.


Dmitry
