From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH 1/4] remote: minor code cleanups in preparation for 
	changing "show" output
Date: Fri, 20 Feb 2009 05:50:01 -0500
Message-ID: <76718490902200250t1ba185e3nd71376ef9e13abd3@mail.gmail.com>
References: <1235020471-59982-1-git-send-email-jaysoffian@gmail.com>
	 <1235020471-59982-2-git-send-email-jaysoffian@gmail.com>
	 <7vbpsxh8xa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marc Branchaud <marcnarc@xiplink.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:51:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaSyk-0005sm-21
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 11:51:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754039AbZBTKuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 05:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbZBTKuE
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 05:50:04 -0500
Received: from rv-out-0506.google.com ([209.85.198.239]:20357 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751163AbZBTKuC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 05:50:02 -0500
Received: by rv-out-0506.google.com with SMTP id g37so884926rvb.1
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 02:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MiRHZvKbrZ7fWtNPNFMmZuEOAMq+DkYNaHivgR5J6qs=;
        b=QjXHacgOc/eGrv+g39FjTEz7kUJ6UcTZbXjBfnEC7lKC4wnXKZcYMFbF51Pxg4nv5z
         Qc70GjOibBHlHNf9EGM8o3y3w4LBE7IPeS5TcE3TAv4Q8EfvtqRSeJm++mJByumRI3hh
         Dl4fLEHxIfTqgi6aIEWQGjYDP7M+b8bpaHacQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HnNEQZBPT9kBlwvCfM/njmgY7CLCvpQf1x7u6Ria5EbUSj1/O4Oy0yDglpJscGn64q
         /y+WlRHJmW2h7tUq4QPvTjruXfnCvbNfZhK4sIx2cVjyzYZ6k729uSkBK5RcW12mEg+Z
         B7p6GrqWcIE07Jr3a+0xwO6gbXO8Mmmh8f+mw=
Received: by 10.141.63.11 with SMTP id q11mr368153rvk.60.1235127001903; Fri, 
	20 Feb 2009 02:50:01 -0800 (PST)
In-Reply-To: <7vbpsxh8xa.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110835>

On Fri, Feb 20, 2009 at 2:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> This does too many things in a single patch.
>
> Ideally this would have been four patches for reviewability:

Okay. I'm re-doing 4/4 anyway, so I'll just re-do the series.

j.
