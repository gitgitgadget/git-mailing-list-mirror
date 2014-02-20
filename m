From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 3/3] push: Add the --no-recurse-submodules option
Date: Thu, 20 Feb 2014 13:12:34 +0000
Message-ID: <5305FF42.9000402@web.de>
References: <A67F2B72-5398-4035-B79B-0568CA4BB0B4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Semyon Perepelitsa <semaperepelitsa@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 20 14:12:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGTQp-0007aZ-5Z
	for gcvg-git-2@plane.gmane.org; Thu, 20 Feb 2014 14:12:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbaBTNMq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Feb 2014 08:12:46 -0500
Received: from mout.web.de ([212.227.17.12]:62831 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754100AbaBTNMq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Feb 2014 08:12:46 -0500
Received: from [192.168.1.102] ([90.174.2.85]) by smtp.web.de (mrweb101) with
 ESMTPA (Nemesis) id 0MIeQO-1WIfHm2r16-002KHK for <git@vger.kernel.org>; Thu,
 20 Feb 2014 14:12:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <A67F2B72-5398-4035-B79B-0568CA4BB0B4@gmail.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:RBrnk59A7U+mMSAJ9D7fN/OWHy5815smA7HEnrlEEp1Gls1QrpS
 7GHUsqTpUW4CnIByvVB6zwl27ElCvoTHw+xoB0L8mnV5HpW4vnLARzX6RO+3OR+zADRM5YG
 LARFHOJofS2kDp1FCVW6tF4HKa0zJAfWf3QtUaUcFeSVEjvayg8YJUzVRGYqLLwMqSDUnl4
 dLIf+Ry1I91A9fFM25sog==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242431>

Hi Semyon,

Am 18.02.2014 18:49, schrieb Semyon Perepelitsa:
> I noticed the option in the man-page but there is still no configuration option available. Did you forget to add it after all?

Nope, we just didn't implement it yet. ;-)

It's one of the topics on my submodule ToDo list:

  https://github.com/jlehmann/git-submod-enhancements/wiki

> Right now --recurse-submodules has little use by itself as the problem it solves is forgetting to push a submodule which is no different from forgetting to specify the option.

I'm currently busy working on another submodule related topic. But
if you are interested, adding the "fetch.recurseSubmodules" config
option in be254a0e and the "submodule.<name>.fetchRecurseSubmodules"
option in c1a3c364 should be good examples of how to add the
"push.recurseSubmodules" and "submodule.<name>.pushRecurseSubmodules"
config options.

I'll be glad to help in bringing this topic forward by discussing
ideas and reviewing patches. And I believe we should change the
default behavior of push (which is currently quiet about unpushed
submodule commits as you noticed) to either "check" or "on-demand"
(with my preference currently being slightly on the former, but I'm
happy to be convinced otherwise ;-).


Thanks
Jens
