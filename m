From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: git over https and http 1.1
Date: Wed, 18 May 2011 14:41:05 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105181437510.3057@tvnag.unkk.fr>
References: <BLU0-SMTP195570CAA61AF8232B0295BC78F0@phx.gbl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Nir Friedman <nirfri@hotmail.com>
X-From: git-owner@vger.kernel.org Wed May 18 14:41:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMg3x-0003hI-Pv
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 14:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933090Ab1ERMlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 08:41:12 -0400
Received: from giant.haxx.se ([80.67.6.50]:34739 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933012Ab1ERMlM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 08:41:12 -0400
Received: from giant.haxx.se (giant.haxx.se [80.67.6.50])
	by giant.haxx.se (8.14.4/8.14.4/Debian-2) with ESMTP id p4ICf5gb009235;
	Wed, 18 May 2011 14:41:05 +0200
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <BLU0-SMTP195570CAA61AF8232B0295BC78F0@phx.gbl>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-fromdanielhimself: yes
X-Greylist: Default is to whitelist mail, not delayed by milter-greylist-4.3.8 (giant.haxx.se [80.67.6.50]); Wed, 18 May 2011 14:41:05 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173875>

On Wed, 18 May 2011, Nir Friedman wrote:

> I am using git with https as the transport protocol. Response times were 
> around 30 seconds before apache started processing the backend command.

Can you please be a bit more elaborate on exactly what took that much time? 
What is a "response time" in this context?

> I added the flags   [BrowserMatch "git"      downgrade-1.0
> force-response-1.0] to the apache conf file, and response times were fast.

How fast is "fast" compared to the previous 30 seconds?

> This seems to mean that the libcurl library is not dealing correctly with 
> HTTP 1/1 over SSL.

I don't think that's what it means but I have to little data to go on. What 
libcurl version are you using on what platform?

-- 

  / daniel.haxx.se
