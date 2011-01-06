From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH 2/3] t0001,t1510,t3301: use sane_unset which always returns
 with status 0
Date: Thu, 06 Jan 2011 15:39:26 -0600
Message-ID: <ma1kTwntNDX512DVaUWbBvJaymY_6kS-s_jNuypXDSaVoyGytOK_DA@cipher.nrlssc.navy.mil>
References: <gmeXEearzUOUEst4-B2b8sVUo0XhywYUDm7rCJikom1xi9tIroh9GnJRv-bJTzbCbvqI-4DOU3A@cipher.nrlssc.navy.mil> <gmeXEearzUOUEst4-B2b8nKnIcuDy8iOxR9s9wmOFYzBZT5rwFSFsnedLx8orqTDP1ztkJap7K8@cipher.nrlssc.navy.mil> <7vlj2xai2v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 22:39:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaxYe-0008BG-Ny
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 22:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab1AFVji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 16:39:38 -0500
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43992 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751649Ab1AFVjh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 16:39:37 -0500
Received: by mail.nrlssc.navy.mil id p06LdQAr030502; Thu, 6 Jan 2011 15:39:26 -0600
In-Reply-To: <7vlj2xai2v.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Jan 2011 21:39:26.0105 (UTC) FILETIME=[30B10090:01CBADEA]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164676>

On 01/06/2011 02:32 PM, Junio C Hamano wrote:
> Thanks; there are a bit more from 
> 
>  $git grep -n -e '^[ 	]*unset[ 	].*&&' t
> 
> * t/t9130-git-svn-authors-file.sh:101:		unset GIT_CONFIG &&
> 
> As far as I can tell, this is unsafe; nobody has set GIT_CONFIG up to this
> point.

Ah, svn isn't installed on the Solaris box I tested on, so
this test wasn't run.

-Brandon
