From: Jonathan Nieder <jrnieder@gmail.com>
Subject: how multiple roots happen (Re: [RFC/PATCH 2/1] fixup! Documentation:
 start to explain what git replace is for)
Date: Fri, 14 Jan 2011 15:09:26 -0600
Message-ID: <20110114210926.GB15286@burratino>
References: <746745466.20110111134101@mail.ru>
 <m3lj2rbmq5.fsf@localhost.localdomain>
 <20110112000812.GA31950@burratino>
 <loom.20110112T232501-316@post.gmane.org>
 <20110114084903.GD11343@burratino>
 <4D308B69.1050003@seznam.cz>
 <20110114193023.GA14294@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Aleksey Shumkin <zapped@mail.ru>
To: Maaartin-1 <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Fri Jan 14 22:10:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdquG-0004o0-M3
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 22:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752592Ab1ANVJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 16:09:50 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:51077 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1ANVJt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 16:09:49 -0500
Received: by vws16 with SMTP id 16so1193261vws.19
        for <git@vger.kernel.org>; Fri, 14 Jan 2011 13:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=bopNqBT/Y+FeRkFv2MtiqLX7zU4KTd2HBdimPhv62Wk=;
        b=MeHFz9UJMLGzZ9ZmhmC7534mqgDU2IsE6udK6tX++2hCS2Nj+Dfnh7vODmAmolufG7
         8e7qhwmCjcf8y9Pw4bhHtzjI5w6X4VlvNQUicSW/nyytyrhjHeLHWkZ/FE9lJOOVKx3P
         MsFJBogB9Y2fNI9TjQCWO/F4e88nV5FWFwvdg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KB9A7nlbQk3oSTFOQf5DvFuxC61P4w4ouTpWwaz9oVppSemBOK8Y7A5oE5d/ydw+4J
         j13xFqC5AAf5swEtDUELbVczBC4l0f0NVNHc8NMU9GtzQn8xGttBR3xQRlevpwNsr8Vx
         VKDyx3W+VN4Ph5MuNoFmhDDC6MeTS3Iw5G/w8=
Received: by 10.220.194.69 with SMTP id dx5mr409563vcb.60.1295039386679;
        Fri, 14 Jan 2011 13:09:46 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id u6sm804361vby.17.2011.01.14.13.09.44
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 14 Jan 2011 13:09:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110114193023.GA14294@burratino>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165123>

Jonathan Nieder wrote:
> Maaartin wrote:

>> Maybe just something like "Let's assume there's only one and let's call
>> it FIRST". For the example, this is enough.
>
> True enough.  Even better would be to give a reference to the "coolest merge
> ever" (is that documented anywhere?) so the interested reader can discover
> how there could be more than one.

Apparently it was not clear what I was talking about (who knew?).  So
here you go:

 http://thread.gmane.org/gmane.comp.version-control.git/5126

For a more modern take on it:

 http://thread.gmane.org/gmane.comp.version-control.git/144302/focus=144323
