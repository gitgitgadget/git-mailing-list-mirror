From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] rebase-i: work around Windows CRLF line endings
Date: Wed, 28 Oct 2015 15:56:55 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510281556230.31610@s15462909.onlinehome-server.info>
References: <cover.1445782122.git.johannes.schindelin@gmx.de> <cover.1445939154.git.johannes.schindelin@gmx.de> <adcab7dcf9d802b3703b9ec9291132259a092a04.1445939154.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.1510271054380.31610@s15462909.onlinehome-server.info>
 <xmqqd1w0dy0k.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Chad Boles <chadbo@microsoft.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Philip Oakley <philipoakley@iee.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrSA3-0000EG-W0
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 15:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbbJ1O5C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 10:57:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:64852 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754776AbbJ1O5A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 10:57:00 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MDymt-1ZiNCJ1rA7-00HLrD;
 Wed, 28 Oct 2015 15:56:56 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqd1w0dy0k.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:BFLKo1SMkOmkXAz+fV4skRpKeiME/YSDnr3g4VMwY6Mk8gl30Rw
 7iC+NffaIm2FfbL0AQOlrGYDwEnfjubO6CWXKwHseAZnSz/fzrAZ7TPFwRP74cxx8OYBSZt
 IZ3GgzHVfXezWjtdXf3KJF9wEOxnH+oO8d+p+TInszHD5KbTIjts3FTlY6IIDQxv4/fQWwQ
 lrUth9mS/leFrw2H7CzsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Am3tgRHn4r0=:WGJUXpti8sZTdwG90ncemN
 HdM5KfdN3yIpNH0PsZ2zKMcv/AmJi9YLp0Uk7+B6MXe2ZQLP9qid9B2ME1g0ZdPZyBDUnfMzX
 /KqVjbWLITqozIJ6aWRHzyjMlWqlag4GVkPxS29inQVVFcFatCxnH8E+zhBu2YBaTQ/WcfXqY
 Ecs5/Kp1+FItD1Ysl0os1+dFnpXMpQCsl92MQtnUL5kLzPZbvKIXycgW84ywEQea5quT9UwER
 bcxP5wFSAasdVg4Hbg6tFHQJTiu4+h8s5ywvzqLhy7XZ7T3M4UpXqLe8G/TltwfKSLEcuUZNm
 RgV+k6EsX+AMtXxdqobCYGDz6r28RQb7/on1FNcm13pZYUFsRyGCdzGpYGeUhPYWNeazb/M2F
 LDNgOimKquliGkwjB4PhKPQc+PXgOxxvosrQQFkeGn3XI8sz6LiV9XW3AaDbWdbQOEnBjGaG2
 jKx659NEuxHQTq2r6hRdccHSBU9a+dZh1Ts8dzPbrid0ad12F7bI5ACbbIVoaIlMjuCwz9Bf+
 Wx982rZyxu9aADcGEFHPYDv+ym5byfKZU+2qhva3ufQ7eM7Y78Frn63jFtrlj7bNYDYfXg0UX
 PD4vOQ87BcXADRqslrT52BepSQtCZWkyGAp8/483xWp6KozetXs+KrApkjqLirgNLwBpFdINM
 PT+7++IhimMd2qP5XkxgU868ZOKTK8X/cY65Fpjx6kAndHU3C4kt5qSMoQtidkBOL3yRTCsu4
 2aCXBavXeplPBxUhTBTSwKlqcG4gS+x1d5DIoE6QcOuRse0qdhKzRogoGwr2R3+QF3GDEAs2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280370>

Hi Junio,

On Tue, 27 Oct 2015, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > My apologies: I forgot to spell out explicitly that this passes in Git
> > for Windows 2.x' SDK: It does.
> 
> Can you add that to the log message?  Your cover letter may also want to
> be updated for those who fish for the last version posted in the list
> archive.

Done,
Johannes
