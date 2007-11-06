From: Michael Cohen <michaeljosephcohen@mac.com>
Subject: Re: [PATCH] git-mailsplit: with maildirs try to process new/ if	cur/ is empty
Date: Mon, 5 Nov 2007 20:41:56 -0500
Message-ID: <635FFEC2-2489-443B-8425-DF2B58BE23C2@mac.com>
References: <20071026141539.29928.qmail@d3691352d65cf2.315fe32.mid.smarden.org> <20071026160118.GA5076@ferdyx.org> <20071105124920.17726.qmail@746e9cce42b49f.315fe32.mid.smarden.org> <20071105225258.GC4208@steel.home>
Mime-Version: 1.0 (Apple Message framework v912)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>,
	"Fernando J. Pereda" <ferdy@gentoo.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 06 02:42:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpDSW-0003iD-IU
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 02:42:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755836AbXKFBmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 20:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755824AbXKFBmO
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 20:42:14 -0500
Received: from smtpoutm.mac.com ([17.148.16.78]:51799 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752045AbXKFBmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 20:42:13 -0500
Received: from mac.com (asmtp004-s [10.150.69.67])
	by smtpoutm.mac.com (Xserve/smtpout015/MantshX 4.0) with ESMTP id lA61g0VE007014;
	Mon, 5 Nov 2007 17:42:00 -0800 (PST)
Received: from mac-pro.lan (c-71-196-112-35.hsd1.fl.comcast.net [71.196.112.35])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp004/MantshX 4.0) with ESMTP id lA61fvA0014202
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 5 Nov 2007 17:41:58 -0800 (PST)
In-Reply-To: <20071105225258.GC4208@steel.home>
X-Mailer: Apple Mail (2.912)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63611>

On Nov 5, 2007, at 5:52 PM, Alex Riesen wrote:

> Gerrit Pape, Mon, Nov 05, 2007 13:49:20 +0100:
>> +	for (i = 0; i < 2; ++i) {
>> +		snprintf(name, sizeof(name), "%s/%s", path, sub[i]);
>> +		if ((dir = opendir(name)) == NULL) {
>> +			error("cannot opendir %s (%s)", name, strerror(errno));
>> +			return -1;
>> +		}
>
> Why is missing "cur" (or "new", for that matter) a fatal error?
> Why is it error at all? How about just ignoring the fact?
In Maildir format, cur and new hold the mails. :P

-mjc
