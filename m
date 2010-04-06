From: Vitaly Berov <vitaly.berov@gmail.com>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 19:28:04 +0400
Message-ID: <4BBB5304.1090709@gmail.com>
References: <loom.20100406T161552-321@post.gmane.org> <vpqljd062xb.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 06 17:28:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzAhr-0001uM-8Z
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 17:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755286Ab0DFP2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 11:28:41 -0400
Received: from lo.gmane.org ([80.91.229.12]:49654 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753146Ab0DFP2k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 11:28:40 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NzAhe-0001o6-OV
	for git@vger.kernel.org; Tue, 06 Apr 2010 17:28:34 +0200
Received: from 195.218.191.171 ([195.218.191.171])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 17:28:34 +0200
Received: from vitaly.berov by 195.218.191.171 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 17:28:34 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 195.218.191.171
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9pre) Gecko/20100217 Shredder/3.0.3pre
In-Reply-To: <vpqljd062xb.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144147>

On 04/06/2010 07:01 PM, Matthieu Moy wrote:
> Vitaly Berov<vitaly.berov@gmail.com>  writes:
>
>> We have quite a large repository and "git clone" takes about 6 hours. Herewith
>> "resolving deltas" takes most of the time.
>> What git does at this stage and how can we optimize it?
>
> Does running "git gc" (long, but done once and for all) on the server
> help?
>
Didn't try this one, but I'll give it a try, thanks.

And what does this stage do?
