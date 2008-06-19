From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7502-commit.sh: test_must_fail doesn't work with	inline
 environment variables
Date: Thu, 19 Jun 2008 13:12:02 -0500
Message-ID: <-l_oe9PTh99x_C1EHrrbpmJc3l75joqJVNOzSICatedVnoX0-mlWkw@cipher.nrlssc.navy.mil>
References: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil> <20080619173932.GA32593@glandium.org> <gASAIyn4TvarEmVo9rWtEKa6eROfKXwowHxH6j05FzPARJ-CDBCHLw@cipher.nrlssc.navy.mil> <20080619175639.GA1604@glandium.org> <frLVfPcFTL8gWg3cEzx3q-MMBWxW3Ts2EnBH2U39k5_QFQTfThtN-A@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:14:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Ods-0005jC-Ht
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:13:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbYFSSM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbYFSSM4
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:12:56 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:56687 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337AbYFSSM4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:12:56 -0400
Received: by mail.nrlssc.navy.mil id m5JIC3eE016095; Thu, 19 Jun 2008 13:12:03 -0500
In-Reply-To: <frLVfPcFTL8gWg3cEzx3q-MMBWxW3Ts2EnBH2U39k5_QFQTfThtN-A@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 19 Jun 2008 18:12:02.0875 (UTC) FILETIME=[F95D88B0:01C8D237]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85502>

Brandon Casey wrote:

> If I change #!/bin/sh to #!/bin/bash I get what is expected:
> 
> foo: yo adrian
> foo: wo adrian
> 
> #!/bin/ksh
> foo:
> foo: yo adrian

Unless I'm on solaris, then #!/bin/ksh gives me the same result
as bash:

foo: yo adrian
foo: wo adrian

-brandon
