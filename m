From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Add a svnrdump-simulator replaying a dump file for
 testing.
Date: Mon, 23 Jul 2012 07:59:21 -0500
Message-ID: <20120723125921.GA16768@burratino>
References: <4514544.Xip1OCQ7Uj@flomedio>
 <20120722214333.GB680@burratino>
 <2948040.5ceLh0WG3L@flomedio>
 <1448476.VR1Gla8Cvg@flomedio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: davidbarr@google.com, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 14:59:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StIEb-000209-KE
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 14:59:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096Ab2GWM7c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 08:59:32 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:53551 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033Ab2GWM7b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 08:59:31 -0400
Received: by ghrr11 with SMTP id r11so5384781ghr.19
        for <git@vger.kernel.org>; Mon, 23 Jul 2012 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=UlYkpJj++RvD3qiia1t+IS5FbCfH2xtVz7Mfcvty2Ew=;
        b=AjJ+viThlCvNeamGgFyWkOBAviLZ/nxg+k8ZXBF5tj3b5DDUDpKKF4oZXo8L/9xut5
         tXejBL2kZDe1seBbK9OHd2KURM/9BfAnS2bZDPzgGivL3Fpew5DbkUB3/OkKFC2jAmEO
         KhChjmv+9sRCMJzwW38JMetgua80AE2mrR1hk75SjSxq5Tnt+pqem3/NmEpsTw5rHM/1
         x/o8YIsywCPulcy1/NIvSNLdsx6Nn5qxet9c1gPjPN27t8L9XyBFZm5L5MUXb6KPqMdo
         rNtCSUhB2aZSQJW47D0ZPx9Ua6DMInpmnLB1WwYqljVG9RSTFh3UWsv8Klwx4m20eV+q
         9Pww==
Received: by 10.50.220.195 with SMTP id py3mr10084372igc.70.1343048371095;
        Mon, 23 Jul 2012 05:59:31 -0700 (PDT)
Received: from burratino (cl-1372.chi-02.us.sixxs.net. [2001:4978:f:55b::2])
        by mx.google.com with ESMTPS id y5sm13245472igb.11.2012.07.23.05.59.30
        (version=SSLv3 cipher=OTHER);
        Mon, 23 Jul 2012 05:59:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1448476.VR1Gla8Cvg@flomedio>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201932>

Florian Achleitner wrote:

> To ease testing without depending on a reachable svn server, this
> compact python script mimics parts of svnrdumps behaviour.

Thanks.  Mind if I forge your sign-off?
