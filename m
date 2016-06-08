From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v4 3/3] doc: more consistency in environment variables
 format
Date: Wed, 8 Jun 2016 08:56:52 +0200
Message-ID: <5757C1B4.5060709@kdbg.org>
References: <20160606100905.23006-1-tom.russello@grenoble-inp.org>
 <20160607223507.18061-1-tom.russello@grenoble-inp.org>
 <20160607223507.18061-4-tom.russello@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, erwan.mathoniere@grenoble-inp.org,
	matthieu.moy@grenoble-inp.fr, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, gitster@pobox.com
To: Tom Russello <tom.russello@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 08:57:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAXQK-00037z-9U
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 08:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbcFHG44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 02:56:56 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:40957 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753046AbcFHG4z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 02:56:55 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rPfPK2kM3z5tlW;
	Wed,  8 Jun 2016 08:56:53 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id 57FC952AE;
	Wed,  8 Jun 2016 08:56:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <20160607223507.18061-4-tom.russello@grenoble-inp.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296758>

Am 08.06.2016 um 00:35 schrieb Tom Russello:
> Wrap with backticks (monospaced font) unwrapped or single-quotes wrapped
> (italic type) environment variables which are followed by the word
> "environment". It was obtained with:
>
> perl -pi -e "s/\'?(\\\$?[0-9A-Z\_]+)\'?(?= environment ?)/\`\1\`/g" *.txt
>
> One of the main purposes is to stick to the CodingGuidelines as possible so
> that people writting new documentation by mimicking the existing are more likely
> to have it right (even if they didn't read the CodingGuidelines).
>
> Signed-off-by: Tom Russello <tom.russello@grenoble-inp.org>
> Signed-off-by: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
> Signed-off-by: Samuel Groot <samuel.groot@grenoble-inp.org>
> Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> ---
> One reason behind the creation of this patch is that patch [2/3] led to minor
> inconsistencies in some sentences as it only deals with GIT_* environment
> variables and let others unchanged (for example `GIT_ASKPASS` and 'SSH_ASKPASS'
> in Documentation/config.txt).
>
> For this one, I had to manually change GIT_AUTHOR_DATE
> (Documentation/date-formats.txt - l.4) and GIT_EXTERNAL_DIFF
> (Documentation/diff-generate-patch.txt - l.9) as the perl command didn't manage
> these cases and so created minor inconsistencies.

This last paragraph should go into the commit message.

Also, you should investigate cases where "environment" is at the 
beginning of a line, because then the variable name is most likely at 
the end of the previous line. At the least, you missed an occurrence of 
GIT_EXTERNAL_DIFF in diff-config.txt.

-- Hannes
