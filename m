From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 16/19] git-check-attr: Add an --all option to show all
 attributes
Date: Thu, 28 Jul 2011 06:31:07 +0200
Message-ID: <4E30E60B.1060604@alum.mit.edu>
References: <1311689582-3116-1-git-send-email-mhagger@alum.mit.edu> <1311689582-3116-17-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Jul 28 06:31:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmIFh-0001UA-Ol
	for gcvg-git-2@lo.gmane.org; Thu, 28 Jul 2011 06:31:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676Ab1G1EbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jul 2011 00:31:13 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:55311 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007Ab1G1EbM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2011 00:31:12 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p6S4V7K5006042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 28 Jul 2011 06:31:07 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.18) Gecko/20110617 Lightning/1.0b2 Thunderbird/3.1.11
In-Reply-To: <1311689582-3116-17-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178006>

On 07/26/2011 04:12 PM, Michael Haggerty wrote:
> Add new usage patterns
> 
>     git check-attr --all [--] pathname...
>     git check-attr --stdin --all < <list-of-paths>
> 
> which display all attributes associated with the specified file(s).

I realized that I also added the synonym "-a" but forgot to mention it
in the docs or commit message.  I will fix this in the next version of
the patch series.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
