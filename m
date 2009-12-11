From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: How to selectively recreate merge state?
Date: Fri, 11 Dec 2009 21:38:39 +0100
Message-ID: <hfuakf$fnd$1@ger.gmane.org>
References: <76718490912101556o3e2911e8t32b48c0b735fd98c@mail.gmail.com> <200912110233.18756.jnareb@gmail.com> <4B222289.6000004@drmicha.warpmail.net> <200912111220.40844.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 11 21:39:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NJCGn-0006xz-Kb
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 21:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753053AbZLKUjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2009 15:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752061AbZLKUjA
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Dec 2009 15:39:00 -0500
Received: from lo.gmane.org ([80.91.229.12]:40654 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494AbZLKUjA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2009 15:39:00 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NJCGV-0006rq-0A
	for git@vger.kernel.org; Fri, 11 Dec 2009 21:39:03 +0100
Received: from 85.93.118.17 ([85.93.118.17])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 21:39:02 +0100
Received: from bonzini by 85.93.118.17 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Dec 2009 21:39:02 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 85.93.118.17
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.4pre) Gecko/20090922 Fedora/3.0-3.9.b4.fc12 Lightning/1.0pre Thunderbird/3.0b4
In-Reply-To: <200912111220.40844.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135103>

On 12/11/2009 12:20 PM, Jakub Narebski wrote:
>> >  2 and 3 are easy (cheap) to recreate from HEAD and MERGE_HEAD, 1 is not.
>> >  I guess that's why --unresolve doesn't even attempt to do anything with 1.
> But then "git update-index --unresolve<file>" is next to useless.

Only "next to".  It can still be useful if you added a file before 
editing it, so you left in the conflict markers.

Paolo
