From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [PATCH 1/3] Wrap the log text in some nice HTML to highlight the commit message
Date: Fri, 23 Feb 2007 09:03:10 +0100
Message-ID: <e5bfff550702230003o5a24a422h7c52a544318da1d4@mail.gmail.com>
References: <200702172200.13461.andyparkins@gmail.com>
	 <200702172202.25730.andyparkins@gmail.com>
	 <e5bfff550702172325w32f980b3x58b05face97ec7d2@mail.gmail.com>
	 <200702181044.53115.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Andy Parkins" <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 23 09:03:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKVOj-0001io-QL
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 09:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbXBWIDN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 03:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752158AbXBWIDN
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 03:03:13 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:34912 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140AbXBWIDM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 03:03:12 -0500
Received: by ug-out-1314.google.com with SMTP id 44so307131uga
        for <git@vger.kernel.org>; Fri, 23 Feb 2007 00:03:11 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R7+QrNiOU+x1TAdCwH6fa2I3sWGb3uTaYbVh7Uy43X6ePA3cz0FzPyoIO4Cn+wDJACu842vegxF8MiKoDUtaah6L0lEvwIiZcQRovKG8JpCkMKGRl0bpxX6PnTLCyyLXLL1JAqVgfvT55NX2KIdZGPT96WfvPRgt3if02sVnfJo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pXkC1XaLRpdxXf0XdKE8zYBCgWpCVgwXLnQYc6RQ2w/Hqk71lXVFAsJgMqpPa1+OEbCNR6KRn8B0pNHBEZynFw439eZJjB9BWPCWQvqEyEzjIvEcxTTB1Zhqa/30PvZg/7KYelKDJi09QLyGx8euAg2M9KJgLnKADxTShB/8YBs=
Received: by 10.114.183.1 with SMTP id g1mr717177waf.1172217790229;
        Fri, 23 Feb 2007 00:03:10 -0800 (PST)
Received: by 10.114.60.16 with HTTP; Fri, 23 Feb 2007 00:03:10 -0800 (PST)
In-Reply-To: <200702181044.53115.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40421>

On 2/18/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Sunday 2007, February 18, Marco Costalba wrote:
>
> > thanks for your patches, but I can see only this email and the
> > '[PATCH 2/3] Improve default column widths by changing resize modes',
> > I miss body of [PATCH 1/3]  and  [PATCH 3/3].
>
> I think that the mailing list spam filter is objecting because the email
> contains HTML tags.  I'll send the patches to you directly to bypass
> the spam filter.
>
>

Hi Andy,

 I finally apply and pushed your patches to
git://repo.or.cz/qgit4.git, I have to say I really like your fancy
html log message.

Just a couple of notes:

- Font family is set to TYPE_WRITER_FONT, but font size is not taken
into account and seems fixed.

- There are some alignement issues in the header, sometimes author,
date, etc.. are left shifted without a clear reason wasting valuable
screen space.

Here are some snapshots to better clarify the points.

http://digilander.libero.it/mcostalba/andy1.png
http://digilander.libero.it/mcostalba/andy2.png
http://digilander.libero.it/mcostalba/andy3.png

Anyway a nice job.

Thanks
Marco
