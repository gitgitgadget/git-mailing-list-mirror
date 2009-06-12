From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH] parse-options: add parse_options_check to validate	option
 specs.
Date: Fri, 12 Jun 2009 23:25:57 +0200
Message-ID: <4A32C7E5.5090604@lsrfire.ath.cx>
References: <7vd49ewfsi.fsf@alter.siamese.dyndns.org> <1244535824-11970-1-git-send-email-madcoder@debian.org> <20090612193156.GC3129@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@madism.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 23:26:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFEGs-0000pG-4t
	for gcvg-git-2@gmane.org; Fri, 12 Jun 2009 23:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933174AbZFLV0B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2009 17:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933123AbZFLV0B
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Jun 2009 17:26:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:59033 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933109AbZFLV0A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2009 17:26:00 -0400
Received: from [10.0.1.101] (p57B7F2AE.dip.t-dialin.net [87.183.242.174])
	by india601.server4you.de (Postfix) with ESMTPSA id 5ACFF2F8069;
	Fri, 12 Jun 2009 23:26:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090612193156.GC3129@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121451>

Pierre Habouzit schrieb:
> On Tue, Jun 09, 2009 at 10:23:44AM +0200, Pierre Habouzit wrote:
>> It only searches for now for the dreaded LASTARG_DEFAULT | OPTARG
>> combination, but can be extended to check for any other forbidden
>> combination.
>>
>> Options are checked each time we call parse_options_start.
>>
>> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
>> ---
>>  parse-options.c |   24 ++++++++++++++++++++++++
>>  1 files changed, 24 insertions(+), 0 deletions(-)
> 
> Has this patch been missed, or has it any kind of flaw that _I_ missed ?
> :)
> 

It's in master (cb9d398c).
