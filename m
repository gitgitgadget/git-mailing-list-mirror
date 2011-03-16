From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the
 CGI script
Date: Wed, 16 Mar 2011 09:34:20 -0500
Message-ID: <20110316143420.GA15371@elie>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:34:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzro1-00065Z-RW
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753076Ab1CPOe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 10:34:29 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:64573 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928Ab1CPOe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 10:34:28 -0400
Received: by vxi39 with SMTP id 39so1667975vxi.19
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=hJt+QNvIlBOYYR85IgD6vsRGuagY/I04EjN/NwBgE8g=;
        b=oiCwsjlrm6cfASAhb11J8FKfEKfozTXkvBCKtLUCA16bmYIm9P000F1SRmDA4R2cCn
         CL1hF92mcGtCkTDDA0tf1Uuuz3RZdH1zZk32fYSl8XtJr+0RpwbtAhdnVR+mfjxY8xja
         GnZw8YHE9TxaX+WlwVpRnZ3VQ8PIxBwh1zNus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=gcUGtgEFLpq2nCnBdCax1x256PhXk64G+bzWZDXpAP6Qi8XxVTsZ9AzRG4TjXeyGlb
         JxTxtykCpIE57a8QVmBFAz5re3NlCwDGlwXJENOYUs6gFKBhK3J8QcOktxt3hXA9zN/i
         H2HOAQwuUSpMAxvQVXrmEWCm2tGrEJjVc9X+M=
Received: by 10.220.179.132 with SMTP id bq4mr16770vcb.124.1300286067198;
        Wed, 16 Mar 2011 07:34:27 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.ameritech.net [69.209.56.53])
        by mx.google.com with ESMTPS id c4sm365561vcc.30.2011.03.16.07.34.25
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 07:34:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169157>

Hi,

Drew Northup wrote:

> I just upgraded my Gitweb package (I'm testing the EPEL RHEL5 latest;
> I'm not too happy with them tweaking the paths) and as I should have
> expected all of my Gitweb configuration is now gone.

In gitweb/README, I see:

| You can adjust gitweb behaviour using the file specified in `GITWEB_CONFIG`
| (defaults to 'gitweb_config.perl' in the same directory as the CGI), and
| as a fallback `GITWEB_CONFIG_SYSTEM` (defaults to /etc/gitweb.conf).

Hope that helps,
Jonathan
