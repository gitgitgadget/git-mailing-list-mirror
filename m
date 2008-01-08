From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] gitk: fix "Key bindings" message
Date: Wed, 9 Jan 2008 10:36:12 +1100
Message-ID: <18308.2284.160506.432481@cargo.ozlabs.ibm.com>
References: <200801081437.46398.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 00:37:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCO0c-0002hi-Sp
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 00:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755583AbYAHXg3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 18:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755646AbYAHXg3
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 18:36:29 -0500
Received: from ozlabs.org ([203.10.76.45]:41669 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755583AbYAHXg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 18:36:28 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
	id BF9E0DDF3B; Wed,  9 Jan 2008 10:36:26 +1100 (EST)
In-Reply-To: <200801081437.46398.barra_cuda@katamail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69935>

Michele Ballabio writes:

> -"] \
> +" $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T $M1T ] \

Ick.  Are you sure you have the right number of instances of $M1T? :)

I'd prefer to use [string map].

Actually, for translation, it would probably be better to bust up that
help text into a series of shorter strings, maybe even one per line.

Paul.
