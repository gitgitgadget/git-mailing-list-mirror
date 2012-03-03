From: Jeff Epler <jepler@unpythonic.net>
Subject: Re: [PATCH v2 1/3] Use startup_info->prefix rather than prefix.
Date: Sat, 3 Mar 2012 08:47:57 -0600
Message-ID: <20120303144757.GA25510@unpythonic.net>
References: <cover.1330785363.git.jaredhance@gmail.com>
 <606ef5a298db20ca54dc9a53f0e1541e94aafe57.1330785363.git.jaredhance@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jared Hance <jaredhance@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 03 15:48:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3qFj-0002kc-67
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 15:48:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789Ab2CCOsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Mar 2012 09:48:00 -0500
Received: from dsl.unpythonic.net ([206.222.212.217]:47623 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752617Ab2CCOsA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 09:48:00 -0500
Received: by unpythonic.net (Postfix, from userid 1000)
	id 7CB15114957; Sat,  3 Mar 2012 08:47:57 -0600 (CST)
Content-Disposition: inline
In-Reply-To: <606ef5a298db20ca54dc9a53f0e1541e94aafe57.1330785363.git.jaredhance@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192114>

On Sat, Mar 03, 2012 at 09:40:28AM -0500, Jared Hance wrote:
> In trace_repo_setup, prefix is passed in as startup_info->prefix. But, as
> indicated but a FIXME comment, trace_repo_setup has access to
> startup_info. The prefix parameter has therefor been eliminated.
                                         ^^^^^^^^
Trivial typo, should be "therefore".

Jeff
