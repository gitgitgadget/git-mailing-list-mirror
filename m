From: Ferry Huberts <mailings@hupie.com>
Subject: Re: git & patterns
Date: Thu, 19 May 2011 08:54:50 +0200
Message-ID: <4DD4BEBA.7010000@hupie.com>
References: <4DD3A402.3040802@hupie.com>	<7vsjsbbx7h.fsf@alter.siamese.dyndns.org> <4DD4B772.2050404@hupie.com> <7v62p79og8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 08:54:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMx8L-0006NT-73
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 08:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932768Ab1ESGyw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 02:54:52 -0400
Received: from 82-197-206-98.dsl.cambrium.nl ([82.197.206.98]:53022 "EHLO
	mail.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932733Ab1ESGyw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 02:54:52 -0400
Received: from stinkpad.internal.hupie.com (82-197-206-98.dsl.cambrium.nl [82.197.206.98])
	by mail.internal.Hupie.com (Postfix) with ESMTP id 0247721E69C;
	Thu, 19 May 2011 08:54:50 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Thunderbird/3.1.10
In-Reply-To: <7v62p79og8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173941>

On 05/19/2011 08:47 AM, Junio C Hamano wrote:
> Ferry Huberts <mailings@hupie.com> writes:
> 
>> - usually patterns are just patterns, without specifying what kind
> 
>> - when a pattern type is specified it most of the time is a glob pattern
>> - but sometimes it is called a shell pattern
>> - and  a few cases speak of a wildcard pattern (I think)
> 
> All these three are the same thing. I do not personally feel any strong
> need to change a lot of documentation to use only one of the terms, if
> that is what you are getting at.
> 
> What I was wondering was perhaps we may need to document the general
> principle of using globs when matching names that are hierarchically
> grouped with slash-delimited components.
> 
> The branch and tag namespaces are examples of such hiearchically grouped
> namespaces, and it is not a mere implementation detail as you seem to
> think. For jk/blame-line-porcelain and jk/diffstat-binary are both branch
> names, grouped by name initials of the author, and the globbing jk/* is a
> way to get to the group. With that grouping present, you cannot have a
> branch called "jk".

I would just argue that you layered a grouping abstraction (jk/*) on top
of something (branch and tag names) that is _conceptually_ _not_ like a path

I understand your reluctance but try to take a step back: _conceptually_
branches and tags are not paths

I don't want to push my case though :-)

-- 
Ferry Huberts
