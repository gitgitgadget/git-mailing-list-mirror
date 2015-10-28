From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 3/3] clone: Allow an explicit argument for parallel
 submodule clones
Date: Wed, 28 Oct 2015 22:03:46 +0100
Message-ID: <56313832.4000002@gmail.com>
References: <1445625879-30330-1-git-send-email-sbeller@google.com>
 <1445625879-30330-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 22:04:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrXtC-0004F6-0S
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 22:04:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbbJ1VEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 17:04:05 -0400
Received: from plane.gmane.org ([80.91.229.3]:48117 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932442AbbJ1VEE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 17:04:04 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ZrXt3-00048S-9g
	for git@vger.kernel.org; Wed, 28 Oct 2015 22:04:01 +0100
Received: from p548d6c52.dip0.t-ipconnect.de ([84.141.108.82])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 22:04:01 +0100
Received: from sschuberth by p548d6c52.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 22:04:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p548d6c52.dip0.t-ipconnect.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <1445625879-30330-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280395>

On 23.10.2015 20:44, Stefan Beller wrote:

> [...] which may pick reasonable
> defaults if you don't specify an explicit number.

IMO the above should also be mentioned ini the docs:

> +-j::
> +--jobs::
> +	The number of submodules fetched at the same time.

Otherwise, from reading the docs, my immediate question would be "What's 
the default for n if not specified?"

-- 
Sebastian Schuberth
