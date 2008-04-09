From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Wed, 9 Apr 2008 16:32:09 -0400
Message-ID: <32541b130804091332g539037d9x7f135a27ec25b888@mail.gmail.com>
References: <20080409101428.GA2637@elte.hu>
	 <20080409145758.GB20874@sigill.intra.peff.net>
	 <20080409200836.GA19248@mithlond>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 09 22:33:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjgzG-000113-AH
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 22:33:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753735AbYDIUcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 16:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753271AbYDIUcM
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 16:32:12 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:63760 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbYDIUcM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 16:32:12 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3498822fkr.5
        for <git@vger.kernel.org>; Wed, 09 Apr 2008 13:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wKC5IA8fQQDu3rLuz68ZLMlXfh4WmcNZMHEk5f1mptw=;
        b=g3jAYv0m3Ey3AoCBeTa84q1XCRwkqtUy+inc+subF4dYoc49kYPzdbV65ZKlHDcvVhTd6PnR9UZNUbHQu8RfPuEFEbZDyXmSWMO9GETGx3FqhnR5pnxkALynwK9ACakWfqw+P6NYgqsLIDVN+p0wwQ19DRHHuc18Dx17UiMpgck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=koNOfEGiHsKRZSQS3pclcHSRYQlUCTf6mIbAZgMRyHGPRcSVFMoUZzJn0pe5KigtPwtac4lNjBybw680HuGm++ddldtcPIdKdfkgNFM1JZXeslrLS2aIoLps5AZ8fgtRw3LAyhP9kk2DSQtPdPCNXCy89jI5mhNJCsGj3XRFbaM=
Received: by 10.82.105.1 with SMTP id d1mr868402buc.88.1207773129713;
        Wed, 09 Apr 2008 13:32:09 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Wed, 9 Apr 2008 13:32:09 -0700 (PDT)
In-Reply-To: <20080409200836.GA19248@mithlond>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79132>

On Wed, Apr 9, 2008 at 4:08 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
>  So would it be any good if "git fetch <URL>" without refpecs would use
>  +refs/heads/*:refs/remotes/<name>/* ? In any case the current behaviour
>  seems quite unfriendly.

But what should <name> be if you didn't provide it by doing
git-remote-add?  I think the lack of an obvious name for them is
exactly why the branch names don't get created automatically.

Avery
