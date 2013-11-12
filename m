From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [PATCH 5/7] test-hg.sh: avoid obsolete 'test' syntax
Date: Tue, 12 Nov 2013 00:34:16 -0500
Message-ID: <5281BDD8.6040501@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com> <1384142712-2936-6-git-send-email-rhansen@bbn.com> <5280c31919c9_6841541e7851@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 06:34:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg6cN-0003gY-Gv
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 06:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab3KLFeU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 00:34:20 -0500
Received: from smtp.bbn.com ([128.33.0.80]:35325 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab3KLFeT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 00:34:19 -0500
Received: from socket.bbn.com ([192.1.120.102]:57705)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg6cD-000Lil-Su; Tue, 12 Nov 2013 00:34:17 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 43F874004D
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <5280c31919c9_6841541e7851@nysa.notmuch>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237684>

On 2013-11-11 06:44, Felipe Contreras wrote:
> Richard Hansen wrote:
>> The POSIX spec says that the '-a', '-o', and parentheses operands to
>> the 'test' utility are obsolete extensions due to the potential for
>> ambiguity.  Replace '-o' with '|| test' to avoid unspecified behavior.
> 
> All right, if you say so.

In case you're curious about what the spec says:

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16

-Richard
