From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sun, 13 Feb 2011 19:09:20 -0800
Message-ID: <4D589CE0.7020203@pcharlan.com>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com> <20110213193738.GA26868@elie> <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 14 04:10:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Poop5-0003NY-FV
	for gcvg-git-2@lo.gmane.org; Mon, 14 Feb 2011 04:09:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab1BNDJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Feb 2011 22:09:54 -0500
Received: from hapkido.dreamhost.com ([66.33.216.122]:37300 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754202Ab1BNDJx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Feb 2011 22:09:53 -0500
Received: from homiemail-a79.g.dreamhost.com (caibbdcaaaaf.dreamhost.com [208.113.200.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 3839117AC0A
	for <git@vger.kernel.org>; Sun, 13 Feb 2011 19:09:53 -0800 (PST)
Received: from homiemail-a79.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a79.g.dreamhost.com (Postfix) with ESMTP id 8EAC87D4058;
	Sun, 13 Feb 2011 19:09:20 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pcharlan.com; h=message-id:date
	:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; q=dns; s=pcharlan.com;
	 b=aZX6fd711/VwdkwfPa/ZK4zz97+kdHgat6z0yZ39y9tV4lahGTHpShd8iqvDQ
	esRPzxySbZLds6q4QA529qmQK9JTqN099XcqpEvF89d97J/RSTQ6mUQTMJjPim6v
	nHdM9HU5KDJfoeeIpKzTtYQme4F/+O8TKNRDVbxZCyqWKM=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pcharlan.com; h=message-id
	:date:from:mime-version:to:cc:subject:references:in-reply-to
	:content-type:content-transfer-encoding; s=pcharlan.com; bh=9wXf
	2X4I0tnGdPwTQMY0FwCbVCA=; b=mFoKkE0N3myM7rRYT+KTl7L/YZ5wDI78g/Cj
	0eZL3uD9R5Deg3RYQqPr222/zSzMWFWo0/P4FMDnmK215ETEPpMcVgdiKGp8jStw
	I3UkJvMPKslMTcLLXFAYEbotTgkH3sc5PsR05c1eQr4xF8x9YvH2dhq6lWfAmxpg
	4rDD8j4=
Received: from [192.168.0.101] (185.132-78-65.ftth.swbr.surewest.net [65.78.132.185])
	(Authenticated sender: pete@tento.net)
	by homiemail-a79.g.dreamhost.com (Postfix) with ESMTPA id 65B9C7D4057;
	Sun, 13 Feb 2011 19:09:20 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166686>

On 02/13/2011 02:58 PM, Junio C Hamano wrote:
>> --staged
>> ~~~~~~~~
>> diff takes --staged, but that is only to support some people's habits.
> The term "stage" comes from "staging area", a term people used to explain
> the concept of the index by saying "The index holds set of contents to be
> made into the next commit; it is _like_ the staging area".
> 
> My feeling is that "to stage" is primarily used, outside "git" circle, as
> a logistics term.  If you find it easier to visualize the concept of the
> index with "staging area" ("an area where troops and equipment in transit
> are assembled before a military operation", you may find it easier to say
> "stage this path ('git add path')", instead of "adding to the set of
> contents...".

FWIW, when teaching Git I have found that users immediately understand
"staging area", while "index" and "cache" confuse them.

"Index" means to them a numerical index into a data structure.
"Cache" is a local copy of something that exists remotely.  Neither
word describes the concept correctly from a user's perspective.

I learned long ago to type "index" and "cached", but when talking (and
thinking) about Git I find "the staging area" gets the point across
very clearly and moves Git from interesting techie-tool to
world-dominating SCM territory.  I'm surprised that that experience
isn't universal.

--Pete
