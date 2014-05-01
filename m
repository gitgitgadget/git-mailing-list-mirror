From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Zsh submodule name completion borked
Date: Thu, 1 May 2014 15:31:21 -0700
Message-ID: <20140501223121.GD9218@google.com>
References: <CABURp0oS0qnyVhfV1rsaNXT-88QJvgpNn+meApNKRTGdULDXpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 02 00:31:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfzVp-00023J-4R
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 00:31:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbaEAWbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 18:31:25 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:64072 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968AbaEAWbY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 18:31:24 -0400
Received: by mail-pd0-f169.google.com with SMTP id z10so2445988pdj.0
        for <git@vger.kernel.org>; Thu, 01 May 2014 15:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=OhAW+6K1BlI3ZcjI7a+8O1HET6vNgKuAa0A/Z0OwBro=;
        b=SjY5H97AjorkzIkvTQqWL849a7arYE0jm05RrKHd5Z0ppvkkvreBXvA0ENjGLzRmuX
         wbx7Rp7jAXx93qU5KXbB4pckvDU1mqkeyh1zYafGQYndnWCPcy03XmKrLNUDM4o6V8dp
         sx/3b3ejx/W4ZvZONPYfV5eZIpPkb5BMWDQLVqVmPMkMJDA30ezN6AEkCFVmyU0z8TUy
         xiMneK3uBS7tc49Uw4MkVLSPCwCHIGm3qZm/lLOOHyVHPiv26yhz7mp44aUTYCEIvru8
         gQuBrLsOXOji23wol4+1bZhCmoLiBr2t3X3RCe3vKxZUbLvhtqLwunOhqROh4Q8fBPtV
         WyhA==
X-Received: by 10.67.13.134 with SMTP id ey6mr26629410pad.44.1398983483772;
        Thu, 01 May 2014 15:31:23 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id nw13sm144027722pab.37.2014.05.01.15.31.22
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 01 May 2014 15:31:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CABURp0oS0qnyVhfV1rsaNXT-88QJvgpNn+meApNKRTGdULDXpA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247889>

Hi,

Phil Hord wrote:

> When I use zsh tab-completion to complete the submodule name in 'git
> submodule init', I get more than I expected.

Is this using zsh's native tab-completion (i.e., not the tab
completion bundled with git)?  There might have been a change there.

Another place to look for hints would be ~/.gitconfig.

Hope that helps,
Jonathan
