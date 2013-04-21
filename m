From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: t6200: avoid path mangling issue on Windows
Date: Sun, 21 Apr 2013 08:22:30 +0200
Message-ID: <517385A6.8020908@kdbg.org>
References: <1365348344-1648-1-git-send-email-ralf.thielow@gmail.com> <1365348344-1648-2-git-send-email-ralf.thielow@gmail.com> <516F95D1.5070209@viscovery.net> <7v38un93br.fsf@alter.siamese.dyndns.org> <5170DA96.9000300@viscovery.net> <7vr4i632fp.fsf@alter.siamese.dyndns.org> <51719F18.3020508@kdbg.org> <7va9ouz04y.fsf@alter.siamese.dyndns.org> <20130421000522.GB10043@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ralf Thielow <ralf.thielow@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 21 08:22:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTnfb-0005Z6-I2
	for gcvg-git-2@plane.gmane.org; Sun, 21 Apr 2013 08:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751781Ab3DUGWg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Apr 2013 02:22:36 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:40624 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751380Ab3DUGWf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Apr 2013 02:22:35 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 83F8E10010;
	Sun, 21 Apr 2013 08:22:31 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id EA78219F5A6;
	Sun, 21 Apr 2013 08:22:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <20130421000522.GB10043@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221895>

Am 21.04.2013 02:05, schrieb Jonathan Nieder:
> Junio C Hamano wrote:
> 
>> But a _real user_ who wants to use a slash there has no way of doing
>> so.
> 
> Doesn't foo=// do that in the msys world?  If I am reading
> mingw/msys/rt/src/winsup/cygwin/path.cc correctly then the way to pass
> a true double-slash is foo=///.

That would be totally unexpected.

-- Hannes
