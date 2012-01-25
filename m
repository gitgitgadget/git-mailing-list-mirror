From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/5] run-command: Error out if interpreter not found
Date: Wed, 25 Jan 2012 19:55:36 +0100
Message-ID: <4F205028.4060606@kdbg.org>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com> <1327444346-6243-6-git-send-email-fransklaver@gmail.com> <20120124232421.GH8222@burratino> <op.v8moybu10aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Junio C. Hamano" <gitster@pobox.com>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 19:56:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq80t-0006fL-Lh
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 19:56:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab2AYS4C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 13:56:02 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:65264 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751030Ab2AYS4B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 13:56:01 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.105])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 302AA11947C
	for <git@vger.kernel.org>; Wed, 25 Jan 2012 19:57:06 +0100 (CET)
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 09BBE2C4007;
	Wed, 25 Jan 2012 19:56:44 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id BD6EC19F32A;
	Wed, 25 Jan 2012 19:55:36 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <op.v8moybu10aolir@keputer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189117>

Am 25.01.2012 08:12, schrieb Frans Klaver:
> On Wed, 25 Jan 2012 00:24:21 +0100, Jonathan Nieder <jrnieder@gmail.com>

>> What happens on Windows?
> 
> I didn't plan anything to happen on windows. Doesn't POSIXPERM rule that
> OS out?

It does; these tests are skipped on Windows.

> I guess it could use similar code to this patch series to tackle
> all this.

No thanks. IMHO, this is already too much code for too little gain.

-- Hannes
