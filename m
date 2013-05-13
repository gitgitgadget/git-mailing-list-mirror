From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 16:54:11 -0400
Message-ID: <CACPiFC+Ummjj4d7OiZwEW+Xm_uRNU1hre3_6UDKUBTepm7EmqA@mail.gmail.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org> <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com> <20130511061322.GB3394@elie>
 <20130511094119.GA6196@iris.ozlabs.ibm.com> <CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
 <20130513185551.GB3657@google.com> <CAAhxitGFhVa6+8x_rgNz5dgyr6m4S11fVU2eJNnMuWimGiM8aQ@mail.gmail.com>
 <20130513193320.GC3657@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Martin Langhoff <martin@laptop.org>,
	Paul Mackerras <paulus@samba.org>,
	=?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski=2DSzmek?= 
	<zbyszek@in.waw.pl>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 22:54:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubzlm-0007oq-Ln
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 22:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab3EMUyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 16:54:39 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:37554 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab3EMUyj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 16:54:39 -0400
Received: by mail-qe0-f50.google.com with SMTP id k5so3828602qej.23
        for <git@vger.kernel.org>; Mon, 13 May 2013 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=bklGulm5f+ndrOkvr5SjmzPepipvhU3itlF+uxA02DQ=;
        b=AjMAB093mVtFWiUQPOgUeZPmHEPXCe4ZmZZuAJN5oEZbspFzfoMnxS2CSqVeA4aeT1
         OXGtcdrCMj/cJjw+w/0OwnYSIWj+FLcV2OmNYH2YtC0XO28vJt+goID+///uWaxgWpMG
         nMsFCh9/17LstAywrqgNCe6v+KzyL0B0kvthihGF/NetatvJHOBVcEWn6HZrlOpcDWc6
         9BLVzZ7Ub7zgXMkfiHsvvhiuyDuOfc7Llk1eYbGROM/NcDWOm2H1Bpvlr4vuLXNEdRl7
         L8HqtF6/TAwKlkdHAGKKw80HNgxIGt2M+TydH8g09uGNHzSG6/IeC7AhZ7BpUoT9fxfj
         xvbA==
X-Received: by 10.224.188.134 with SMTP id da6mr21991865qab.69.1368478478247;
 Mon, 13 May 2013 13:54:38 -0700 (PDT)
Received: by 10.49.96.201 with HTTP; Mon, 13 May 2013 13:54:11 -0700 (PDT)
In-Reply-To: <20130513193320.GC3657@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224203>

On Mon, May 13, 2013 at 3:33 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Well, no, it should find the final change that brought it into the
> current form.  Just like "git blame".
>
> Has it been finding zero results in some cases where the current code
> matches the pattern?  That sounds like a bug.

Ummm, maybe. You are right, with current git it does work as I would
expect (usefully ;-) ).

I know I struggled quite a bit with log -S not finding stuff I thought
it should and that log -G did find, back a year ago.

Damn, I don't have a precise record of what git it was on, nor a good
repro example. Too long ago,



m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
