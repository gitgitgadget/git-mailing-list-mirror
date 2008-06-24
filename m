From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Tue, 24 Jun 2008 13:44:34 -0700
Message-ID: <7vskv2d0lp.fsf@gitster.siamese.dyndns.org>
References: <7vhccfiksy.fsf@gitster.siamese.dyndns.org>
 <7vod6k6zg4.fsf@gitster.siamese.dyndns.org>
 <7v4p7xwsfp.fsf@gitster.siamese.dyndns.org>
 <7v3anb19n7.fsf@gitster.siamese.dyndns.org>
 <7vwskjazql.fsf@gitster.siamese.dyndns.org>
 <20080621121429.GI29404@genesis.frugalware.org>
 <7vwskfclfs.fsf@gitster.siamese.dyndns.org>
 <9B8F0B10-F48D-475B-BF59-CEE94222B6E8@ai.rug.nl>
 <20080624160224.GA29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806241709330.9925@racer>
 <20080624185403.GB29404@genesis.frugalware.org>
 <alpine.DEB.1.00.0806242007150.9925@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Pieter de Bie <pdebie@ai.rug.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jun 24 22:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBFOX-0003AF-Cb
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 22:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753754AbYFXUop (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 16:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753150AbYFXUop
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 16:44:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47529 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040AbYFXUoo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 16:44:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3EDAD2454;
	Tue, 24 Jun 2008 16:44:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 58D12244A; Tue, 24 Jun 2008 16:44:37 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0806242007150.9925@racer> (Johannes
 Schindelin's message of "Tue, 24 Jun 2008 20:08:56 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5FB292B6-422E-11DD-A850-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86142>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Using fc48199 ("Merge branch 'master' into next", which includes
>> ed99a225) on the server, v1.5.6 on the client, I get: 
>> 
>> $ git clone server:/home/vmiklos/git/test next
>> Initialize next/.git
>> Initialized empty Git repository in /home/vmiklos/scm/git/next/.git/
>> vmiklos@server's password:
>> bash: git-upload-pack: command not found
>> fatal: The remote end hung up unexpectedly
>
> Hmm.  Probably the client needs to be newer, too.  This is going to be 
> painful.  Junio?

Even with maint client accessing an account with next git-shell as its
login shell, I do not get the above failure.

Is git-shell installed and configured correctly at all in Miklos's setup?
Why does the other side say "bash: git-upload-pack" when login shell is
git-shell and not bash?
