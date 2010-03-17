From: Michael Witten <mfwitten@gmail.com>
Subject: Re: [PATCH] Clarification for the command "git checkout <branch>"
Date: Wed, 17 Mar 2010 13:50:15 -0500
Message-ID: <b4087cc51003171150g303cf1c0uf2e0227594eef3fc@mail.gmail.com>
References: <4B67227A.7030908@web.de> <4B898F97.90706@web.de> 
	<7vr5o6s5xf.fsf@alter.siamese.dyndns.org> <4B8B9BF1.10408@web.de> 
	<4b8bf32f.0706c00a.26cb.691d@mx.google.com> <4BA104C7.5020207@web.de> 
	<32541b131003170944w7a0215frcace205f32d313bf@mail.gmail.com> 
	<7vaau6q18q.fsf@alter.siamese.dyndns.org> <4BA11D8C.5020007@web.de> 
	<7v8w9qkd5z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 17 19:50:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NryKI-0003Vi-Mh
	for gcvg-git-2@lo.gmane.org; Wed, 17 Mar 2010 19:50:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755540Ab0CQSuh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 14:50:37 -0400
Received: from mail-fx0-f219.google.com ([209.85.220.219]:47929 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab0CQSuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Mar 2010 14:50:37 -0400
Received: by fxm19 with SMTP id 19so1397832fxm.21
        for <git@vger.kernel.org>; Wed, 17 Mar 2010 11:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=lgxOyKcXvcPfjQr3xpnvC2ZcLAzW6IDZmVHBfAS+FT4=;
        b=kzB996Nm4gzinZ+MnAcrplk16YKoggIElr2sPVckYyzkBHDozd3fq08kbVmfBuTHfn
         5rkuRLdTfriCoOWIGWYddHpCFh8YZ/d/gE0hc16yykBSqRyPV7cnT1qjDr0z3s841wMf
         42rAImEZXzsWJID5PwqQSnW8HSMAp88EWsmbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=uvHVker5kmqsVG/RyH0NZSINyXdvvNsv8KsI6U0aN24/LPuqoVRbGfGLimKTVOSUw8
         QOhm8RUnbpaBNdlOESj5LCYMOHv7ntYAz62/V3NTovYmPZksDTdSn+pRvlaYvqakQVFC
         rcY78jEOl4H5clzA4GFl5Bpp9scEF725tP+N0=
Received: by 10.239.132.204 with SMTP id 12mr833734hbs.128.1268851835116; Wed, 
	17 Mar 2010 11:50:35 -0700 (PDT)
In-Reply-To: <7v8w9qkd5z.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142428>

On Wed, Mar 17, 2010 at 13:37, Junio C Hamano <gitster@pobox.com> wrote:
> such local changes may conflict with the change
> made between A and B, and stops the command.

I'm sensing that it needs to be clarified what a conflict is.
