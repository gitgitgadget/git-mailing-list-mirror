From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc: use parse_options
Date: Mon, 05 Nov 2007 16:37:08 -0800
Message-ID: <7vr6j4ky4r.fsf@gitster.siamese.dyndns.org>
References: <20071102002856.GB3282@crux.yyz.redhat.com>
	<7vhck579pm.fsf@gitster.siamese.dyndns.org>
	<472FA26E.4060706@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:37:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpCRq-0007RU-97
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 01:37:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755469AbXKFAhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 19:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458AbXKFAhQ
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 19:37:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:37559 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368AbXKFAhP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 19:37:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 884322EF;
	Mon,  5 Nov 2007 19:37:35 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 1465D92A54;
	Mon,  5 Nov 2007 19:37:31 -0500 (EST)
In-Reply-To: <472FA26E.4060706@nrlssc.navy.mil> (Brandon Casey's message of
	"Mon, 05 Nov 2007 17:08:30 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63601>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Junio C Hamano wrote:
>> James Bowes <jbowes@dangerouslyinc.com> writes:
>> 
>>> +	struct option builtin_gc_options[] = {
>>> +		OPT_BOOLEAN(0, "prune", &prune, "prune unused objects"),
>> 
>> I would write "unreferenced loose" instead of "unused" here...
>
> It is not just "loose" objects here, but also unreferenced objects in packs,
> since the "-a" option to repack is now only used when --prune is specified.
> Without --prune, "-A" is supplied to repack instead.
>
> So maybe the message should just be "prune unreferenced objects"

Fair enough, will do.
