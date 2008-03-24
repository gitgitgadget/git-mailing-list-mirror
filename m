From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] filter-branch.sh: support nearly proper tag name
 filtering
Date: Mon, 24 Mar 2008 07:49:46 -0700
Message-ID: <7viqzc18j9.fsf@gitster.siamese.dyndns.org>
References: <1206031893-29599-1-git-send-email-casey@nrlssc.navy.mil>
 <47E298A5.6050508@nrlssc.navy.mil>
 <alpine.LSU.1.00.0803201812560.4124@racer.site>
 <7vr6e01xja.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803241152050.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 15:50:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdo0Z-0005pU-Qk
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 15:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759734AbYCXOuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 10:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758539AbYCXOuA
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 10:50:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44525 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754609AbYCXOuA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 10:50:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 82BA42F83;
	Mon, 24 Mar 2008 10:49:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id BC2CF2F7F; Mon, 24 Mar 2008 10:49:54 -0400 (EDT)
In-Reply-To: <alpine.LSU.1.00.0803241152050.4353@racer.site> (Johannes
 Schindelin's message of "Mon, 24 Mar 2008 11:53:41 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78044>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Sun, 23 Mar 2008, Junio C Hamano wrote:
>
>> If you tell filter-branch to filter a branch A and a tag T, as the 
>> command is advertised to rewrite positive refs that were given from the 
>> command line, isn't it natural to expect that the command would attempt 
>> its best effort to rewrite such a tag object?
>
> The thing is: signed tags cannot be rewritten.

I know that, and you know I know that if you read what you responded again
;-)

And I think stripping of gpg signature part is a reasonable best effort
for the command, _when_ the user told a signed tag to be rewritten.
