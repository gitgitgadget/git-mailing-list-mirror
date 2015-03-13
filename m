From: Stefan Beller <sbeller@google.com>
Subject: Re: Is it possible get the tag name of working copy in Git?
Date: Fri, 13 Mar 2015 10:00:15 -0700
Message-ID: <CAGZ79kaeWkVD-tCVMRYBxgG80_PHOeHKeSdpodAPqgpdiARa7Q@mail.gmail.com>
References: <CAFL7HFUNMrTfLx+kj6rBiNeuLhbkPF_t32kOYYSxBP9F=eKSxQ@mail.gmail.com>
	<5502AF86.9050803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: chen chang <chenchangs@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 13 18:01:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWSwg-0004ok-EV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 18:00:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752063AbbCMRAS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2015 13:00:18 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35055 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415AbbCMRAP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2015 13:00:15 -0400
Received: by ieclw3 with SMTP id lw3so115510803iec.2
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 10:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=tIGLg2Aj+LA/jtKFijma31KTplBdvQeONFBRjK64FsI=;
        b=onVjRY1rRVZQ3wupKAIKTpHRAbtzvgOwUT+GLsEqEkiDyU8TkwOxF3/+fhbPK1obzG
         H+uqoRiK2mIJHUpmPpamZz/2wTqPfSPBvYUkduKqi/vIE70mfY6pyC8DkJs3y2Oppt8g
         IfNl3EHzTNiaYI0G30/j2ZFGyEmgKLfkjrv9jTkGZu4deO06abR4jCahPuLJXkxZ5mgy
         Xv/EMiGzFLmncfvAxZdyvtGpBb1NB6/Csfwv1xCjtP03FmyilXsREthSXE6Kr4EJbLtF
         1grnWo1Q0Qa8ZskSOwOpJFa5xdz+MasYAjhVaLeXcX8azTGzkTsBNTuk8hrrO7fspjlE
         onXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=tIGLg2Aj+LA/jtKFijma31KTplBdvQeONFBRjK64FsI=;
        b=IASqa4Tlt19P7kVwdwZQ5bkaoup/TjkJ1Lavk+Lcida9FgdH4XB4tlyj/o2TstOZu4
         RyuvGzXOnnTZARumOrtzgXQfmh0pD1EuskiS5ZYNfBGDOw/m9b/ivjcv0KE6ez7nhlDd
         jGEGQAZsCHzPz6Gxs64oAVH+U3bkyRijN0CsLThP1Ivc4fTQ/WNCMX8i44zWPzcxqEmo
         /vfBuE4zndSEg7rjay4rCUcIHMCocRNjcLe+pYxTnpiy7gHj+ULdtRuP/757wU1trjM0
         AJlHg/AuK5mWY0UXQGPBd4tYRehKl5fSa7wJt0uikRt9dHeaAbY/y7r7DPYu6raC6qo0
         YFIA==
X-Gm-Message-State: ALoCoQmKq8tnR3V9+2xLc01a7R6fJiLnwIbcqGqK6cZxidduzlmhVMWCB+jIuyKFtP/NMEkk4VsU
X-Received: by 10.50.254.4 with SMTP id ae4mr85161676igd.10.1426266015125;
 Fri, 13 Mar 2015 10:00:15 -0700 (PDT)
Received: by 10.107.46.31 with HTTP; Fri, 13 Mar 2015 10:00:15 -0700 (PDT)
In-Reply-To: <5502AF86.9050803@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265415>

On Fri, Mar 13, 2015 at 2:36 AM, Torsten B=C3=B6gershausen <tboegi@web.=
de> wrote:
> On 03/13/2015 08:08 AM, chen chang wrote:
>>
>> I want to use make file auto generate the revision number of working
>> copy from the tag name in git.
>

Maybe you're looking for git describe?
http://git-scm.com/docs/git-describe
