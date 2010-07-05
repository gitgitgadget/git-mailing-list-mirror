From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC PATCH] rerere: fix overeager gc
Date: Mon, 05 Jul 2010 08:02:34 +0200
Message-ID: <4C31757A.1000207@viscovery.net>
References: <1277811498-17288-1-git-send-email-szeder@ira.uka.de> <7vy6dx90uk.fsf@alter.siamese.dyndns.org> <4C2AE04E.9090901@viscovery.net> <7v1vbn417d.fsf@alter.siamese.dyndns.org> <4C2D7DF7.8030408@viscovery.net> <7vmxu923up.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 05 08:02:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OVelU-0006AG-8O
	for gcvg-git-2@lo.gmane.org; Mon, 05 Jul 2010 08:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752008Ab0GEGCn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jul 2010 02:02:43 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43710 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0GEGCm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jul 2010 02:02:42 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1OVelK-0005sL-9Q; Mon, 05 Jul 2010 08:02:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 62B7B1660F;
	Mon,  5 Jul 2010 08:02:35 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.1.10) Gecko/20100512 Thunderbird/3.0.5
In-Reply-To: <7vmxu923up.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150243>

Am 7/2/2010 19:25, schrieb Junio C Hamano:
> If anything, "preimage" that has newer timestamp than "postimage" feels
> wrong,...

Indeed; I agree.

> If we for whatever reason trust placing an extra timestamp on a regular
> file more than using directory timestamp (which I think may be a valid
> concern from portability point of view),

Windows behaves well in this regard. Writing of thisimage must be
converted to lockfile infrastructure, of course.

> I'd rather see "preimage"
> timestamp to keep track of the time when we _first_ encountered the
> particular conflict, and "postimage" used for recording the time when we
> saw the conflict most recently.

That would be fine, too.

-- Hannes
