From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: git svn fetch crash with fatal error
Date: Thu, 5 Aug 2010 16:12:48 +0000
Message-ID: <AANLkTin20zP0EwaoGWFMavfyFn0b7bFK5ZUt7bJedOSx@mail.gmail.com>
References: <AANLkTine9j=PsfsOPmEWmDLUDrHCJF0MQ6X+6XJkQD0d@mail.gmail.com>
	<0015174c437c389602048ce7f16c@google.com>
	<AANLkTinfebXbQGb2L1nkebdXzi9cfJbHFA-r_DLLNoFf@mail.gmail.com>
	<loom.20100805T170931-389@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Simon Gronlund <simongronlund@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 18:13:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh347-0000oB-4b
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 18:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145Ab0HEQMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 12:12:51 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:47793 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759187Ab0HEQMu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 12:12:50 -0400
Received: by fxm14 with SMTP id 14so3022135fxm.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 09:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=hjj+5hPtF2U4rRI3awSMB3Taw3Bh32T7cADhUbeGKXA=;
        b=bPS03T8weGj1MUrk+nnQS8kZtgujylFdo6BoAMjzu9tuMP8vIKkoJy05v7uxryUuJ0
         95bouTLou5kE92HNPHKssZ8P5PlzpeKrghqPBncD370gL7jiNikSNfdK/DDBooK5xsHU
         TlapVPElkA/ktgH8OMsK8Qvjax8n+Np32G8yw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=j7gKaqTLe3urKYwhwIHqB8BPViFQMgK5Kjzyzd2zOPTSR/gC8BCBixaYL0EdgiZM9H
         ECkwB36oJbAirqMPg3a7c5NPvakrMY1VthUj7c65N+zgr2+MFEjnlK9GSVWwOW0YpfI3
         9aJPUjUfXsJMPkXTSO4Vd61JK95oJjuewo7/s=
Received: by 10.223.105.132 with SMTP id t4mr10941406fao.75.1281024768299; 
	Thu, 05 Aug 2010 09:12:48 -0700 (PDT)
Received: by 10.223.109.195 with HTTP; Thu, 5 Aug 2010 09:12:48 -0700 (PDT)
In-Reply-To: <loom.20100805T170931-389@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152669>

On Thu, Aug 5, 2010 at 15:10, Simon Gronlund <simongronlund@gmail.com> wrote:
> Have I posted this problem to the wrong news group? If so, could a friendly soul
> refer me to the proper location, please.

This is the right group, but:

  * Not many people are familiar with git-svn. You might have to wait
    more than 2 days for a reply.

  * Please post messages as replies to the original thread. Neither of
    your two follow-up messages have In-Reply-To headers to indicate
    what you're referring to.

  * The debug output you have doesn't really help. See "perldoc
    perldebug" for how to produce more useful traces, in particular
    the "t" switch to trace execution.

  * Can you provide the list with a copy of the .git in question so we
    can experiment with it?
