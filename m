From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: fa/remote-svn (Re: What's cooking in git.git (Oct 2012, #01;
 Tue, 2))
Date: Thu, 4 Oct 2012 01:30:01 -0700
Message-ID: <20121004083001.GA9745@elie.Belkin>
References: <7vmx045umh.fsf@alter.siamese.dyndns.org>
 <A4A111D1488E49FFA4D71D85DD6B87A4@rr-dav.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Florian Achleitner <florian.achleitner2.6.31@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>
To: David Michael Barr <b@rr-dav.id.au>
X-From: git-owner@vger.kernel.org Fri Oct 05 00:25:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtV5-0001w8-RN
	for gcvg-git-2@plane.gmane.org; Fri, 05 Oct 2012 00:02:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965482Ab2JDIaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2012 04:30:14 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51208 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964998Ab2JDIaM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2012 04:30:12 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so366806pbb.19
        for <git@vger.kernel.org>; Thu, 04 Oct 2012 01:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=RBP1BbIahpCSdLMFV/2QI7K419bKJQu9cdV/L2EzYrU=;
        b=fyrbVXJZMGx5y9LvNhk2AcG4HgzTYgE0PnYOf826MDNVl2MiV8/IkrR0zqKfh0yzRW
         aJCaQFqKaehl451IqwoU/M9vuoQT1JueAAfBBhg/jVaHUUUXC2Gsh+kv8MxdgRqKhZAY
         kdRlPLdaH/i8FhFETnxCafHMCuWmDMYhjCG8LSF7iGHbpop0qi0o1oUOoBh1TRU1mGm0
         e/apJwfEWvaB1nJOAP/NaA0oAsQ24uIIJe4woeHQV+Tp4cKpjdNMGelL7FH11K4dJNiN
         +1KlrS5XIA3BmXQjfgMyNXPFpNy9fZTkX9PEs6kaSZlCjyzwoNhNiGLGwVxhon0ZDUB7
         JzGA==
Received: by 10.68.224.138 with SMTP id rc10mr19923144pbc.34.1349339411633;
        Thu, 04 Oct 2012 01:30:11 -0700 (PDT)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id qb2sm4007449pbb.15.2012.10.04.01.30.09
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2012 01:30:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A4A111D1488E49FFA4D71D85DD6B87A4@rr-dav.id.au>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207000>

David Michael Barr wrote:
> On Wednesday, 3 October 2012 at 9:20 AM, Junio C Hamano wrote: 

>> * fa/remote-svn (2012-09-19) 16 commits
>> - Add a test script for remote-svn
>> - remote-svn: add marks-file regeneration
>> - Add a svnrdump-simulator replaying a dump file for testing
>> - remote-svn: add incremental import
>> - remote-svn: Activate import/export-marks for fast-import
>> - Create a note for every imported commit containing svn metadata
>> - vcs-svn: add fast_export_note to create notes
>> - Allow reading svn dumps from files via file:// urls
>> - remote-svn, vcs-svn: Enable fetching to private refs
>> - When debug==1, start fast-import with "--stats" instead of "--quiet"
>> - Add documentation for the 'bidi-import' capability of remote-helpers
>> - Connect fast-import to the remote-helper via pipe, adding 'bidi-import' capability
>> - Add argv_array_detach and argv_array_free_detached
>> - Add svndump_init_fd to allow reading dumps from arbitrary FDs
>> - Add git-remote-testsvn to Makefile
>> - Implement a remote helper for svn in C
>> (this branch is used by fa/vcs-svn.)
>>
>> A GSoC project.
>> Waiting for comments from mentors and stakeholders.
>
> I have reviewed this topic and am happy with the design and implementation.
> I support this topic for inclusion.

Thanks!  I'll try moving the tests to the first patch and trying it
and hopefully send out a branch to pull tomorrow.

If I don't send anything tomorrow, that's probably a sign that I never
will, so since I like the goal of the series I guess it would be a
kind of implied ack.

Jonathan
