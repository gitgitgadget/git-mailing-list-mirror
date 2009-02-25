From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git push
Date: Wed, 25 Feb 2009 01:51:29 -0800
Message-ID: <7vzlga6dzy.fsf@gitster.siamese.dyndns.org>
References: <43d8ce650902242238s7ab4c851p9c820c96b67aa62b@mail.gmail.com>
 <7vskm3c84t.fsf@gitster.siamese.dyndns.org>
 <43d8ce650902242309nef12bd9j9088170b18cc8d4e@mail.gmail.com>
 <7v4oyjc64z.fsf@gitster.siamese.dyndns.org>
 <76718490902250134q580caaffuf5f13d87e3d0974c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 25 10:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcGRx-0001Ro-P5
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 10:53:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbZBYJvj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 04:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756602AbZBYJvj
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 04:51:39 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590AbZBYJvi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 04:51:38 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8F7AF9D6DD;
	Wed, 25 Feb 2009 04:51:36 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 849B59D6DC; Wed,
 25 Feb 2009 04:51:31 -0500 (EST)
In-Reply-To: <76718490902250134q580caaffuf5f13d87e3d0974c@mail.gmail.com>
 (Jay Soffian's message of "Wed, 25 Feb 2009 04:34:54 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E43C1020-0321-11DE-8749-B26E209B64D9-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111424>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Feb 25, 2009 at 2:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Oh, and the value 'current' can be spelled as 'HEAD' already there.
>
> John - in case you missed this, the behavior you desire is already available:
>
> (next)$ git config remote.origin.push HEAD
> (next)$ git remote show origin
>   [...]
>   Local ref configured for 'git push':
>     HEAD pushes to next (fast forwardable)
> (next)$ git checkout master
>
> (master)$ git remote show origin
>   [...]
>   Local ref configured for 'git push':
>     HEAD pushes to master (fast forwardable)

Thanks.
