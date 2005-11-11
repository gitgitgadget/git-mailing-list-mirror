From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] specfile cleanups
Date: Fri, 11 Nov 2005 01:22:24 -0800
Message-ID: <7vveyzpmi7.fsf@assigned-by-dhcp.cox.net>
References: <20051111091029.GW8041@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 10:24:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaV76-0007zZ-TR
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 10:22:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312AbVKKJW0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 04:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVKKJW0
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 04:22:26 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:34206 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932312AbVKKJWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 04:22:25 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111092135.CNDD29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 04:21:35 -0500
To: Chris Wright <chrisw@osdl.org>
In-Reply-To: <20051111091029.GW8041@shell0.pdx.osdl.net> (Chris Wright's
	message of "Fri, 11 Nov 2005 01:10:29 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11577>

Chris Wright <chrisw@osdl.org> writes:

> Some specfile cleanups after the split.

Thanks.

Does it matter some Requires use comma and others don't?

> -BuildRequires:	zlib-devel, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
> +BuildRequires:	zlib-devel >= 1.2, openssl-devel, curl-devel  %{!?_without_docs:, xmlto, asciidoc > 6.0.3}
>  BuildRoot:	%{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
>  Requires:	zlib >= 1.2, rsync, rcs, curl, less, openssh-clients, python >= 2.3, tk >= 8.4
>  
>  Group:          Development/Tools
> -Requires:       subversion
> +Requires:       git-core = %{version}-%{release} subversion
