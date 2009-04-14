From: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
Subject: Re: git init permissions?
Date: Tue, 14 Apr 2009 21:35:52 +0200
Message-ID: <49E4E598.6050505@pelagic.nl>
References: <49E4D16E.9050500@pelagic.nl> <200904142047.21810.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jk@jk.gs
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue Apr 14 21:38:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtoSO-0001AZ-OI
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 21:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbZDNTf5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 15:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753739AbZDNTf4
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 15:35:56 -0400
Received: from hupie.xs4all.nl ([82.95.241.251]:38885 "EHLO
	Lighthouse.internal.Hupie.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753479AbZDNTfz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Apr 2009 15:35:55 -0400
Received: from [192.168.0.51] (unknown [192.168.0.51])
	by Lighthouse.internal.Hupie.com (Postfix) with ESMTP id B182958BDA0;
	Tue, 14 Apr 2009 21:35:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <200904142047.21810.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116558>

Johan Herland wrote:
> On Tuesday 14 April 2009, Ferry Huberts (Pelagic) wrote:
>> I'm looking at the git init --shared=group result and see:
>>
>> drwxrwsr-x 7 ferry ferry  111 2009-04-14 19:51 .
>> drwxrwxr-x 3 ferry ferry   17 2009-04-14 19:51 ..
>> drwxrwxr-x 2 ferry ferry    6 2009-04-14 19:51 branches
>> -rw-rw-r-- 1 ferry ferry  127 2009-04-14 19:51 config
>> -rw-rw-r-- 1 ferry ferry   58 2009-04-14 19:51 description
>> -rw-rw-r-- 1 ferry ferry   23 2009-04-14 19:51 HEAD
>> drwxrwxr-x 2 ferry ferry 4.0K 2009-04-14 19:51 hooks
>> drwxrwxr-x 2 ferry ferry   20 2009-04-14 19:51 info
>> drwxrwsr-x 4 ferry ferry   28 2009-04-14 19:51 objects
>> drwxrwsr-x 4 ferry ferry   29 2009-04-14 19:51 refs
>>
>> Is there some kind of reason that the branches directory is
>> not created with +s permissions?
>>
>> I can understand it for the hooks and info directories since
>> you can not push into those. You _can_ however push into
>> branches and I would expect it to have +s too, like objects
>> and refs.
>>
>> Bug or my misunderstanding?
>>
>> git version 1.6.0.6
> 
> This was caused by the template files not getting adjusted permissions set 
> correctly when copied into a new repository (by git init).
> 
> This has been fixed (along with other --shared issues) in v1.6.2.3. Please 
> upgrade, if possible.
> 

unfortunately that's not possible since I'm on RHEL.

thanks for the asnwers guys!
