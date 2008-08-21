From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC v2] Git User's Survey 2008
Date: Thu, 21 Aug 2008 13:19:43 +0200
Message-ID: <200808211319.43847.jnareb@gmail.com>
References: <200807230325.04184.jnareb@gmail.com> <200808210330.44908.jnareb@gmail.com> <7vljyrkqq6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 13:20:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KW8Cw-0005Gi-4f
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 13:20:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757872AbYHULSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 07:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759225AbYHULSk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 07:18:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:42682 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757694AbYHULSj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 07:18:39 -0400
Received: by nf-out-0910.google.com with SMTP id d3so443811nfc.21
        for <git@vger.kernel.org>; Thu, 21 Aug 2008 04:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=LjtlMSxisxCfxMcG+8XJi5KycyjkQ8MHPmsgDIlw7hU=;
        b=TekAVBnCiAMg6j1jNJVV3LhOicXljMuCe5FAYvkFbVcjbIlm7DCqEgPffy5T/w8uLR
         OGH7X3Z5zVxq1un+o8oJi0kVNQEyS7mP9xkG5GIHji6nKbcZEDc/Xbd7tvTzUh5ZYxAV
         QMpE0mqvNX6SCut6mrqds1fi9aRmFQD7YL0Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Lwxe+Kf8Um/+skp9c5hf2WGduG25Sx9Qz5+FkjScKEGJvuzLqQcnIDrw3SunT32O/Z
         orEeg3ByoK3Kr3WLDEVAq0nbHVMuU7TtyH3NEVQ9htR3Eu9fE7yP5p2wbPhwhUJrVMcf
         VwWzLK7Ri6HX04tNrxGsi7jqw5ypEENI5ch/E=
Received: by 10.210.75.6 with SMTP id x6mr1762238eba.120.1219317517791;
        Thu, 21 Aug 2008 04:18:37 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.232.114])
        by mx.google.com with ESMTPS id k9sm7059008nfh.23.2008.08.21.04.18.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 21 Aug 2008 04:18:36 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vljyrkqq6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93136>

On Thu, 21 Aug 2008, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>>>>    xx. Which Git version(s) are you using?
>>>>        (zero or more, multiple choice:
>>>>         one can use different versions on different machines)
>>>>      - pre 1.3, 1.3, 1.4, 1.5, 1.6, master, next
>>>>      + might be important when checking "what did you find hardest" etc.
>>> 
>>> This is a very good idea.  "What is hardest" grouped by "How proficient
>>> are you with git".
>>
>> Errr... I didn't add "How proficient are you with git?" question to
>> Git User's Survey 2008, but I think I would.
> 
> I meant that "how long have you been using" already has a strong correlation
> to the proficiency (iow I did not mean to suggest adding a new question).

Well, it is here...

>>> s/separate worktree/& (git-new-workdir)/;
>>
>> Or core.worktree.
> 
> As I personally do not think there is any sane usecase that *must* use
> core.worktree and/or GIT_WORK_TREE, I took "separate worktree" as "having
> two or more worktree on the same repository via new-workdir mechanism",
> but you meant core.worktree.  It shows the question is ill-stated that
> there are confusion even between us.

Actually I meant here ability to work with worktree which doesn't have
repository embedded into it, in '.git' directory in top directory of
the worktree.

The ability to work with multiple worktrees requires this, but separate
worktree is slightly broader feature.  I have added however new
"multiple worktrees (git-new-worktree)" option (answer).

But this reminded me that I forgot to add 'alternates' to the lists...

>>>> Documentation
>>>>
>>>>    xx. What could be improved on the Git homepage?
>>>>        (free form)
>>>>    xx. What could be improved in Git documentation?
>>>>        (free form)
>>> 
>>> "What can/will you do to help improve them?"?
>>
>> Good idea.  I have added this, separately for each question...
> 
> Wouldn't that be an overkill?

This is now slightly reworked at Survs.com.

-- 
Jakub Narebski
Poland
