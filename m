From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Provide git_config with a callback-data parameter
Date: Wed, 14 May 2008 12:27:14 -0700
Message-ID: <7vk5hwn0tp.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0805141844580.30431@racer>
 <alpine.DEB.1.00.0805141846370.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 14 21:28:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwMe5-0007Iu-3y
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 21:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757233AbYENT1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 15:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752993AbYENT1W
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 15:27:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47538 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbYENT1W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 15:27:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F300851A4;
	Wed, 14 May 2008 15:27:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3CC6B51A3; Wed, 14 May 2008 15:27:17 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0805141846370.30431@racer> (Johannes
 Schindelin's message of "Wed, 14 May 2008 18:46:53 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C52946D4-21EB-11DD-88DD-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82138>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> git_config() only had a function parameter, but no callback data
> parameter.  This assumes that all callback functions only modify
> global variables.
>
> With this patch, every callback gets a void * parameter, and it is hoped
> that this will help the libification effort.

Great, as this has also been a pet-peeve of mine for quite some time.

Except the patch has quite a many rejects X-<.
