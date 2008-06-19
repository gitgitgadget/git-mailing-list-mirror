From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] t7502-commit.sh: test_must_fail doesn't work with	inline
 environment variables
Date: Thu, 19 Jun 2008 12:44:23 -0500
Message-ID: <gASAIyn4TvarEmVo9rWtEKa6eROfKXwowHxH6j05FzPARJ-CDBCHLw@cipher.nrlssc.navy.mil>
References: <JvISWq5uUteLVQOl-3QkroLV8SsQufGuWrfseMUjpYY@cipher.nrlssc.navy.mil> <20080619173932.GA32593@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Jun 19 19:46:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9OD5-0003Tj-Fd
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 19:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbYFSRpN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 13:45:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755603AbYFSRpN
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 13:45:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:43979 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753515AbYFSRpM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 13:45:12 -0400
Received: by mail.nrlssc.navy.mil id m5JHiNae013308; Thu, 19 Jun 2008 12:44:23 -0500
In-Reply-To: <20080619173932.GA32593@glandium.org>
X-OriginalArrivalTime: 19 Jun 2008 17:44:23.0421 (UTC) FILETIME=[1C40F2D0:01C8D234]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85498>

Mike Hommey wrote:
> On Thu, Jun 19, 2008 at 12:32:02PM -0500, Brandon Casey wrote:
>> -	test_must_fail GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
>> +	# We intentionally do not use test_must_fail on the next line since the
>> +	# mechanism does not work when setting environment variables inline
>> +	! GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" git commit &&
> 
> Doesn't GIT_EDITOR="$(pwd)/.git/FAKE_EDITOR" test_must_fail git commit
> work ?

That leaves GIT_EDITOR set to the new value after the command completes.

-brandon
