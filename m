From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH v3 1/2] git-am: emit usage when called w/o arguments and 
	w/o patch on stdin
Date: Wed, 28 Jan 2009 11:40:37 -0500
Message-ID: <76718490901280840g7d36aa96u3d0f98a709ac9fde@mail.gmail.com>
References: <1233154990-19745-1-git-send-email-jaysoffian@gmail.com>
	 <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com, sverre@rabbelier.nl
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Wed Jan 28 17:42:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSDUP-0008WP-Mt
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 17:42:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbZA1Qkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 11:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZA1Qkj
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 11:40:39 -0500
Received: from rv-out-0506.google.com ([209.85.198.232]:25038 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498AbZA1Qki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 11:40:38 -0500
Received: by rv-out-0506.google.com with SMTP id k40so7025856rvb.1
        for <git@vger.kernel.org>; Wed, 28 Jan 2009 08:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2IEheXbQ+Vx+ZyDrUam+QsJoxp2Xxh7x+P+ocqLfD4M=;
        b=sVtx4sTgt+d70TFuri+HP95dW2K58dDEUuMABq3irYP5jijcMkrASogf4v+fJseNYK
         LcYXZJi8mf+ECjrDDaMxZdgPNb3mIKoz26568gw1o4FA+tLJvl4sxEFZCmO75i6Qxits
         4rs6g6bKvwcEqLshoh+I8twsm2UhlHLRzOZoE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=hBZgOS+PMC6FhWmObbYqhxnwcS/ftpRBBXXNdOZM2v55/H+kmQjjWDZ9I469/jHCOO
         R+MXqTOBiZMUVxzMQqulyJSWj0WXviZDZcAANOYReg3xX6m4xTENYG97cN0BWXDha10T
         L4oKyOKm9997/4yuyV9L+5GgvSGpaEZb+Bb9g=
Received: by 10.140.133.10 with SMTP id g10mr5547537rvd.214.1233160837651; 
	Wed, 28 Jan 2009 08:40:37 -0800 (PST)
In-Reply-To: <780A42F8-E27C-404A-945C-38C16378EF57@ai.rug.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107548>

On Wed, Jan 28, 2009 at 11:18 AM, Pieter de Bie <pdebie@ai.rug.nl> wrote:
> FWIW, I sometimes like to run 'git am', paste in a patch and hit ctrl-d.
>
> I can probably retrain my finger to use 'git am -', but I'm not sure if that
> works (after this patch)? At least it's not mentioned in the manpage.

"git am -" doesn't work (before or after this patch), but "cat | git am" will.

j.
