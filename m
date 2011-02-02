From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/2] fast-import: introduce "feature notes" command
Date: Wed, 2 Feb 2011 14:22:59 -0600
Message-ID: <20110202202259.GA21138@elie>
References: <20110202045826.GC15285@elie>
 <20110202050735.GE15285@elie>
 <201102022047.55152.trast@student.ethz.ch>
 <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sam Vilain <sam@vilain.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 21:23:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkjEk-0005EU-NM
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 21:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1BBUX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 15:23:29 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:48870 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377Ab1BBUX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 15:23:29 -0500
Received: by qwa26 with SMTP id 26so373983qwa.19
        for <git@vger.kernel.org>; Wed, 02 Feb 2011 12:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TicGwjThfAJJw3XKpJxCDOc1hUGTdCvHxEuF//L/Nos=;
        b=EBFOSH8jSXQgNQvjuPRT8HEyjHdh+CvXXA544Uq0nnZi5zF2DcYAJYO8e4rEpznlT0
         b8VQWtvDG58EituO5kIpIxKjsMn9IziN5IflltwTriqEVHjBYpx9T5T0Wv97jPeXvVtI
         W8Bm/KmPPbKEeW9e99vmCCjPXyM0oDUxaleb0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=fq+gpF8SG+maPlkD0li88WS3TzfiyEBENAdqPOk117H/9LeettYeM539WVuLlYvkeS
         mp05TNaNTiMl188kbXn4M0tVGy1IBKzWzZEhZCqBBdraNGiJ5x96iXsWHBDGsT3sTkvG
         Qg5L8o5v+G9Ps5mSox9D3MMhH8kQ9Jdwi2WnI=
Received: by 10.229.250.9 with SMTP id mm9mr6665099qcb.264.1296678208512;
        Wed, 02 Feb 2011 12:23:28 -0800 (PST)
Received: from elie (adsl-76-206-235-233.dsl.chcgil.sbcglobal.net [76.206.235.233])
        by mx.google.com with ESMTPS id e29sm4842qck.15.2011.02.02.12.23.25
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 02 Feb 2011 12:23:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=bEi6J3wcex8JCowU6PRt3BKix5v67v8Ds-MN2@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165935>

Sverre Rabbelier wrote:

> Perhaps we can submit a patch to maint to have it (the
> oldest git that supports the 'feature' command) recognize 'feature
> notes' though?

Smart idea.  My concerns would evaporate.

[v1.7.0-rc0~95^2~4 (2009-12-04) is the relevant git.]
