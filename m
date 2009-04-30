From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: git svn errors out with git-cat-file "usage" message
Date: Thu, 30 Apr 2009 11:42:31 +0200
Message-ID: <46a038f90904300242u38dc5968h2c4b551af463ba8b@mail.gmail.com>
References: <46a038f90904290811p33332bd5h1d397734907ba9c2@mail.gmail.com>
	 <32541b130904291150k75a0433fnb29ea59f654a17f7@mail.gmail.com>
	 <49F8B7D1.2090903@drmicha.warpmail.net>
	 <46a038f90904291347i2ed158aaya7505e1bd11cd392@mail.gmail.com>
	 <49F8C127.4000400@drmicha.warpmail.net>
	 <46a038f90904300018u7101943blef084dc907a04c8d@mail.gmail.com>
	 <46a038f90904300153v22aa3e9fo407ff5084b58b5fc@mail.gmail.com>
	 <49F96F2A.5020108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mihai Sucan <mihai.sucan@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 11:42:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzSn0-0003JI-Mi
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 11:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758157AbZD3Jme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 05:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754088AbZD3Jme
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 05:42:34 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:38124 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757733AbZD3Jmd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 05:42:33 -0400
Received: by fxm2 with SMTP id 2so1697374fxm.37
        for <git@vger.kernel.org>; Thu, 30 Apr 2009 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=puKD5LmrdJO/E74/4gjH7xgLehZiFxDawxq5Ln7za4w=;
        b=hY7zvMs91Ak11t9Smcu6pDB7jes5SRHvS3DgnV9JK7++tgXOPZuj7LLV2cAFQswTAf
         9n8ud4BrPpsEyWKYFzA0C7Fl1yL5z/f+P+h9aX4ncS39D/6F+HWCnnQvLDbdS52Up62a
         XkDSxLGYVv0BFosKKUlBhSOe95DRmnS5GFEUc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gjJAPkL9Km8O8uR/ns4DVRQowxTRWhzE1a0JcXLpSixpNY8sNEV4frwYG1MtHMwi6s
         KTzt+aKZh3px0ANSt8BfTRZfG4k/QbiEE6uqvG9lFFuPSL6RBi9MeUwNDmk8kI4KTt7C
         pjLbLn9o1t8w6r3axyR7thygWfo/K9vniAwmE=
Received: by 10.204.59.76 with SMTP id k12mr1257899bkh.136.1241084551929; Thu, 
	30 Apr 2009 02:42:31 -0700 (PDT)
In-Reply-To: <49F96F2A.5020108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118010>

On Thu, Apr 30, 2009 at 11:28 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> That one is definitely not from a newer git. What do you do in between
> the two steps above and below, where the same command "git version"
> returns different results? You must have some older parts lying around
> somewhere, whether they get picked up by on old or new git svn or Git.pm.

I just do 'git checkout <version I want> && make && make install'.

See
$ which git-cat-file
$ which git
/home/martin/bin/git
$ git --exec-path
/home/martin/libexec/git-core

I can't see anything suspicious in my install.

$ find / -name git-cat-file 2>/dev/null
/home/martin/libexec/git-core/git-cat-file
/home/martin/src/git/git-cat-file
/usr/share/doc/mercurial/examples/git-viz/git-cat-file

cheers,




m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
