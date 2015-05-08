From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] bundle: verify arguments more strictly
Date: Fri, 08 May 2015 10:11:08 +0200
Organization: gmx
Message-ID: <239a633b6bbed03e92318322ce566295@www.dscho.org>
References: <1431071341-23363-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Fri May 08 10:11:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqdNV-0000MK-8A
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 10:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752348AbbEHILS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 04:11:18 -0400
Received: from mout.gmx.net ([212.227.15.15]:56553 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751607AbbEHILO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 04:11:14 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAQ0o-1Yxjr43a70-00BYQU; Fri, 08 May 2015 10:11:08
 +0200
In-Reply-To: <1431071341-23363-1-git-send-email-ps@pks.im>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:+mUOvYuFP/GWaWntvAnR2kO7oxdUPWWsWQS84UT5N/hMAgC8oOC
 M2vyv2p1AoIYRHRMRiJGn6JWt5Rm3kAC3DPIo2tbb/ppdmApCM/Yhew8YF2GA7k3rWt6T8q
 +clvsoDvTar5iFg8CiMw2f2Ml4BiPf93v6Wzzn3eWCU3C/4Oc3DHXekQDFkCJ1RrAQIHPMX
 nsLlma13pMOeJCUkDyO1g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268607>

Hi Patrick,

On 2015-05-08 09:49, Patrick Steinhardt wrote:
> The `verify` and `create` subcommands of the bundle builtin do
> not properly verify the command line arguments that have been
> passed in. While the `verify` subcommand accepts an arbitrary
> amount of ignored arguments the `create` subcommand does not
> complain about being passed too few arguments, resulting in a
> bogus call to `git rev-list`. Fix these errors by verifying that
> the correct amount of arguments has been passed in.

Good catch. But please sign off your patch [*1*]

Other than that...
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Ciao,
Johannes

Footnote *1*: Here is why you need to sign off on your patches: https://github.com/git/git/blob/v2.3.5/Documentation/SubmittingPatches#L234-L286
