From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-mergetool: wrap tools with 3 files only to use the BASE file
 instead of MERGED
Date: Thu, 11 Aug 2011 03:49:55 -0500
Message-ID: <20110811084955.GA31233@elie.gateway.2wire.net>
References: <20110810160356.GA32126@ortolo.eu>
 <20110810161211.GC4076@elie.gateway.2wire.net>
 <20110811083835.GA29507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanguy Ortolo <tanguy+debian@ortolo.eu>, git@vger.kernel.org,
	Sebastian Schuberth <sschuberth@gmail.com>,
	Charles Bailey <charles@hashpling.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 11 10:50:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrQxz-00061Q-S0
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 10:50:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228Ab1HKIuG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Aug 2011 04:50:06 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:64304 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754205Ab1HKIuE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2011 04:50:04 -0400
Received: by iye16 with SMTP id 16so893785iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=JewVzwzF7Aw0shUisYmVsDbZFV0jJhXGNWc7ZTw1OZ4=;
        b=v2i3vC2egf32nq+cJDDVtEmOTIZ/G+2zFgSvBlwNqJgvg+pBmNdJ5guwU/SfvltEM3
         bA5Fi2YCq2mMQ/th6WlBHwQcMIjNKa7m0qdTIG66tHQbwe+GP03/b9OStQ782Le0FWCM
         tg0YFTzRSQE/isa5PINg4KVtHCFmZtMFmYUp8=
Received: by 10.231.169.130 with SMTP id z2mr6679440iby.20.1313052603814;
        Thu, 11 Aug 2011 01:50:03 -0700 (PDT)
Received: from elie.gateway.2wire.net (adsl-69-209-69-68.dsl.chcgil.sbcglobal.net [69.209.69.68])
        by mx.google.com with ESMTPS id q4sm1357107ibb.15.2011.08.11.01.50.02
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 01:50:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110811083835.GA29507@gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179092>

David Aguilar wrote:

> I think it sounds like a good thing for certain tools.
> Sebastian mentioned it being fine in ecmerge and bc3.
> xxdiff also lets you specify the output file, so it
> probably wouldn't need it either, I think.

At the risk of taking away the itch for a good feature: meld joined
the crowd of tools with -o to specify an output file in v1.5.0.

 http://thread.gmane.org/gmane.comp.gnome.meld.general/1270
