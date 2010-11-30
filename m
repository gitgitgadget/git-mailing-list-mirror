From: David Barr <david.barr@cordelta.com>
Subject: Re: [PATCH] fixup! fast-import: let importers retrieve blobs
Date: Tue, 30 Nov 2010 11:16:30 +1100
Organization: Cordelta Pty Ltd
Message-ID: <201011301116.30288.david.barr@cordelta.com>
References: <20101128194501.GD19998@burratino> <1291074508-18926-1-git-send-email-david.barr@cordelta.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 02:39:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNFBi-0004qb-K5
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 02:39:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756075Ab0K3BjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 20:39:17 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:56144 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab0K3BjR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 20:39:17 -0500
Received: by gyb11 with SMTP id 11so2434787gyb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 17:39:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=SPC1WCju1RGF5S40JNs4On0czEu3lFonzoQZs2rq0DY=;
        b=woxHd+DoUjIHrr6Fko7AUfeoG1gU1gbGOdSPysmA++nk6n7+6wZVcrqIkcDm2YmSFu
         d/L7sef55JqG8t2fBEmT0wBtUjQVM1qYnn/qxTrjmZLpC2Fg+Ou5JCyjkS2yL6gu0CQH
         T8YGC40lLot0N/QE6nEbMgSODrXqko9L0c2uY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=aETgLf+jDqDk/2+nh3H8ADD5PzMYMjkyVqE8ipGGUagZDRFO4C0vaDXA7H9O+LHMfb
         U/BO6Z/yYlC744Wcoxg6hktaW88WILD39lTK+CjcAs+YfnUDwcw/GyqnNsx6RfgsoAZv
         FD7UhnNzNUQ8CPs5EOZ0nIZ+JbkqjNp8pc+ww=
Received: by 10.90.2.10 with SMTP id 10mr10127384agb.81.1291081156265;
        Mon, 29 Nov 2010 17:39:16 -0800 (PST)
Received: from dba.localnet (mailhost.cordelta.com [119.15.97.146])
        by mx.google.com with ESMTPS id 31sm3613050yhl.30.2010.11.29.17.39.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 17:39:15 -0800 (PST)
User-Agent: KMail/1.13.5 (Linux/2.6.35-23-generic; KDE/4.5.1; x86_64; ; )
In-Reply-To: <1291074508-18926-1-git-send-email-david.barr@cordelta.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162461>

> David Barr wrote:
> 
> [plug two memory leaks in "[PATCH 3/4] fast-import: let importers retr..."]
> >
> > Signed-off-by: David Barr <david.barr@cordelta.com>
> 
> Good eyes, thanks!
> 
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

I only caught it because I was copying and adapting the same bit of code for 
my 'ls' implementation. The svndiff0 implementation taught me to feel nervous
wherever I see STRBUF_INIT ;)

--
David Barr
