From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD] Gitweb: Source configuration from file separate from the
 CGI script
Date: Fri, 18 Mar 2011 12:54:10 -0500
Message-ID: <20110318175311.GA22421@elie>
References: <1300285582.28805.25.camel@drew-northup.unet.maine.edu>
 <m3lj0e59ps.fsf@localhost.localdomain>
 <1300361067.3010.1.camel@drew-northup.unet.maine.edu>
 <201103171641.29021.jnareb@gmail.com>
 <1300457243.12245.13.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Fri Mar 18 18:54:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0dsW-00071F-Bk
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 18:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348Ab1CRRyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 13:54:19 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58815 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130Ab1CRRyS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 13:54:18 -0400
Received: by yxs7 with SMTP id 7so1682407yxs.19
        for <git@vger.kernel.org>; Fri, 18 Mar 2011 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=F3nCtK1GxkO5yrrXNiqjV1SwCdmbzzhZ///QqC3Ol3Y=;
        b=j5JvaRcyABjB5wr6ii6BaJVVToz3EjeXtTpz6bn/oI316FSXsSwltnVXsDPn64NIcF
         A8mt1avsHRt7+2FsWwpUPrYP8T3iOmFmkz/YHRe8uboKLlxE6LBKIzq52FZnLrFFSgoR
         OcRKmCdyh9wn0dL0HoX1Y5h3Ci+pJkCfAX5rY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=spKW2XLRxH/Tvhtd8bYQNfnlnR212berP2KcOoH7VdRce1Uv268LaIcJo5diEC9tRE
         qzJ+PzCBh0AtnslA6dHTS8ViXgX0w8po7DIBBCMyIKGsziKHpbUvqRLsxeq+oOcL9peE
         3W0Prqsiwz4y3gmE/WQtxiYcbECLeMa3WB754=
Received: by 10.101.26.27 with SMTP id d27mr1065133anj.24.1300470857515;
        Fri, 18 Mar 2011 10:54:17 -0700 (PDT)
Received: from elie ([69.209.56.53])
        by mx.google.com with ESMTPS id c18sm310965ana.27.2011.03.18.10.54.15
        (version=SSLv3 cipher=OTHER);
        Fri, 18 Mar 2011 10:54:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1300457243.12245.13.camel@drew-northup.unet.maine.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169343>

Drew Northup wrote:

> At the very least I'm considering making a man page for the
> configuration file. I don't know off-hand how much that will be
> seemingly repetitive of the README, but I suspect I'm not the only one
> who often finds monolithic files tucked away in /usr/share/doc

Yes, please!  I'd say, beyond that: please feel free to replace large
chunks of the README with "See the manpage (or <source file for the
manpage>) for further information.".

Happily,
Jonathan
