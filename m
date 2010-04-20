From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and Very Large Codebases
Date: Tue, 20 Apr 2010 02:46:47 -0700 (PDT)
Message-ID: <m3eiiae9t1.fsf@localhost.localdomain>
References: <s2x4ef15ddc1004200158s2fc6391byfab91784036ac018@mail.gmail.com>
	<h2w4ef15ddc1004200200ocd9df12azf62da7419355ae7c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Brian Herman <brianherman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 20 11:48:02 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4A3i-0007FI-G3
	for gcvg-git-2@lo.gmane.org; Tue, 20 Apr 2010 11:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754288Ab0DTJrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Apr 2010 05:47:53 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:36739 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754275Ab0DTJrw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Apr 2010 05:47:52 -0400
Received: by bwz19 with SMTP id 19so556bwz.21
        for <git@vger.kernel.org>; Tue, 20 Apr 2010 02:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=/uzTTCAQM+/y6oO8MiZwlvUSDF6cbW0vn4oO+JkrkpE=;
        b=CoUMypKNajwA5nIsiHpFbLC616kICvtR9I3ZoyaiS9YaJ0vvlJWWGEBotEwdW0BszQ
         QS6JuVTTtfcUfyF428wkIKtcorZLGqxMwC0lXWId2biUn5Fnk1ffiHNfGJY3Hcj75haE
         YJbAXD3tguLU3GXpMna01cUfwWlP//1FYanwY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=faZT7/M2irgQrymjKFJXoXBXZB9GI/8oPK3AmwV7J2+hr/wSCinm07yYuCK3CLobeb
         NUhoVk8sFx65VeG9A1SpHREGGjBjrA7gWUFIeffXfftR1GrZDB5fouI5ltkOpCTZeRZr
         XERr23CdAALkFQabsK3JilFeD7if5swqanD6s=
Received: by 10.87.13.6 with SMTP id q6mr5460232fgi.19.1271756808815;
        Tue, 20 Apr 2010 02:46:48 -0700 (PDT)
Received: from localhost.localdomain (abvf202.neoplus.adsl.tpnet.pl [83.8.203.202])
        by mx.google.com with ESMTPS id d8sm10896253fga.26.2010.04.20.02.46.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 20 Apr 2010 02:46:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3K9kJCX016356;
	Tue, 20 Apr 2010 11:46:30 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3K9k6oK016346;
	Tue, 20 Apr 2010 11:46:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <h2w4ef15ddc1004200200ocd9df12azf62da7419355ae7c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145361>

Brian Herman <brianherman@gmail.com> writes:

> Can git support codebases on the order of magnitude of Gigabytes?
> For example, a game developer might want to use git as their SCM
> software but their codebases can be in gigabytes in scale.
> If git cannot support this how would one begin to create this support?

Take a look at git-bigfiles project.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
