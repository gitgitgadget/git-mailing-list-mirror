From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Git log can not show history before rename
Date: Fri, 30 Jan 2009 13:49:34 +0100
Message-ID: <adf1fd3d0901300449x7f6a2f5bq920068b46994c92e@mail.gmail.com>
References: <1976ea660901300323n384d3650s3bb5a575accb65d1@mail.gmail.com>
	 <adf1fd3d0901300329y53e46d91xda75799ce1244ddd@mail.gmail.com>
	 <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 13:51:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSsq5-0005py-CI
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 13:51:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752912AbZA3Mth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 07:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752592AbZA3Mth
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 07:49:37 -0500
Received: from mail-ew0-f21.google.com ([209.85.219.21]:56075 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbZA3Mtg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 07:49:36 -0500
Received: by ewy14 with SMTP id 14so757995ewy.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 04:49:34 -0800 (PST)
Received: by 10.103.229.12 with SMTP id g12mr556628mur.87.1233319774313; Fri, 
	30 Jan 2009 04:49:34 -0800 (PST)
In-Reply-To: <1976ea660901300429i6d9b3594m91222314c284d184@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107805>

[Please, don't top post, and quote only what you are replying to]

2009/1/30 Frank Li <lznuaa@gmail.com>:
> Does it conflict with --parents?
> When I use --follow and --parents together,  parents can't rewrite.
> without --follow, parent can rewrite.

I think there are no obvious reasons to conflict and they could work
together, but as Jakub just said, --follow is quite new and only works
well with simple history and simple cases.

Santi
