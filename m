From: Tim Chase <git@tim.thechases.com>
Subject: Re: [ANNOUNCE] Git v1.8.2-rc0
Date: Mon, 18 Feb 2013 13:30:08 -0600
Message-ID: <20130218133008.7fd20424@bigbox.christie.dr>
References: <7vk3q6e94s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 20:29:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7WOf-00023E-0F
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 20:29:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323Ab3BRT2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 14:28:41 -0500
Received: from boston.accountservergroup.com ([50.22.11.22]:48050 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752115Ab3BRT2k (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Feb 2013 14:28:40 -0500
Received: from [108.223.140.164] (port=33733 helo=bigbox.christie.dr)
	by boston.accountservergroup.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80)
	(envelope-from <git@tim.thechases.com>)
	id 1U7WOG-00041b-0I; Mon, 18 Feb 2013 13:28:40 -0600
In-Reply-To: <7vk3q6e94s.fsf@alter.siamese.dyndns.org>
X-Mailer: Claws Mail 3.7.6 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216499>

On 2013-02-17 16:52, Junio C Hamano wrote:
>  * Color specifiers, e.g. "%C(blue)Hello%C(reset)", used in the
>    "--format=" option of "git log" and friends can be disabled when
>    the output is not sent to a terminal by prefixing them with
>    "auto,", e.g. "%C(auto,blue)Hello%C(auto,reset)".

Thanks so much!  It has long annoyed me that I had to maintain pairs
of nigh-identical aliases, one with colors for output on my terminal,
the other alias uncolored for piping to further commands.

-tkc
