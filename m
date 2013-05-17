From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-bzr: update old organization
Date: Fri, 17 May 2013 12:12:25 -0500
Message-ID: <CAMP44s2DogT71+cQJK8Yu0xcAbuYB-6T3TwMKyuh12wCR+sK8g@mail.gmail.com>
References: <1368505227-16661-1-git-send-email-felipe.contreras@gmail.com>
	<CABLWAfStOZvKZzsCqb+UiedA7Ra-ermyRJVAeocBE=RdXL8B2w@mail.gmail.com>
	<CAMP44s3zXLwHu0OhLKsoerHaoBGMf66hNJ=hvOiUVAe4+=hDiA@mail.gmail.com>
	<7vzjvtzg61.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sandor Bodo-Merle <sbodomerle@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 19:12:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdOCm-00060w-BM
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 19:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756104Ab3EQRM1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 13:12:27 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36768 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755940Ab3EQRM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 13:12:27 -0400
Received: by mail-lb0-f175.google.com with SMTP id v10so4653937lbd.34
        for <git@vger.kernel.org>; Fri, 17 May 2013 10:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=6RNvRsWylKGi2e289W3l0iQWVmMVLFg2EmuDwrhh2GE=;
        b=gML1qBqVvorGB8FURRh8Bl8v/EcYljr/2ll+I9NHK+HAE5Ed6/jk2zS9B4BgNJVUJs
         IvOqQyJZkBgymxgcD12BYExZ0M0rCG/6yZdtj02Vmljh6n+ix4yVE2nt8SxQwJga6b5i
         /Mfdm1ITm24jUe2AVtF+wOWY75a6qwFhUmxSCkw4pxIujrq8xkMsjvpjlCPzzufAhW//
         ZSiqjr8mYHF5nGOLNR+qSGKwA8KPs70VyYq1HMSrA4lJ74hJ/2tHoTrBGdKRnVC3l63C
         JiraV+R+IaxeMpSkEP6MyzY7P00ExX2dx20FFkCj5AdLN+/RM95+HtPgyAmUZX5Az6qs
         0plA==
X-Received: by 10.112.172.40 with SMTP id az8mr11891895lbc.88.1368810745594;
 Fri, 17 May 2013 10:12:25 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Fri, 17 May 2013 10:12:25 -0700 (PDT)
In-Reply-To: <7vzjvtzg61.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224709>

On Fri, May 17, 2013 at 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> On Fri, May 17, 2013 at 5:02 AM, Sandor Bodo-Merle <sbodomerle@gmail.com> wrote:
>>
>>> apparently this breaks my existing clone of the bugzilla repository, where i
>>> have branches cloned with versions of remote-bzr prior 1.8.2 and after. The
>>> erro iget is:
>>>
>>> Fetching origin
>>> Traceback (most recent call last):
>>>   File "/home/bms/bin/git-remote-bzr", line 956, in <module>
>>>     sys.exit(main(sys.argv))
>>>   File "/home/bms/bin/git-remote-bzr", line 928, in main
>>>     repo = get_repo(url, alias)
>>>   File "/home/bms/bin/git-remote-bzr", line 844, in get_repo
>>>     bdir.destroy_repository()
>>>   File "/usr/lib/python2.7/dist-packages/bzrlib/bzrdir.py", line 900, in
>>> destroy_repository
>>>     raise errors.NoRepositoryPresent(self)
>>> bzrlib.errors.NoRepositoryPresent: No repository present:
>>> "file:///home/bms/workspace/bugzilla/.git/bzr/origin/clone/"
>>> error: Could not fetch origin
>>>
>>>
>>> The following small patch seems to fix my regression:
>>
>> The patch is fine by me, in fact, I already had that patch, but
>> somehow could not trigger the exception, so I removed it.
>
> Is it merely "fine", or needed for 1.8.3?  I am guessing it is the
> latter but making a final double-check, as I'll be stopping to pick
> up patches from the list in order to start today's integration run
> (that includes tagging 1.8.3-rc3).

Yes, for v1.8.3.

-- 
Felipe Contreras
