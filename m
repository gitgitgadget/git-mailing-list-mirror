From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn testsuite: use standard configuration for
 Subversion tools
Date: Fri, 01 May 2009 11:26:17 -0700
Message-ID: <7vfxfowugm.fsf@gitster.siamese.dyndns.org>
References: <BfKhGHDBpSzjNF/dt4ZDx88u9wI@BjOYljNjUB0FD+/Fw7pzaXMw/Hc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: normaperson@yhbt.net, git@vger.kernel.org
To: Eygene Ryabinkin <rea-git@codelabs.ru>
X-From: git-owner@vger.kernel.org Fri May 01 20:26:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzxRR-0001F2-Gw
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 20:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641AbZEAS0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 14:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbZEAS0Z
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 14:26:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51774 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753895AbZEAS0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 14:26:24 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5DF93AF742;
	Fri,  1 May 2009 14:26:23 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1067CAF740; Fri,
  1 May 2009 14:26:18 -0400 (EDT)
In-Reply-To: <BfKhGHDBpSzjNF/dt4ZDx88u9wI@BjOYljNjUB0FD+/Fw7pzaXMw/Hc>
 (Eygene Ryabinkin's message of "Fri, 1 May 2009 15:46:56 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 930D1FB6-367D-11DE-AB7A-CABC03BA4B0C-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118086>

Eygene Ryabinkin <rea-git@codelabs.ru> writes:

> @@ -54,6 +56,20 @@ poke() {
>  	test-chmtime +1 "$1"
>  }
>  
> +# We need this, because we should pass empty configuration directory to
> +# the 'svn commit' to avoid automated property changes and other stuff
> +# that could be set from user's configuration files in ~/.subversion.
> +svn_cmd () {
> +	local cmd

Does this work without your /bin/sh being bash?
