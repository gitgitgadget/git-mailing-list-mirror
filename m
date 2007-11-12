From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 23:46:32 +0800
Message-ID: <46dff0320711120746s1258f31eh9bf676acedb10dc6@mail.gmail.com>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>
	 <fh9rv5$g06$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:46:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrbUw-0002vj-G5
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 16:46:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758901AbXKLPqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 10:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758871AbXKLPqe
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 10:46:34 -0500
Received: from py-out-1112.google.com ([64.233.166.183]:62092 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758862AbXKLPqd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 10:46:33 -0500
Received: by py-out-1112.google.com with SMTP id u77so1298296pyb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 07:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=RkUuGSDEYak2Qrdn/iI+kA/P3DeUZJg9duAcrhe9t6A=;
        b=mrNG5UIyPcxeolPg400OfrttcvvXWmxPDBmvdjnrksmtDFDAUp2+XQgripll6wrjwG4Y+GzRJJFDsVjAV5voxRIgWL62U5BFrhWbwF3FE2Su5b8tkfZfNF0nYjY364wEPbRsfrekiHdcN/ItGHrQGCAFU4/KJWB+06RackJ/vi0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hkanyw5UISZqItVB/OkfBXMDmzf13KRZZpgtZZZyraPqElLY8J1RmaVagxykFI0EyuqfvJQXrERAEdKSKcabuWEeb+HSYzxvzCzp9VSRPX+2GPPGDlPqRiWA1NWtIEzl38krBE+2g4X5tlA5bKl2Xz0KfnpygH1TDdPQygDhSb4=
Received: by 10.35.132.9 with SMTP id j9mr2193169pyn.1194882392682;
        Mon, 12 Nov 2007 07:46:32 -0800 (PST)
Received: by 10.35.108.1 with HTTP; Mon, 12 Nov 2007 07:46:32 -0800 (PST)
In-Reply-To: <fh9rv5$g06$1@ger.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64642>

On Nov 12, 2007 11:37 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> Ping Yin wrote:
>
> > ---
> > Documentation/git-commit.txt | 10 +++++
> > Documentation/git-status.txt | 3 +
> > git-commit.sh | 90 ++++++++++++++++++++++++++++++++++++++++--
> > 3 files changed, 99 insertions(+), 4 deletions(-)
>
> Shouldn't you also modify Documentation/config.txt ?
Oh, I'll supplement later
>
> --
> Jakub Narebski
> Warsaw, Poland
> ShadeHawk on #git
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
Ping Yin
