From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch.sh: remove temporary directory on failure
Date: Tue, 29 Jan 2008 21:51:33 -0800
Message-ID: <7v3asfkgii.fsf@gitster.siamese.dyndns.org>
References: <479E4612.6030006@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 30 06:52:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JK5s8-0004EL-Lx
	for gcvg-git-2@gmane.org; Wed, 30 Jan 2008 06:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbYA3Fvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 00:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbYA3Fvu
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 00:51:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:50597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754080AbYA3Fvu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 00:51:50 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A2ED52811;
	Wed, 30 Jan 2008 00:51:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A6852810;
	Wed, 30 Jan 2008 00:51:44 -0500 (EST)
In-Reply-To: <479E4612.6030006@nrlssc.navy.mil> (Brandon Casey's message of
	"Mon, 28 Jan 2008 15:16:02 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72026>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Even though this directory may be useful for debugging when you encounter
> a problem, I wonder if the normal "error" will be _user_ error. In which
> case the user will adjust the command line parameters and try to rerun.
> Currently the user would then receive the message
>
>      "$tempdir already exists, please remove it"
>
> Then, rm -rf the tempdir, then rerun.
>
> Is this necessary? Maybe anyone with the know-how to debug would also have the
> know-how to comment out the 'trap' in the script (or direct someone asking for
> help on the mailing list to do so).

Makes sense to me.  Dscho?
