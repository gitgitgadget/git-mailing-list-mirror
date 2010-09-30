From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/3] Add bidirectional_transfer_loop()
Date: Thu, 30 Sep 2010 10:51:55 -0500
Message-ID: <20100930155155.GI4850@burratino>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1285847579-21954-2-git-send-email-ilari.liusvaara@elisanet.fi>
 <20100930135502.GG4850@burratino>
 <20100930155145.GA23320@LK-Perkele-V2.elisa-laajakaista.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Sep 30 17:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1LTW-0002hb-D8
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 17:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181Ab0I3PzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 11:55:05 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:60260 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932083Ab0I3PzE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 11:55:04 -0400
Received: by fxm4 with SMTP id 4so831933fxm.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 08:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=92NkQN8fw9LoI5qxyuaAGUfHhntF8TxJf7mTs1SFXec=;
        b=lspjjWYl3hHZKJx4kr993Ctus8/n4avlaMuZIl9LaHrTvK/sYLAmFWxisStUMRuENU
         BUVu9LGZKj6BJ1EHxfLhkzPfhR2uLMy5wQwcbdGf5k3A0893zxKzLMIDUezQmeqKXUfs
         ZvddeR16jxcWc2X6w3ScWScCHPJdRj4HI7pXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kelmyIL5lPGYkBvmvcQsKpgILQM+y2hxcA2yP+Yk7wXRBwojQid1X3C+RRCf/jlEsH
         3LJfAL4AwVo2a+ICQz6wclLKOu5OySz8rFSge9g4TyoxRsfFuoU77pZpBE8tDROQsOl9
         lgjEf0OYeyztmdRu96k7lEN2VFMrs38VD0Fr8=
Received: by 10.223.115.13 with SMTP id g13mr4060918faq.9.1285862102329;
        Thu, 30 Sep 2010 08:55:02 -0700 (PDT)
Received: from burratino ([68.255.106.176])
        by mx.google.com with ESMTPS id e17sm4603368faa.39.2010.09.30.08.54.58
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 30 Sep 2010 08:55:00 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100930155145.GA23320@LK-Perkele-V2.elisa-laajakaista.fi>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157683>

Ilari Liusvaara wrote:

> The debugging output is hellishly noisy. I just (successfully) tried to clone
> git repo from local copy. The result was no less than 106 773 debugging
> messages...

Ah, okay.  I suppose there is no need to teach this to share tracing
infrastructure (e.g., generalizing get_trace_fd()) now; that can
be done later if someone decides they need the flexibility.
