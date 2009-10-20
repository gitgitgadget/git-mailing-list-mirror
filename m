From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] Use faster byte swapping when compiling with MSVC
Date: Tue, 20 Oct 2009 10:56:39 +0200
Message-ID: <bdca99240910200156x48511478w9eaa2239eb8342b4@mail.gmail.com>
References: <hbi4mt$tjt$1@ger.gmane.org>
	 <7vzl7mr1f5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Marius Storm-Olsen <mstormo@gmail.com>,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 10:56:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0AWM-0001Om-7y
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 10:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbZJTI4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 04:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbZJTI4g
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 04:56:36 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:17858 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343AbZJTI4f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 04:56:35 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1914051fga.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=KCq+H2IqSTHJnpDTfqz6wFlWXdklVSzly3pRvFOHIcA=;
        b=wcJTRi3PeqQ9qPl7E0L2500sb4MYGXzgW9v5m0b9MuXpVqNTPrx0BBE8LfG6Om5R32
         TDdCLOMWzOo1MNdm7ECGTqyoyRE/V1L/BvnAzZUrffpqoZnLiNxq42Hyj7uluv2EGMIB
         0WZ0HHphGBZ3I8yrGWG1/Vh+S+omdpg154zJQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=p6qvQ0bmH6AyIy50FzZaKSrS6v3pa4sJvbH7jOdzSAr29xjcJGRclR9XbKwTN1xLGB
         al7k18AQ9Pvi2oGHQPdzdZVGuiXKA0gymE6XgYkoz9W37gFp9qou4WW+jGNqGaoiRIop
         hqJxchx9cTrsLI/ndofaq2U6ydvwXHK2faX5Y=
Received: by 10.86.12.35 with SMTP id 35mr3727861fgl.20.1256028999479; Tue, 20 
	Oct 2009 01:56:39 -0700 (PDT)
In-Reply-To: <7vzl7mr1f5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130775>

On Tue, Oct 20, 2009 at 09:04, Junio C Hamano <gitster@pobox.com> wrote:

>> When compiling with MSVC on x86-compatible, use an intrinsic for byte swapping.
>> In contrast to the GCC path, we do not prefer inline assembly here as it is not
>> supported for the x64 platform.
>>
>> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
>
> Unlike the other one this is not Acked by Marius, Dscho, or J6t; should I
> pick this up myself, or should I wait to be fed by one of msysgit people?

Well, in fact I am one of the msysgit poeple, although I mostly worked
on the installer until now. In general, I like my patches to be
reviewed, but this one is rather uncritical, I guess. So it's up to
you, Junio, I'm perfectly OK with waiting for an ACK.

-- 
Sebastian Schuberth
