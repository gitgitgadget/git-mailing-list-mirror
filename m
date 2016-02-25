From: Felipe =?utf-8?b?R29uw6dhbHZlcw==?= Assis 
	<felipeg.assis@gmail.com>
Subject: Re: [PATCH 1/5] Documentation/diff-config: fix description of diff.renames
Date: Thu, 25 Feb 2016 17:27:02 +0000 (UTC)
Message-ID: <loom.20160225T181310-74@post.gmane.org>
References: <1456249498-3232-1-git-send-email-Matthieu.Moy@imag.fr> <1456249498-3232-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 25 18:30:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYzjy-0006m3-ET
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 18:30:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932938AbcBYRaI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 12:30:08 -0500
Received: from plane.gmane.org ([80.91.229.3]:37366 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760375AbcBYRaH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 12:30:07 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aYzjo-0006fa-Kx
	for git@vger.kernel.org; Thu, 25 Feb 2016 18:30:05 +0100
Received: from gate-tx3.freescale.com ([192.88.168.1])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 18:30:04 +0100
Received: from felipeg.assis by gate-tx3.freescale.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 25 Feb 2016 18:30:04 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.88.168.1 (Mozilla/5.0 (Windows NT 6.1; WOW64; rv:44.0) Gecko/20100101 Firefox/44.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287401>

Matthieu Moy <Matthieu.Moy <at> imag.fr> writes:

>  diff.renames::
> -	Tells Git to detect renames.  If set to any boolean value, it
> -	will enable basic rename detection.  If set to "copies" or
> -	"copy", it will detect copies, as well.
> +	Whether and how Git detects renames.  If set to "false",
> +	rename detection is disabled. If set to "true", basic rename
> +	detection is enable.  If set to "copies" or "copy", Git will
> +	detect copies, as well.  Defaults to false.

Just a minor typo: s/enable/enabled/
Also, there is only one space between the second and third sentences.

Just in case you haven't already fixed that.

Regards,
Felipe
