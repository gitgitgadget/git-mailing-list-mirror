From: Dun Peal <dunpealer@gmail.com>
Subject: Re: Inexplicably deteriorating performance of Git repositories on Windows
Date: Tue, 23 Nov 2010 19:59:17 +0000
Message-ID: <AANLkTimky3Ojc5w3PcCoJOs=NMfMpgUWUDcx+ry6h1dF@mail.gmail.com>
References: <AANLkTimTh7ka21inpovM=qqdWs6j2OcPXVsFh_CMiZ7N@mail.gmail.com>
	<AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git ML <git@vger.kernel.org>
To: Wilbert van Dolleweerd <wilbert@arentheym.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 20:59:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKz1Q-00009J-0F
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 20:59:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751058Ab0KWT7T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 14:59:19 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:55300 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750706Ab0KWT7S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 14:59:18 -0500
Received: by qyk11 with SMTP id 11so2658933qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=tY/DoSIbH1XzBsd0IqVLpxUne9qpyF1HaZ8JMuO8B+k=;
        b=sYXvmgIIW+IO0MgbmCnyLmuJuKPzAuXmPlujggdYL4pTOTzsegzbh5E0A5EspqCvvW
         uLfXWpFAyMiUNFkJgdOb+t8fJGgPcr9la4JuwdUlAuNCagNAzgZgLVtF5f/KQKAFETDZ
         KG47wbht9csurWlI7su/wClr6MfCAHdyABCaU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=BhG3FwzXBpVPvBm1MqUFO6ynJuTQHiHBbpDLamh4uXvt3D9DcfDrFMHtslE+bkbv3Q
         wC6XqKMMkwcIoN10aXJeCXPajVkv8l+7xQ1zKMa1YqWeYWJk18oQix5XMCVUH2io3Znp
         WuvNvHHVZ47MYdkopla+QPQe4cUfhWBRDhjeU=
Received: by 10.224.61.6 with SMTP id r6mr4744683qah.104.1290542357595; Tue,
 23 Nov 2010 11:59:17 -0800 (PST)
Received: by 10.220.186.198 with HTTP; Tue, 23 Nov 2010 11:59:17 -0800 (PST)
In-Reply-To: <AANLkTikXkWvHrc7=FjePfX5WyyNF1U=KH2DBCU+CcVu6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162018>

On Tue, Nov 23, 2010 at 7:12 PM, Wilbert van Dolleweerd
<wilbert@arentheym.com> wrote:
> How big is your repository? We're using some fairly big repositories
> over here but I haven't seen this behavior with the latest version of
> msysgit.

The working copy totals about 4GB. The .git directory, tightly packed, is 1GB.

.D
