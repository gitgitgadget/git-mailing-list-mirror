From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Difference between 'git rebase' and 'git rebase -m'
Date: Tue, 16 Nov 2010 12:27:49 -0600
Message-ID: <20101116182749.GC14552@burratino>
References: <4CE2C0ED.1030309@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Bash <bash@genarts.com>
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 19:28:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIQGg-00007h-AK
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 19:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab0KPS23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 13:28:29 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:57115 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755869Ab0KPS22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 13:28:28 -0500
Received: by pwi2 with SMTP id 2so23893pwi.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 10:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=TuR4iN3gPGbsU+3jLfXBAxgoLb0cGq+TDbEPBiE+cFk=;
        b=ovJMn/dz0JjZu8FGv9Eshw/4m/CmmH03zfMcc04H/tWlLo/F6k8tuXiHTHAkoZp2mN
         YGXrGAihzOrz4JxMjkff4PH7v3zmztwnNqD6IGwsQ0dETu2lAg0wAJIi5tOgMZ8XdpC3
         GU4xqshjkhrqZJ3yxFDe4HdgGu31SMGM8HBqo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=OACqLJHZJ4SguLNjrU6AdpeO0nwL40F3639xRm7k6fFp3ddZooQmcP3d+MDqdiRZnU
         57qf4kXndFu62rKwWLnlYh92qUl2ZZhVHtqYNWTAdCzM6u4aWh7qaZh2rEBNCU5vB6Fv
         5epMzZ67v4cDUjVoKFGDer8ljMMqJxqzStrcg=
Received: by 10.223.81.67 with SMTP id w3mr4374534fak.110.1289932107143;
        Tue, 16 Nov 2010 10:28:27 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id g22sm749852faa.17.2010.11.16.10.28.25
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 10:28:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4CE2C0ED.1030309@workspacewhiz.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161574>

Joshua Jensen wrote:

> I'm curious as to why 'git rebase -m' isn't the default and what the
> real difference is between 'git rebase' and 'git rebase -m'.

git rebase is faster. :)

git rebase works by formatting a patch series and applying it.
git rebase -m uses repeated 3-way merge and should be more robust.
