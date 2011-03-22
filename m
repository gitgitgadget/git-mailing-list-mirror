From: Eric Raible <raible@nextest.com>
Subject: Re: [PATCH 2/2] update $GIT_INDEX_FILE when there are racily clean
 entries
Date: Mon, 21 Mar 2011 17:26:54 -0700
Message-ID: <4D87ECCE.4000300@nextest.com>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com> <7vipvcs9xt.fsf@alter.siamese.dyndns.org> <7voc54qtmf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, Lasse Makholm <lasse.makholm@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 01:27:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1pRH-00073v-BD
	for gcvg-git-2@lo.gmane.org; Tue, 22 Mar 2011 01:27:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755453Ab1CVA04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 20:26:56 -0400
Received: from exchange.domain1.nextest.com ([12.96.234.114]:46293 "EHLO
	Exchange.DOMAIN1.nextest.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754841Ab1CVA0z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 20:26:55 -0400
Received: from [131.101.20.211] (131.101.20.211) by
 Exchange.DOMAIN1.nextest.com (131.101.21.39) with Microsoft SMTP Server (TLS)
 id 8.2.254.0; Mon, 21 Mar 2011 17:28:08 -0700
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.15) Gecko/20110303 Lightning/1.0b2 Thunderbird/3.1.9
In-Reply-To: <7voc54qtmf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169696>

On 11:59 AM, Junio C Hamano wrote:
> Traditional "opportunistic index update" done by read-only "diff" and
> "status" was about updating cached lstat(2) information in the index for
> the next round.  We missed another obvious optimization opportunity to
> when there are racily clean entries that will ceas to be racily clean
> by updating $GIT_INDEX_FILE.

s/ceas/cease/
