From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Can I enforce required approval on some files
Date: Wed, 21 Jul 2010 00:42:46 +0000
Message-ID: <AANLkTilWzSU9Uh0QT5CcauXiiBKtkG37To57s6zUxzDK@mail.gmail.com>
References: <AANLkTinQI9eBnwjzPhYHMM8XZ0ODfHJ1qiZJrNWQWUno@mail.gmail.com>
	<m36309n75a.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Dominik Gront <dgront@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 21 02:42:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ObNOf-00045a-RD
	for gcvg-git-2@lo.gmane.org; Wed, 21 Jul 2010 02:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761553Ab0GUAms (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jul 2010 20:42:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:33435 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab0GUAmr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jul 2010 20:42:47 -0400
Received: by iwn7 with SMTP id 7so6234950iwn.19
        for <git@vger.kernel.org>; Tue, 20 Jul 2010 17:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=zvpBQNOLWOnsjK1dLZkgFwtQa8dp+DzFhWOQdqfW/7E=;
        b=aIpDrJb+iX3z3L/BV6JMpyq/1eS3o/e8sVYppdw47fZcMEZBoFSfIndsx3PlkGnicW
         wt7UTBBNpVpxsKq194vMSPCPyPIWGXa4kini2PqMwI0/Cc3uqkHUW1EkA7HXYKklGQRa
         8+xu2qbVAH/qpv1EcVg5QAiO8Uh9qGa47H+Q0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=Tumd5lpREmOOYlBV93lxRT8NLzhN1a4AdLHgLbD1EYBHlO5ReL5GZuVMp8gORfeeQW
         SFBx+9aYjVw4412tyc4iAc0rAFqJxcDkxGYE68gNYBQEJ+ymEoBnv7MwfhIlFxB6GiPJ
         f+wbJvAszc668Wym8FWBgZ0fS6kRN/XXe2jB4=
Received: by 10.231.31.202 with SMTP id z10mr8254580ibc.85.1279672966775; Tue, 
	20 Jul 2010 17:42:46 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 20 Jul 2010 17:42:46 -0700 (PDT)
In-Reply-To: <m36309n75a.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151382>

On Tue, Jul 20, 2010 at 22:03, Jakub Narebski <jnareb@gmail.com> wrote:

> Besides solution mentioned by others, namely integration repository
> with moderator, you can also use patch/commit code review tool such as
> Gerrit (http://code.google.com/p/gerrit/), equivalent of Rietveld for
> Subversion, or Mondrian for Perforce.

There's also the low-tech solution of just telling people to submit
again until their patches don't suck, it works for git.git, and is
attainable when you're not doing a centralized tool.
