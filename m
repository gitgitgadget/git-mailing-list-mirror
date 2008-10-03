From: David Bryson <david@statichacks.org>
Subject: Re: [PATCH] Use "git_config_string" to simplify "remote.c" code in
	"handle_config"
Date: Fri, 3 Oct 2008 13:06:13 -0700
Message-ID: <20081003200613.GO20571@eratosthenes.cryptobackpack.org>
References: <20081003033937.GA11594@eratosthenes.cryptobackpack.org> <48E5AD8A.4070301@op5.se>
Reply-To: David Bryson <david@statichacks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:07:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Klqvv-00042Y-Ae
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 22:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072AbYJCUGP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 16:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbYJCUGP
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 16:06:15 -0400
Received: from cryptobackpack.org ([64.105.32.74]:56994 "EHLO
	mail.cryptobackpack.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752980AbYJCUGO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 16:06:14 -0400
Received: by mail.cryptobackpack.org (Postfix, from userid 1000)
	id 428D610D0248; Fri,  3 Oct 2008 13:06:14 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.2.1-gr1 (2007-05-02) on
	ptolemy.cryptobackpack.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.1-gr1
Received: from eratosthenes.statichacks.org (heliosphan.cryptobackpack.org [10.6.6.6])
	by mail.cryptobackpack.org (Postfix) with ESMTP id 7839110D0023;
	Fri,  3 Oct 2008 13:06:13 -0700 (PDT)
Received: by eratosthenes.statichacks.org (Postfix, from userid 1000)
	id 5F87E983B9; Fri,  3 Oct 2008 13:06:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48E5AD8A.4070301@op5.se>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97449>

On Fri, Oct 03, 2008 at 07:28:42AM +0200 or thereabouts, Andreas Ericsson wrote:
> David Bryson wrote:
>> Signed-off-by: David Bryson <david@statichacks.org>
>> I tried to keep with the naming/coding conventions that I found in
>> remote.c.  Feedback welcome.
>> ---
>>  remote.c |   19 ++++++++++---------
>>  1 files changed, 10 insertions(+), 9 deletions(-)
>> diff --git a/remote.c b/remote.c
>> index 3f3c789..893a739 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -305,6 +305,7 @@ static int handle_config(const char *key, const char 
>> *value, void *cb)
>>  {
>>  	const char *name;
>>  	const char *subkey;
>> +	const char *v;
>
>
> Not very mnemonic. I'm sure you can think up a better name, even if it's
> a long one. Git is notoriously sparse when it comes to comments. We rely
> instead on self-explanatory code.
>

Oh I agree entirely, it is quite vague, however like I mentioned I tried
to keep to the conventios in the file.  This strategy(v) is used in several
other places in remote.c, if this is Bad Code, then I have no problem
changing it.

Thoughts from anybody else ?
