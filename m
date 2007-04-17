From: Michael Spang <mcspang@gmail.com>
Subject: Re: push-hook (on the receiving side)
Date: Mon, 16 Apr 2007 21:13:13 -0400
Message-ID: <46241F29.2010509@gmail.com>
References: <f36b08ee0704161805yd9cbd22ue8af69682979daba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Yakov Lerner <iler.ml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 03:13:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdcG0-0004HD-8s
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 03:13:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031051AbXDQBNR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 21:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031052AbXDQBNR
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 21:13:17 -0400
Received: from an-out-0708.google.com ([209.85.132.246]:15834 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031051AbXDQBNQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 21:13:16 -0400
Received: by an-out-0708.google.com with SMTP id b33so2012087ana
        for <git@vger.kernel.org>; Mon, 16 Apr 2007 18:13:15 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=HisY88hMhkLTAjywLfjSYUa0/zbHx4WbaUXuJ+FmPi+m4uaBlVY9UxR+udPPUqlM13UvJCO1T/YeRjnU2QbaB7oqTfTF5mRA6TSAzrn2EXBzSW7DViPykMGYH4pI6JhpCsif96lN9TLvYavGf5ik18pAhdwPEvJ/THvk6aexb3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AFx+EqpaqEjBfChkK9UI11x88k/FZeUfOXAsbCExCvnvy3iODJFa/h+iUy38NOQLutK2CSydsUrtJOILlZ0mfjJLsGfgsZTu2Q3j3j03RhLKWT6ylHC+NLWSnVJLOuurfprRjpFsjPKpedulh7xuaY+BWunQGjanb524g07d7Co=
Received: by 10.64.3.9 with SMTP id 9mr6622971qbc.1176772394804;
        Mon, 16 Apr 2007 18:13:14 -0700 (PDT)
Received: from ?10.100.100.101? ( [74.108.158.132])
        by mx.google.com with ESMTP id f14sm3077497qba.2007.04.16.18.13.14;
        Mon, 16 Apr 2007 18:13:14 -0700 (PDT)
User-Agent: Icedove 1.5.0.10 (X11/20070329)
In-Reply-To: <f36b08ee0704161805yd9cbd22ue8af69682979daba@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44705>

Yakov Lerner wrote:
> How can I define the push-hook on the receiving side of the
> push, so that some script or command is executed on the
> repo on the receiving side of the push ?
> 
> Thanks
> Yakov
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Yes, receive-pack has hooks for this. See git-receive-pack(1) and hooks.txt.

Cheers,
Michael Spang
