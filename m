From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Fix for normalization of foreign idents
Date: Mon, 23 Aug 2010 17:33:21 -0500
Message-ID: <20100823223321.GE1308@burratino>
References: <1282599032-11369-1-git-send-email-marcus@mc.pp.se>
 <20100823213531.GD2120@burratino>
 <yf97hjhrol5.fsf@chiyo.mc.pp.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Marcus Comstedt <marcus@mc.pp.se>
X-From: git-owner@vger.kernel.org Tue Aug 24 00:35:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Onfbh-0000mZ-Hg
	for gcvg-git-2@lo.gmane.org; Tue, 24 Aug 2010 00:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753268Ab0HWWfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 18:35:04 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53029 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751760Ab0HWWfD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 18:35:03 -0400
Received: by qyk9 with SMTP id 9so3152863qyk.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8jNzl1kqQYw/0+7kpcGoZv9J95k70nO4dQAaTvs8YiI=;
        b=IcUi+u6JMMKhGL2WC+XW0AHbbxNPgBJbxfSpJHYtm7pXxUIeO18Dm5cBcwxTUUhRN7
         cNUFmRKbVRecAFxM9poDnZxcmoMBvtLCHhTFdVCOZSd8G7q0eJLT1zhS4aC59d/Psd4L
         Y/0Tt/eDF4oJOMFEZIz6dKhbHaW5IXDRfshnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=VIKRM4LDjh4yM1bAp3z0RD+hP0GBX7B3tBnMYX9LIKeloVrP77H5kbxIBTvvIaJ+YW
         9DBYB6saSD+xssua6VKr2piq66p67DoRo5xVG1vmfLYnuiy+snsED8rUu1ZPoEPGCU6e
         bnZOZmmDqPKBMoOH6zF5n2iTYPEdLnHy2yboA=
Received: by 10.224.60.213 with SMTP id q21mr2308250qah.108.1282602901823;
        Mon, 23 Aug 2010 15:35:01 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t24sm7640668qcs.23.2010.08.23.15.35.00
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 15:35:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <yf97hjhrol5.fsf@chiyo.mc.pp.se>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154265>

Marcus Comstedt wrote:

> it sounds like much more of a
> hassle to actually use.  Do you have a use case in mind where you have
> the ident attribute on a file but do _not_ want a new ident each time
> you commit a change to the file?

No, I don't use the $Id$ feature at all and if I inherited a codebase
with a bunch of foreign $Id$ tags, I don't know what I'd do. :)  So I
can trust your judgement on this.
