From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy config option is not set
Date: Tue, 28 Feb 2012 15:34:13 +0100
Message-ID: <87mx8358nu.fsf@thomas.inf.ethz.ch>
References: <4F4CCE8A.4010800@seap.minhap.es>
	<878vjn8823.fsf@thomas.inf.ethz.ch> <4F4CEB5D.5020808@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>, <peff@peff.net>,
	<sam.vilain@catalyst.net.nz>, <sam@vilain.net>
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Tue Feb 28 15:34:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2O8C-0000Ew-Eb
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 15:34:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab2B1OeP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 09:34:15 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:15564 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755541Ab2B1OeP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 09:34:15 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 15:34:12 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 15:34:13 +0100
In-Reply-To: <4F4CEB5D.5020808@seap.minhap.es> (Nelson Benitez Leon's message
	of "Tue, 28 Feb 2012 15:57:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191736>

Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es> writes:

> On 02/28/2012 01:19 PM, Thomas Rast wrote:
>> 
>> * Why is this needed?  Does git's use of libcurl ignore http_proxy?  [1]
>>   seems to indicate that libcurl respects <protocol>_proxy
>>   automatically.
>
> It could not be needed, because, as you noted, curl already reads it, but then we will
> loose the feature on patch [3/3] because if $http_proxy has username but no password
> curl will not ask you for the password.. instead if we read it we could detect that,
> and ask for the password. 

Ok.  An explanation along these lines should definitely go into the
commit message!

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
