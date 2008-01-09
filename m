From: "Imran M Yousuf" <imyousuf@gmail.com>
Subject: Re: [PATCH] Simplified the invocation of command action in submodule
Date: Wed, 9 Jan 2008 16:06:07 +0600
Message-ID: <7bfdc29a0801090206q61150a37i9a4d778a2d416c32@mail.gmail.com>
References: <1199851140-31853-1-git-send-email-imyousuf@gmail.com>
	 <47848CDD.7050806@viscovery.net>
	 <7bfdc29a0801090151k22d3cd5aqedb0d4860868d4d9@mail.gmail.com>
	 <47849B60.2060000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jan 09 11:06:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCXpW-0007uK-Qu
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 11:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbYAIKGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 05:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752188AbYAIKGK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 05:06:10 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:46721 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024AbYAIKGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 05:06:08 -0500
Received: by fg-out-1718.google.com with SMTP id e21so202078fga.17
        for <git@vger.kernel.org>; Wed, 09 Jan 2008 02:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Vd7DAJouaB6OGuNZQmMvAFsX2/luVYPMAE7xFZ0daN4=;
        b=F8KBViX+y9AS3hU/dtylDfgTPx49s/w1gNPOO/ms/LYZ4Z7pnCSBU/e+Q3xULsFUNXB9W4A8LK4bX/0CZARcU0snPsJhFKNFvHfatbx0G59AeZeUyQHt5bl7/7Z1gQl//HqX0Fu6CQtykFESzJdnAo9pifJdVF2vaAuoRTKYQiI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=w2k85c7pE+J4ZGSxaitWNui2+Qoqb8/gd25DUKi4CbDeLtWdMwPOdVb51p90KZewJCh3AcOereA8NA97Id33nEdCANP4OBWlCNkp6CzCFxt+5hChWgJJfQ2tWAochfKa3nnfGHJj2EAIHwYGlriTIWa8xgZdlqX1tcv0DJgNabc=
Received: by 10.78.168.1 with SMTP id q1mr257980hue.71.1199873167229;
        Wed, 09 Jan 2008 02:06:07 -0800 (PST)
Received: by 10.78.50.5 with HTTP; Wed, 9 Jan 2008 02:06:07 -0800 (PST)
In-Reply-To: <47849B60.2060000@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69976>

On Jan 9, 2008 4:01 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Imran M Yousuf schrieb:
> > On Jan 9, 2008 2:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> >> - Previously, passing --cached to add, init, or update was an error, now
> >> it is not.
> >
> > The usage statement and this behaviour is rather contradicting. The
> > usage says that --cached can be used with all commands; so I am not
> > sure whether using --cached with add should be an error or not. IMHO,
> > if the previous implementation was right than the USAGE has to be
> > changed, and if the previous implementation was incorrect, than if the
> > default command is set to status than current implementation is right.
>
> I prefer that the usage statement lists one line per sub-command with the
> flags that apply only to the sub-command. IOW, a usage statement that
> suggests that a flag applies to all sub-commands when in reality it
> doesn't is bogus, IMHO.
>

I think for this patch I will keep the usage intact and keep the
implementation coherent with the current usage and add a comment in
that place so that if required it can be changed in future.

> -- Hannes
>
>



-- 
Imran M Yousuf
