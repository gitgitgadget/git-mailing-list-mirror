From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: [PATCH next] test-lib: set $DIFF to diff if it is unset
Date: Fri, 11 Jun 2010 11:26:16 -0500
Message-ID: <iUCxSq8AkQcB-kKuhJbfBTktKHW01RLx8KAu4BZwAUKZkkBhiPlxTg@cipher.nrlssc.navy.mil>
References: <06ffbe0ca6aac061336f6f595e89f75c09ab88ac.1276162629.git.trast@student.ethz.ch> <I5rdmhJblm27JnzIPi7xP5KmntXzA3-wGL-IGXejOPAurGsMke2J3g@cipher.nrlssc.navy.mil> <7vhbl9k0jv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 11 18:27:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ON74b-0006MA-Qa
	for gcvg-git-2@lo.gmane.org; Fri, 11 Jun 2010 18:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754168Ab0FKQ1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jun 2010 12:27:08 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:38210 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997Ab0FKQ1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jun 2010 12:27:07 -0400
Received: by mail.nrlssc.navy.mil id o5BGQHeG018433; Fri, 11 Jun 2010 11:26:17 -0500
In-Reply-To: <7vhbl9k0jv.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 11 Jun 2010 16:26:17.0311 (UTC) FILETIME=[D15CCEF0:01CB0982]
X-Virus-Scanned: clamav-milter 0.95.3 at mail1
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148960>

On 06/11/2010 11:15 AM, Junio C Hamano wrote:
> Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil> writes:
> 
>> I think what should be done instead, is to move this section
>> down below the line where GIT-BUILD-OPTIONS is sourced.  That
>> way, the value of $DIFF can be gotten from that file.
>>
>> I guess GIT_TEST_CMP and GIT_TEST_CMP_USE_COPIED_CONTEXT
>> should be written into GIT-BUILD-OPTIONS too.
> 
> I like that.  Something like this?

Looks good, will test.

-brandon
