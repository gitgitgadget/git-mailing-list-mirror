From: James Blackburn <jamesblackburn@gmail.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 18:01:25 +0100
Message-ID: <BANLkTi=4S08h=uMV5oo7S9qpruMot2kVfg@mail.gmail.com>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
	<m362o5vrhd.fsf@localhost.localdomain>
	<BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 16 19:01:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXFwi-0002J1-OH
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 19:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753397Ab1FPRB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 13:01:27 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:61581 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab1FPRB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 13:01:26 -0400
Received: by qwk3 with SMTP id 3so777047qwk.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 10:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=YVDe30zET+u+hMrl4/9VF5YjwAcLDhoNvzQQgTzzlbE=;
        b=uL60f/XwlRx5bRMcCRHsBRnL+yEEdF3wR9rtuZWfZuGVgyQx7VTZzLtaI3rttaiW3a
         G8pWHty1pzWiLOEXQACLM1rhePg7MbDtDV9ziBNvRFmbsfDmO0Dnki9Ks3yaJbumADht
         MdWKIEPeyXUs2E+34ed0unQcrWK6yiIioFscA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=YnwcyHz6OIdpvVdFDXWlW5z30L994u1pbHXT4E32dcjnkNCmWlUJiZkyCN+9JIKf61
         hA6kQI79XPw33YXNYdURzVOFIYMH7HyAUCltJjnFbMHdjPOXdJoY+d2CiuoZdZgAWwZ7
         m4oyB67CmhpxI01rsZJQtEt0chGMcXDGs7eQE=
Received: by 10.229.106.69 with SMTP id w5mr1021740qco.41.1308243685729; Thu,
 16 Jun 2011 10:01:25 -0700 (PDT)
Received: by 10.229.214.203 with HTTP; Thu, 16 Jun 2011 10:01:25 -0700 (PDT)
In-Reply-To: <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175903>

I see a lot of this has been discussed before... but just to add that
Jeff's blame-log.sh:
http://git.661346.n2.nabble.com/alternate-log-follow-idea-td1385917.html
seems to work and show the full history of the file past the rename+merge!

I was also interested in whether there's a better way of re-connecting
history than grafting one repository's history into the commit which
made it visible in another?  AFAICS the graft is no different to a
merge commit which contains a rename in the merged node, so I'm
guessing this is a reasonable thing to do?

Cheers,
James
