From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: please consider remove those tags named master, which is ambigous with master branch
Date: Wed, 24 Sep 2008 17:44:03 +0200
Message-ID: <81b0412b0809240844y42218bedqe0e1eb22c067fcc3@mail.gmail.com>
References: <91b13c310808310948r5e9e825as27bcdf381137e179@mail.gmail.com>
	 <91b13c310809230746o1c2cb694taebc814bea57c8c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Matthias Urlichs" <smurf@smurf.noris.de>,
	"Andrew Morton" <akpm@linux-foundation.org>, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: "rae l" <crquan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:45:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiWYH-0006ED-9f
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbYIXPoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbYIXPoG
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:44:06 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:52462 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYIXPoF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:44:05 -0400
Received: by gxk9 with SMTP id 9so5783408gxk.13
        for <git@vger.kernel.org>; Wed, 24 Sep 2008 08:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=S4xvhaAqXP8CqwVIWccTk/2M9H+Md5WCxMVYMG1k2uM=;
        b=qAvhfcDtE0hRXKp17gBjnn5rtE3CKtp/8kVw+nemjC9YaZzuvdCJU8a8XSPefwcx43
         7zGf2aM8Geik4U2l7lsLpUtsumYeIY9CtCU0vqkZ54dsxr0bNz18tStEtjXq36yoNOQt
         qTNU5gwdueOfgwzHzwaYrph+z9f+Q7RQPUb80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=EhfcFCO7BqgmBX/pvKQPcMCf6iOlUidJUO8G7auCK+TP/hDq22Rp5GFk6sYD24aJ6m
         HwfLKij64DgwIuGMQ9phOivkMSZ/AFvCN/8HQhGdBiCaqPQyrwuyMBZ+dC9SycQ8RAiT
         cNHusFP+AR5IfmxFEWMQgr672vInJWaETGhEo=
Received: by 10.151.10.7 with SMTP id n7mr11230881ybi.139.1222271043192;
        Wed, 24 Sep 2008 08:44:03 -0700 (PDT)
Received: by 10.151.107.13 with HTTP; Wed, 24 Sep 2008 08:44:03 -0700 (PDT)
In-Reply-To: <91b13c310809230746o1c2cb694taebc814bea57c8c5@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96652>

2008/9/23 rae l <crquan@gmail.com>:
> To Git developers:
>  I found that different git subcommand have inconsitent processing
> about ambiguous refname,
>
> git show will take "master" tag first,
> while git tag -v will take "master" branch first,
>
> So what's your suggestion to fix this? Just simple remove ambiguous refnames?

You can use "refs/tags/master" and "refs/heads/master"...
