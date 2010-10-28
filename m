From: Kevin Ballard <kevin@sb.org>
Subject: Re: Why the default action for pull is merge, but not rebase?
Date: Thu, 28 Oct 2010 00:13:55 -0700
Message-ID: <3DEE5D82-AC23-45AD-B02D-DA3D6998CABC@sb.org>
References: <20101027173644.GB15657@burratino> <0016e645b8c87a160804939cdc5e@google.com> <20101027180541.GA20527@burratino> <4CC87DE6.9090604@nextest.com> <4CC8E5B5.7050404@workspacewhiz.com> <78EBA946-B3BA-458B-9528-C5F80872B3E0@sb.org> <4CC91AA6.2000301@nextest.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Euguess@gmail.com" <Euguess@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Eric Raible <raible@nextest.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 09:14:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBMga-0008GF-H9
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 09:14:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755495Ab0J1HOB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 03:14:01 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57923 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327Ab0J1HOA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 03:14:00 -0400
Received: by gwj21 with SMTP id 21so1000943gwj.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 00:13:59 -0700 (PDT)
Received: by 10.90.20.6 with SMTP id 6mr2220303agt.200.1288250039581;
        Thu, 28 Oct 2010 00:13:59 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id b22sm794028anb.15.2010.10.28.00.13.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Oct 2010 00:13:58 -0700 (PDT)
In-Reply-To: <4CC91AA6.2000301@nextest.com>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160160>

On Oct 27, 2010, at 11:39 PM, Eric Raible wrote:

> On 10/27/2010 8:27 PM, Kevin Ballard wrote:
>> On Oct 27, 2010, at 7:53 PM, Joshua Jensen wrote:
>> 
>>> ----- Original Message -----
>>> From: Eric Raible
>>> Date: 10/27/2010 1:30 PM
>>>> 
>>>> I would much prefer if branch.<name>.rebase was allowed to
>>>> specify the arguments to be passed to rebase:
>>>> 
>>>> 	git config branch.mybranch.rebase "-i --preserve-merges"
>>>> 
>>>> Anyone else see the value of something like this?
>>> When --preserve-merges actually preserves the merges (perhaps the rebase-i-p branch is on the way to finishing this feature??  I couldn't get it to apply...), I would like this facility very much.  By default, I think rebase *should* preserve merges, and the current flattening it does now should be an option.
>> 
>> Sure would be nice, but that sort of backwards-incompatible change would likely break a lot of people who rely on the current flattening behavior.
>> 
>> -Kevin Ballard.
> 
> But it's not backwards incompatible: only true/false are now
> allowed so an arbitrary string would not currently be used.
> 
> In my proposal a string would imply true, and would mean
> "append the specified value when running rebase".

Sorry, I meant making it the default would be a backwards-incompatible change.

-Kevin Ballard