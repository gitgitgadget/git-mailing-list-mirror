From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH v3 07/23] git_remote_helpers: push all refs during a
 non-local export
Date: Sat, 23 Jul 2011 13:27:44 +0200
Message-ID: <CAGdFq_g7OQjsCka16=O6vA9CfyDjEtmxfzEs7S6f8Za0kVQ3nw@mail.gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
 <1310821424-4750-8-git-send-email-srabbelier@gmail.com> <7vzkkcxyxa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
	Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 23 13:28:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkaNh-0006L7-Fj
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 13:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab1GWL2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jul 2011 07:28:25 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:35070 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab1GWL2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jul 2011 07:28:24 -0400
Received: by pzk37 with SMTP id 37so5105924pzk.1
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 04:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=i1mVRkesUrGZK5r8tSPpIdpnNBxtmagNRn4SLGMLZ3c=;
        b=fYrbjH0Xdwtti97OYmmcy1o/yMil7Nx9f87YqtIaeX0rxT2WBr34CaTkXx8TAGJ5LG
         Lrausw1hvjvFP4NuyDi9pP+g1RbycAUOzh1zN4a42MQoas6+GoaeKRgde2yku0hB4lhl
         OxFnq2vhtDROOzzJPsDHH6o7VL9IjznUc3I2I=
Received: by 10.68.10.202 with SMTP id k10mr3824058pbb.511.1311420504056; Sat,
 23 Jul 2011 04:28:24 -0700 (PDT)
Received: by 10.68.71.162 with HTTP; Sat, 23 Jul 2011 04:27:44 -0700 (PDT)
In-Reply-To: <7vzkkcxyxa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177687>

Heya,

On Mon, Jul 18, 2011 at 01:36, Junio C Hamano <gitster@pobox.com> wrote:
> There used to be "This does not deal with forced (not-fast-forward) pushes."
> at the end of the message, no?

Yes it did, not sure what happened to that. FIxed.

-- 
Cheers,

Sverre Rabbelier
