From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 17:24:47 +0200
Message-ID: <94a0d4530902140724m72fdb47bt7fead5dc22733299@mail.gmail.com>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de>
	 <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com>
	 <20090214152155.GD3887@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 14 16:26:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYMPK-0000yl-PS
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 16:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbZBNPYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 10:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751342AbZBNPYv
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 10:24:51 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:55076 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbZBNPYu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 10:24:50 -0500
Received: by fg-out-1718.google.com with SMTP id 16so55226fgg.17
        for <git@vger.kernel.org>; Sat, 14 Feb 2009 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+8e4Z0Ovvt2tKEWiv3qgXCLwCbJycm+G3Dt8OiP8OvI=;
        b=fzygOOew/294e8dLxhnPRTHVy5SSLpIYijUJ/o4J2NUuzY1UGLnuRPjTz5FKfxuVrc
         7wAiw+SwSk6SPFm+FOURf5Q2scXFDEG5Auvruv9+G0gmgNbRu5vidwrgtwuaRVazwtXG
         UNtcZxvM+4tDCLtbgFLODlXhTKavs0OMD12P8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mRk1BmVFkZQJytPGh0QnNpYhI+7AfjbtcELpC6U0Pn1MYA4gcIgWkNppj7GyXI52UQ
         4q8Z2wZdb3EPqt3q1VNsim57bJx6nO/GtEM+43E6zIH+p9TfLAWbBPj6YeXmaSAcBN+r
         pxqOGNnUFBvbAbv0TM2uJc9jE/PTKhWfRytps=
Received: by 10.86.33.10 with SMTP id g10mr371668fgg.44.1234625088011; Sat, 14 
	Feb 2009 07:24:48 -0800 (PST)
In-Reply-To: <20090214152155.GD3887@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109875>

On Sat, Feb 14, 2009 at 5:21 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Feb 14, 2009 at 02:03:09PM +0200, Felipe Contreras wrote:
>
>> Reorganizing the code to use parseopt as suggested by Johannes
>> Schindelin.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>  builtin-config.c |  370 ++++++++++++++++++++++++++---------------------------
>>  1 files changed, 182 insertions(+), 188 deletions(-)
>
> What is this built on top of? I get very large conflicts applying it on
> top of Junio's "master".

By mistake I used a dirty master branch, but it should apply on top of 'pu'.

-- 
Felipe Contreras
