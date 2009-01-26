From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Make has_commit non-static
Date: Mon, 26 Jan 2009 12:06:51 -0800
Message-ID: <7v63k16dd0.fsf@gitster.siamese.dyndns.org>
References: <1232979205-17161-1-git-send-email-goulding@vivisimo.com>
 <1232979205-17161-2-git-send-email-goulding@vivisimo.com>
 <alpine.DEB.1.00.0901261637300.25749@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jake Goulding <goulding@vivisimo.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 26 21:08:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRXky-0000Ob-5d
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 21:08:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753231AbZAZUHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 15:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZAZUHF
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 15:07:05 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58687 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751708AbZAZUHC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 15:07:02 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 072A093EA8;
	Mon, 26 Jan 2009 15:07:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C41CA93EA5; Mon,
 26 Jan 2009 15:06:57 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0901261637300.25749@intel-tinevez-2-302>
 (Johannes Schindelin's message of "Mon, 26 Jan 2009 16:38:22 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E520683C-EBE4-11DD-976D-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107266>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 26 Jan 2009, Jake Goulding wrote:
>
>> Moving has_commit from branch to a common location in preparation for 
>> using it in tag. Renaming it to commit_has_any_in_commit_list to be more 
>> unique.
>
> I feel like bike-shedding for a change, and I'd also like to prove that 
> not all Germans like long names:
>
> 	is_ancestor_of_any()
>
> Hmm?

Is it ancestor or descendant?  The latter makes the name longer, though
;-)
