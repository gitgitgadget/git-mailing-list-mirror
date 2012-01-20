From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] remote-curl: Fix push status report when all branches fail
Date: Fri, 20 Jan 2012 17:17:54 +0100
Message-ID: <8739bacpql.fsf@thomas.inf.ethz.ch>
References: <7vzkdjgv1i.fsf@alter.siamese.dyndns.org>
	<1327029129-11424-1-git-send-email-spearce@spearce.org>
	<7vobtyhq16.fsf@alter.siamese.dyndns.org>
	<CAJo=hJtCb=WFfuSKWvPk+S4sRQmSGemG_Ugqj+k1TZCOJj9vLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 20 17:18:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoHAM-0004PA-5w
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 17:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414Ab2ATQSD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 11:18:03 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:40113 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754375Ab2ATQR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 11:17:59 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Jan
 2012 17:17:56 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.131) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Jan
 2012 17:17:57 +0100
In-Reply-To: <CAJo=hJtCb=WFfuSKWvPk+S4sRQmSGemG_Ugqj+k1TZCOJj9vLQ@mail.gmail.com>
	(Shawn Pearce's message of "Fri, 20 Jan 2012 07:15:02 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.131]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188884>

Shawn Pearce <spearce@spearce.org> writes:

> On Thu, Jan 19, 2012 at 22:00, Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>>> +cat >exp <<EOF
>>> +remote: error: hook declined to update refs/heads/dev2
>>
>> Curious. Where do we get these eight trailing whitespaces?
>
> I think this is padding being added to the end of the line by
> recv_sideband(). I noticed the trailing whitespace in the diff, but
> the test passed with it present, so I had to leave it in.

ISTR we had a policy to guard such whitespace at EOL?  Compare
e.g. c1376c12b7.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
