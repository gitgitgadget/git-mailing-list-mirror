From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Wed, 30 Sep 2009 20:10:32 +0200
Message-ID: <40aa078e0909301110n62ca38e2ma56d9cd38cd0b48a@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <20090914120311.GA17172@sigill.intra.peff.net>
	 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
	 <4AAE4087.5030607@viscovery.net>
	 <40aa078e0909140612w71ad3bdeyfa94838cb57cec19@mail.gmail.com>
	 <4AAE42F2.30304@viscovery.net>
	 <40aa078e0909140626k63b9de2fu8c9411baf8200da6@mail.gmail.com>
	 <4AAE4724.1090705@viscovery.net>
	 <7v1vlyrcef.fsf@alter.siamese.dyndns.org>
	 <40aa078e0909250656j4b791a99naf632b5b8d8e1038@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 20:12:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt3dP-00076G-DF
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 20:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754906AbZI3SK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 14:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754516AbZI3SK3
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 14:10:29 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:55335 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752802AbZI3SK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 14:10:29 -0400
Received: by bwz6 with SMTP id 6so3015750bwz.37
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 11:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=sBAGifPDDMcfaFQhssSYMLGBIsY6GMkrOapp1UfFSEw=;
        b=r5Q8NgP+GNW5k6DOUCpaxFmbFjLxuOp6zkBoQzhGKpesLKqyQ0iyIUi8Zra0f5iEyq
         mME78dOF9UGvqs9UK4+3Nm05KYmXGOtJNwdFI9gSXxPIh4Wv2h6Z9SZZhTQc4cv2bUtb
         ZudXoKVYP1t1zDnw5ruKJOGIPN+hKCpSlON3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kFVTx0E3YmLd/bCWxCcIaPJcEWoIUG8KEoh19QKnMlWDTge4TQUeUPQsMLO+WoH4PC
         64pneDjdhB34IGVmqEknxsFBnrHTyszE6H+kLgjhrh9M2nOLKc6gLvPX+EADGj9/TACd
         VOnwbdju0R+QG641YDgj10W27nN6xeYb3FQgc=
Received: by 10.204.154.150 with SMTP id o22mr81269bkw.154.1254334232052; Wed, 
	30 Sep 2009 11:10:32 -0700 (PDT)
In-Reply-To: <40aa078e0909250656j4b791a99naf632b5b8d8e1038@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129348>

On Fri, Sep 25, 2009 at 3:56 PM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
>> Anything happened to this series?
>
> No, I'm sorry for not updating. I'm currently on vacation, and I
> didn't get time to fix it up before going, due to my dayjob. I'll pick
> it up again as soon as I get back home, in a bit more than a week.

Alright, I fond time to fix this up a little earlier than I expected.
A new round had been sent to the mailing list.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
