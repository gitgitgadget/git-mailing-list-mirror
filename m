From: Junio C Hamano <gitster@pobox.com>
Subject: Re: global hooks
Date: Wed, 19 Mar 2008 19:25:18 -0700
Message-ID: <7vk5jyyvw1.fsf@gitster.siamese.dyndns.org>
References: <1205942671.691.8.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Victor Bogado da Silva Lins <victor@bogado.net>
X-From: git-owner@vger.kernel.org Thu Mar 20 03:26:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcATm-00023C-TD
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 03:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbYCTCZ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 22:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbYCTCZ1
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 22:25:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:39525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbYCTCZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 22:25:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 62A632D6D;
	Wed, 19 Mar 2008 22:25:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B95D52D6C; Wed, 19 Mar 2008 22:25:20 -0400 (EDT)
In-Reply-To: <1205942671.691.8.camel@omicron.ep.petrobras.com.br> (Victor
 Bogado da Silva Lins's message of "Wed, 19 Mar 2008 13:04:31 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77614>

Victor Bogado da Silva Lins <victor@bogado.net> writes:

> SO my question is, is there a way to make that hook global to all
> projects? If not, would it be a good idea to allow this?

Probably a post- git-init hook that lets you do anything to your newly
created repository would be the only thing that you need.  Then you can
copy, untar or even use symlink to muck with .git/hooks/ in whatever way
you please.

There needs a mechanism for you to specify what that hook is, and it
cannot be in individual repositories, so it has to live in ~/.gitconfig
somewhere.
