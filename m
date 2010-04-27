From: Dmitrijs Ledkovs <dmitrij.ledkov@ubuntu.com>
Subject: Re: create branch from svn repos
Date: Wed, 28 Apr 2010 00:25:19 +0100
Message-ID: <n2v86ecb3c71004271625r4f546c93v394c211f6beb27@mail.gmail.com>
References: <j2h93552bad1004271359q63611fcdn82a3915a3bb74b25@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Ming Zhang <blackmagic02881@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 28 01:25:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6u9y-0003V7-7l
	for gcvg-git-2@lo.gmane.org; Wed, 28 Apr 2010 01:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab0D0XZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 19:25:40 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:50834 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263Ab0D0XZk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 19:25:40 -0400
Received: by pvb32 with SMTP id 32so113014pvb.19
        for <git@vger.kernel.org>; Tue, 27 Apr 2010 16:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received
         :in-reply-to:references:from:date:x-google-sender-auth:message-id
         :subject:to:cc:content-type;
        bh=CyQcNhD95VEAFf8jYrLLcx3gDXVlpllgAVrdhHnN0rg=;
        b=F3PEEwnNau8gC/rectBJV7LM7RsoI3c9PiTP0Ds2cN6dBpgLwGUhJDQjnFSet1hyAP
         1rO4W3N/EJSh3UeO6qLXK56izeGl3YVO2zixBhG56fJ1+pnBwJyIABI0WOC0kp/lPixk
         xJsAD1DzS/Ohgd9A7vzIn3JaojWM3fAtOh3Ac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type;
        b=U8c2mPFZ284q4GAI2AtdsKJVhqwDSNSVeOxedpyMT20wEiOvFAF8m8KBaefMi6MfzE
         I+AhUbHRqSKd69D3u3UXFbwlAeWY1+ClfX9xWh2ibqjfY2lMfAobo1D974VNlFr7RVn9
         GuUsWVQgKIgjmwsyBCfgXaK8HI3HcoB54IHDU=
Received: by 10.142.56.10 with SMTP id e10mr3498517wfa.156.1272410739079; Tue, 
	27 Apr 2010 16:25:39 -0700 (PDT)
Received: by 10.142.188.15 with HTTP; Tue, 27 Apr 2010 16:25:19 -0700 (PDT)
In-Reply-To: <j2h93552bad1004271359q63611fcdn82a3915a3bb74b25@mail.gmail.com>
X-Google-Sender-Auth: b8fccc21f9fa1896
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145962>

On 27 April 2010 21:59, Ming Zhang <blackmagic02881@gmail.com> wrote:
> fatal: git checkout: updating paths is incompatible with switching
> branches/forcing
> Did you intend to checkout 'svn/dir/b3' which can not be resolved as commit?
>
> so is what i want to do feasible?
>
> Thanks!
>
> Ming

$ git help svn

Read the last bits on how to define svn remote branches in the .git/config
update your .git/config
and do

$ git svn init $same_top_level_svn_url
$ git svn fetch
