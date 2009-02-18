From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] bash completion: only show 'log --merge' if
 merging
Date: Wed, 18 Feb 2009 11:02:35 -0800
Message-ID: <7vwsbnwotw.fsf@gitster.siamese.dyndns.org>
References: <adf1fd3d0902150156w67a16e6fp3c946446c5ae2bfd@mail.gmail.com>
 <bc66ec312ad33c4a7c9580ba4ade75c5998443d7.1234801852.git.trast@student.ethz.ch> <20090218170518.GD22848@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:04:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZriJ-0000gU-AR
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 20:04:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbZBRTCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 14:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752602AbZBRTCn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 14:02:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57325 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751550AbZBRTCm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 14:02:42 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 40C882B686;
	Wed, 18 Feb 2009 14:02:42 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4AB2C2B683; Wed,
 18 Feb 2009 14:02:37 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B807123A-FDEE-11DD-ACB0-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110568>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Thomas Rast <trast@student.ethz.ch> wrote:
>> The gitk completion only shows --merge if MERGE_HEAD is present.
>> Do it the same way for git-log completion.
>> 
>> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
>> ---
>>  contrib/completion/git-completion.bash |    7 ++++++-
>>  1 files changed, 6 insertions(+), 1 deletions(-)
>
> Both patches,
>
> Acked-by: Shawn O. Pearce <spearce@spearce.org>

Thanks.
