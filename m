From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 2/2] daemon: report permission denied error to clients
Date: Wed, 19 Oct 2011 08:33:53 +0200
Message-ID: <ec721333-9b89-40ab-9550-851350507914@email.android.com>
References: <20111014211921.GB16429@sigill.intra.peff.net> <1318803076-4229-1-git-send-email-drizzd@aon.at> <1318803076-4229-2-git-send-email-drizzd@aon.at> <20111017020912.GB18536@sigill.intra.peff.net> <7vhb37l4ag.fsf@alter.siamese.dyndns.org> <20111018204101.GB2072@ecki>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 08:34:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGPjA-0001w6-OQ
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 08:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499Ab1JSGeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 02:34:08 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:3876 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751102Ab1JSGeH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 02:34:07 -0400
Received: from [192.168.1.102] (p5B22FE7E.dip.t-dialin.net [91.34.254.126])
	by bsmtp.bon.at (Postfix) with ESMTP id BEA94130067;
	Wed, 19 Oct 2011 08:34:01 +0200 (CEST)
User-Agent: K-9 Mail for Android
In-Reply-To: <20111018204101.GB2072@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183921>

Clemens Buchacher <drizzd@aon.at> wrote:
>
> I guess if permission is denied for access over git://, then nobody
> can use the repository. So it's clearly a server side issue.
> 
> This change probably makes more sense for local access and over
> ssh. I already have a similar patch brewing for that.

As far as security is concerned, we have to treat ssh the same as git://, unless the user has permission to execute arbitrary commands and not just git-upload-pack. But I can think of no way to figure that out on the server side.
