From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] Use cases for 'git statistics'
Date: Tue, 13 May 2008 15:07:04 +0200
Message-ID: <200805131507.04912.jnareb@gmail.com>
References: <bd6139dc0805080851y2065bedfsf0f388cfd6d85929@mail.gmail.com> <200805121440.12836.jnareb@gmail.com> <bd6139dc0805120604m349b1fbbr39c6dcb8d893e771@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Sverre Rabbelier" <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 15:08:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvuEe-0007YW-Bo
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 15:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756209AbYEMNHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 09:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755815AbYEMNHN
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 09:07:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:12733 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754637AbYEMNHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 09:07:12 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2144165fgg.17
        for <git@vger.kernel.org>; Tue, 13 May 2008 06:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=+bK650C93Uezdk/6hDzs4tsWYJ19ZSSPd4ADzViUK+A=;
        b=ZWL5P1q0AqM/VUtOSageJyF4FKnKg5ToTaU0A0hsviwkiWCz9Sg7cb4yKgzACH16CwjK8b08nkOAv1KQwp7xsR+NbWmUSYIM+8bputXkFF71iUGrsZ2khAey9FbXcubT6QlwGpavv5wFvGphcX/lUbf7raudz86HLVJEb3l+qZE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=C9rqfI7/R0tOfFzXO6N6eJ2nnDaQ9Um8Pj0UpL3LOV8v6HWDKipJr1W1GATmoZ7804Z9UPYuAKGMdgFTZkRv9hrX9KffYucJD2afGUv7Txm2pHU4t3XA66fRGeHTq7v+rB+QpDNFyDb45JdbWf6ldmlpXMr2P0rQ17T8q8dHi4o=
Received: by 10.86.4.2 with SMTP id 2mr14311632fgd.40.1210684029737;
        Tue, 13 May 2008 06:07:09 -0700 (PDT)
Received: from ?192.168.1.15? ( [83.8.213.214])
        by mx.google.com with ESMTPS id l19sm7744392fgb.9.2008.05.13.06.07.06
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 13 May 2008 06:07:08 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <bd6139dc0805120604m349b1fbbr39c6dcb8d893e771@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82027>

On Mon, 12 May 2008, Sverre Rabbelier wrote:
> [Sorry, I hit 'send' instead of 'save']

And now you apparently forgot to add git mailing list to receipients...

> On Mon, May 12, 2008 at 2:40 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>>  This is, IMHO, the most complex example (at least to do properly).
>>  It begins with: does given author have code touching given subsystem
>>  (i.e. is it for him/her new contribution wrt. subsystem)? How many
>>  commits he/she has affecting given subsystem? How often he/she rewrites
>>  code? How many bugs were introduced?
> 
> Ah, there is a lot more to this example than I thought. Perhaps this
> data could all be shown and then, using some "importance" metric per
> item a "grade" can be calculated?

Weighting different statistics, bayesian hypotesis/filtering, expert
system, machine learning... I guess that would be quite a work to do
it well.  Probably would require to calculate and adjust scoring of code
(difficulity) and authors (skill), and matching them...

This is certainly in the "wishlist" scope.

>>  Details I think need to be provided by maintainer...
> 
> Do you mean Junio, or the user of the program?

I mean that all I can provide is speculation.  I'm not, and never was
a maintainer of OSS project, and I don't know what criteria one use
(perhaps unvoiced criteria) to decide whether given patch needs to be
examined more closely, or the cursory browsing should be enough.

>>>>  * Contributor: what happened with my code?
>>>
>>> Do you mean a "track my code" like feature? Showing the movement of a
>>> particular piece of code through the code? (Displaying information
>>> like "moved from foo.c to bar.c in commit 0123456789abcd"?)
>>
>>  I was thinking there about "git blame --reverse".
> 
> Do you mean, filter it's output for a specific user?

I mean, given the code at given version, what happened to this code?
Filtering "git blame --reverse" by user might be one way of solving it.

>>>>  * Searching where to contribute: what are oldest part of code dealing
>>>>   with error messages (find ancient code)?
>>>>
>> Or find the lines with oldest modification stamp with "die" or "warn",
>> or find which messages are oldest, even if wrapper have changed.
> 
> In that case, perhaps a regexp would be more suitable, to allow the
> user to search for any specific line, not just "die" or "warn"?

What I had in mind here, but didn't explain clear enough, was an
extension to pickaxe search.  You want to find when current error
message was created, even if the way of handling it (fprintf vs. die)
changed, or if code was indented, or was moved.

Or find all error messages, in the order they were created, for example
in git case to find ancient error messages and replace it by something
more user-friendly (or less selective about choosing friends ;-).

>>  P.S. I wonder how hard to be to plug-in such SCM statistic system
>>  into something like project management, see
>>   "Joel On Software: Evidence based scheduling" (of programming tasks)
>>   http://www.joelonsoftware.com/items/2007/10/26.html
> 
> Interesting article, I think integrating statistics
> (http://www.statsvn.org/ for example) can be a very powerful tool for
> project management.

You meant http://git.koha.org/gitstat/, didn't you? ;-P

Siriously, what I had in mind was to integrate author dates and commit
dates into project management system scheduling.

-- 
Jakub Narebski
Poland
