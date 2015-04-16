From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 18:08:12 +0200
Organization: gmx
Message-ID: <26acc1b2979a49a2f65e8e14cd2d944b@www.dscho.org>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
 <xmqqsic0hyk4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	git@vger.kernel.org, git-owner@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 18:08:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YimLC-0004an-VJ
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 18:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbbDPQIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 12:08:30 -0400
Received: from mout.gmx.net ([212.227.15.15]:64601 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752212AbbDPQIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 12:08:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0M70Td-1ZcNEO21en-00wlek; Thu, 16 Apr 2015 18:08:13
 +0200
In-Reply-To: <xmqqsic0hyk4.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:495jQhUQ+0RITRNGlt2wl6M8W/jsTr1o0pxn6nI9uMov95+C2p9
 MLlpLuv+JNaXKqidRfwTAGjNOfjb6Zz9mh8H+AlQbEpFDBU7cxwFxMBc9dRFChoqmJ9ecxe
 hhncus2JW+3aV4Ao3omVMMMaCuEiBzHtB/XC9f+I0THKd+gDrsQ7oKtE3URwM8WXFRnetov
 CPo5WyAXnIaeF9C5PHHPA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267304>

Hi,

On 2015-04-16 17:39, Junio C Hamano wrote:

> Also do we need a similar change to the attribute side, or are we
> already covered and we forgot to do the same for the ignore files?

I fear so: https://github.com/git/git/blob/v2.3.5/attr.c#L359-L376

As for the config, we are safe: https://github.com/git/git/blob/v2.3.5/config.c#L419-L439

Ciao,
Dscho
