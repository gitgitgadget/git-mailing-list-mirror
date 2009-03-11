From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Tue, 10 Mar 2009 21:57:25 -0400
Message-ID: <76718490903101857v1b5825a6l145b6bcc51743325@mail.gmail.com>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
	 <20090310175233.GA26351@sigill.intra.peff.net>
	 <20090310220400.GA9612@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 02:58:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhDii-00088h-CR
	for gcvg-git-2@gmane.org; Wed, 11 Mar 2009 02:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752085AbZCKB52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 21:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752008AbZCKB52
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 21:57:28 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:55516 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbZCKB51 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Mar 2009 21:57:27 -0400
Received: by rv-out-0506.google.com with SMTP id g37so2498490rvb.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2009 18:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=OxdckWrqGz56IB3iX84r2WD1kteIWr0Lh+9bq78NUlY=;
        b=mQ55fF7Qr+AoOVeIxcOvwS1huOIQ9WqJjT/YTo6A/SRmMhr4O+rcuRd4zArNAfO3d7
         nQ1VpXWQM+W0VbsoKUF5EoLUE76Y7k9jaacRujQyEb24jZd1rtA8Z8+EMb/gjZ4lBPRw
         8T2SYBuOb9g/kn2HpSqWXREvAoKygZYCODfyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=q22t0Pf4Xrvu6uYnRBrMme/pzc/RqkqfCD5/8ewYeDDNtxlAl9T0zwepGigR9Pb/lG
         LYWq1ESynbsrJZ9hQJ9dr2UcrBp0eS0YTPGxXBiSSWrp3ROQ0ZGXtKwtNn4Zf70Lj/z4
         +Zz07ANhgFp+i3g4yRh7VkVVW+L+FQUYU2BLI=
Received: by 10.141.113.3 with SMTP id q3mr4081598rvm.12.1236736645853; Tue, 
	10 Mar 2009 18:57:25 -0700 (PDT)
In-Reply-To: <20090310220400.GA9612@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112868>

On Tue, Mar 10, 2009 at 6:04 PM, Finn Arne Gangstad <finnag@pvv.org> wrote:
> --current pushs the current branch to whatever it is tracking, no
> matter what name it has (i.e. it can push to a branch of different
> name). If it is not tracking anything, it will not push.

I think the option is definitely misnamed then. If it survives the
list feedback, it should probably be called something like --tracked.

j.
