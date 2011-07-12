From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Documentation: clearly specify what refs are honored
 by core.logAllRefUpdates
Date: Tue, 12 Jul 2011 06:39:20 +0200
Message-ID: <4E1BCFF8.9030000@alum.mit.edu>
References: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 06:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgUkv-0000UZ-Se
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 06:39:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182Ab1GLEj0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 00:39:26 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53247 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923Ab1GLEj0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 00:39:26 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6C4dKlo026807
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 12 Jul 2011 06:39:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <c63583df97ff8dd596d16d4471041d6ebedb67e8.1310375571.git.bert.wesarg@googlemail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176912>

Minor typo; see below.

On 07/11/2011 11:14 AM, Bert Wesarg wrote:
> The documentation for logging updates in git-update-ref, doesn't make it
> clear that only a specific subset of refs are honored by this variable.
> 
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
> 
> ---
> 
> The initial justification in 4057deb (Junio C Hamano, 2006-10-08), leaves
> the impression, that a blacklist would have made more sense, than the
> current whitelist. Maybe we can change this?
> ---
>  Documentation/config.txt         |    4 +++-
>  Documentation/git-update-ref.txt |    5 +++--
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index c631d1c..dd44122 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -344,7 +344,9 @@ core.logAllRefUpdates::
>  	SHA1, the date/time and the reason of the update, but
>  	only when the file exists.  If this configuration
>  	variable is set to true, missing "$GIT_DIR/logs/<ref>"
> -	file is automatically created for branch heads.
> +	file is automatically created for branch heads (i.e. under
> +	refs/heads/), remote reafs (i.e. under refs/remotes/),

s/reafs/refs/

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
