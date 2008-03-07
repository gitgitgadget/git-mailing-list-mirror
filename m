From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH 1/2] renaming quote_path() as quote_path_relative()
Date: Fri, 7 Mar 2008 05:19:38 +0300
Message-ID: <20080307021938.GA5305@dpotapov.dyndns.org>
References: <7vr6en8n7k.fsf@gitster.siamese.dyndns.org> <1204852397-20939-1-git-send-email-dpotapov@gmail.com> <7vve3z5mzh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 03:20:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXSC8-0000vt-9t
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 03:20:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756839AbYCGCTq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 21:19:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756834AbYCGCTq
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 21:19:46 -0500
Received: from fg-out-1718.google.com ([72.14.220.153]:38966 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756766AbYCGCTp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 21:19:45 -0500
Received: by fg-out-1718.google.com with SMTP id e21so249830fga.17
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 18:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        bh=zwozykALGE9AhxKcIrjcDEOIfEJUX7JneVJbDetQMig=;
        b=Lj8Q/qG0zhrPCaHCdMsugU5cpWqHYE2ygrz1Re6AVys5d5M7KfXQ38x41vhtIxM/1Uec6x1SVvvsjXB1VI6aUcyqWp5pLkPVf2LHkzSSmTohk57QzJ7EtQyjiwGYQBKtlP58kzWbwxBHBKivgW8qUI0Dkg/117esMY73NDCh4W0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=Ozon584NZj/Raa/A1u0+qCzUfsEx8QsV7ayKP+OwDeWAFG7PCtvXCtN2twvIdksRrDXixGpgtXLwjhKXi9aZva/AdxX8hBD/wE/oxjnFdeKoaf12qUviCIyt0zKubvMydjxMJpad65uV5SRCGQjmEyA/CRSGn3VMeLQxG+XyuKQ=
Received: by 10.86.72.15 with SMTP id u15mr713788fga.11.1204856382325;
        Thu, 06 Mar 2008 18:19:42 -0800 (PST)
Received: from localhost ( [85.140.168.16])
        by mx.google.com with ESMTPS id 12sm3506004fgg.6.2008.03.06.18.19.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 18:19:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vve3z5mzh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76452>

On Thu, Mar 06, 2008 at 05:41:54PM -0800, Junio C Hamano wrote:
> 
> Hmmm.  Shouldn't the whole path (including the ../ part you add) be
> surrounded by a pair of dq iff quote_c_style() finds that the path needs
> to be quoted?
> 

Yes, I think it is better, and especially so for git-clean output.
I will resend the patch.

Dmitry
