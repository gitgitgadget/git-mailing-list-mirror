From: Ian Ward Comfort <icomfort@stanford.edu>
Subject: Re: [PATCH] Add a git-completion rpm subpackage to the spec
Date: Sat, 20 Mar 2010 14:01:06 -0700
Message-ID: <C774706E-5228-42F2-9DC9-094DF98D5ED2@stanford.edu>
References: <1269045134-28072-1-git-send-email-icomfort@stanford.edu> <1269109086-8887-1-git-send-email-bwalton@artsci.utoronto.ca> <7v8w9mda6l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Ben Walton <bwalton@artsci.utoronto.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 22:01:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt5nH-0003Uj-VS
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 22:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808Ab0CTVBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Mar 2010 17:01:11 -0400
Received: from smtp4.Stanford.EDU ([171.67.219.84]:43871 "EHLO
	smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751620Ab0CTVBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 17:01:09 -0400
Received: from smtp.stanford.edu (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with SMTP id 10007C5F1;
	Sat, 20 Mar 2010 14:01:09 -0700 (PDT)
Received: from rescomp.stanford.edu (rescomp.Stanford.EDU [171.67.43.194])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.stanford.edu (Postfix) with ESMTPS id CDC53C5EB;
	Sat, 20 Mar 2010 14:01:07 -0700 (PDT)
Received: from [192.168.1.110] (c-71-198-214-12.hsd1.ca.comcast.net [71.198.214.12])
	by rescomp.stanford.edu (Postfix) with ESMTP id 86E0391EF;
	Sat, 20 Mar 2010 14:01:07 -0700 (PDT)
In-Reply-To: <7v8w9mda6l.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142753>

On 20 Mar 2010, at 1:12 PM, Junio C Hamano wrote:
> Ben Walton <bwalton@artsci.utoronto.ca> writes:
>
>> Make the rpm spec file create a git-completion subpackage that
>> contains the bash completion support from the contrib/ directory.
>>
>> Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
>> ---
>>
>> This is the alternate method for shipping the bash completion  
>> support.
>> I think I personally prefer this method, but I'd be happy to see
>> either solution ship as part of the .spec file so that I don't need  
>> to
>> continue handling it separately.
>
> As long as %{_sysconfdir}/bash_completion.d/ is the appropriate  
> place for
> *all* RPM based distros, which I don't knonw, the patch looks  
> sensible.

The spec file provided by the author of bash-completion, Ian  
Macdonald, uses this path:

	http://www.caliban.org/files/redhat/SPECS/bash-completion.spec

As does the Fedora Project (including EPEL):

	http://cvs.fedoraproject.org/viewvc/rpms/bash-completion/F-13/bash-completion.spec?view=markup

	http://cvs.fedoraproject.org/viewvc/rpms/bash-completion/EL-5/bash-completion.spec?view=markup

OpenSUSE 11 does not appear to ship bash-completion:

	http://en.opensuse.org/Package_List/11.2/DVD9

But OpenSUSE 10.3 used the same path:

	http://www.novell.com/products/linuxpackages/opensuse/bash-completion.html

Mandriva uses the same path:

	http://svn.mandriva.com/cgi-bin/viewvc.cgi/packages/cooker/bash-completion/current/SPECS/bash-completion.spec?view=markup

That's all the definitive information I can find at the moment.

-- 
Ian Ward Comfort <icomfort@stanford.edu>
Systems Team Lead, Academic Computing Services, Stanford University
