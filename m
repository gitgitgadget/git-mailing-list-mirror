From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 17/18] revert: Don't implictly stomp pending sequencer operation
Date: Wed, 27 Jul 2011 22:36:52 +0530
Message-ID: <CALkWK0=5feCeSnxVYb75vp=FNFd1i4-ujFB-2OHegCjN0hAeDw@mail.gmail.com>
References: <1311736755-24205-1-git-send-email-artagnon@gmail.com>
 <1311736755-24205-18-git-send-email-artagnon@gmail.com> <20110727051947.GL18470@elie>
 <CALkWK0mhAc4TtSzN5DW8OX91QBvosbbKsYfB5QPFy563qg7KRQ@mail.gmail.com> <20110727143346.GD24785@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 27 19:07:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qm7Zn-0006eA-EJ
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jul 2011 19:07:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098Ab1G0RHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jul 2011 13:07:15 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44935 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754914Ab1G0RHN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jul 2011 13:07:13 -0400
Received: by wwe5 with SMTP id 5so1635848wwe.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2011 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=0IYF3c6KhVD3wlJLlcjpHo0QWLFiDMLTMSEzcilMXtA=;
        b=IxR+tlEVoJiP771AlXn+7nwNt9EWJThTw6X9VC2MlTNhUo0hbu1NZ8lT3NfVYIVfgf
         ZCmk0fdAB2yZgY+rsITwzqDGtrlIKddfvqBglcRiQGNHEZ5SDLtpAhj/HoGdik2hXtEP
         +FZ3v9oLJLTp5fGBzn9n7IfXkxsBAnXcDH5Cs=
Received: by 10.216.70.14 with SMTP id o14mr8941wed.111.1311786432112; Wed, 27
 Jul 2011 10:07:12 -0700 (PDT)
Received: by 10.216.70.16 with HTTP; Wed, 27 Jul 2011 10:06:52 -0700 (PDT)
In-Reply-To: <20110727143346.GD24785@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177982>

Hi,

Jonathan Nieder writes:
> Sure, if the advice is quiet (as it is in this case), I suppose there
> is no need to guard it until someone using it complains. :)
>
> I mentioned advice configuration to emphasize that output from running
> git with all "hint:" lines stripped out is supposed to be just as
> sensible as with them, if I understand the purpose of the facility
> correctly.

Ah, I hadn't thought about this so deeply.  Indeed a standalone
"error: Could not create sequencer directory '.git/sequencer'." does
not make much sense to the end user.  Now fix so that the caller
reports the error.
Thanks.

-- Ram
