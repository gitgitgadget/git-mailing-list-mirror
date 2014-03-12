From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Mar 2014, #01; Tue, 4)
Date: Wed, 12 Mar 2014 19:55:51 +0700
Message-ID: <CACsJy8Do8nL1CcZ=jNz=_A2j8EWgcSAZBsqYZMF=SvTv0itRpg@mail.gmail.com>
References: <xmqqiortijxp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 14:02:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNio9-0007rn-TD
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 14:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbaCLNCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 09:02:49 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:56755 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751412AbaCLNCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 09:02:48 -0400
Received: by mail-qa0-f44.google.com with SMTP id f11so9914723qae.31
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 06:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Cv7QDAsWVQQhUDq/ungkNu0i0jMYNyRYOxA7xVN45yM=;
        b=QKH3DZX5F0B7D1qIIoAWmJd0yRREgQ0AEazNMGtU0957b59xs8Sga5eTHdL3l3Y/sp
         3FGWLS24XKQaShGpoI1WnzUJfgMf518J7Pwjis1LJXi+M4Sj/2LHVD9YvQeVM7yhRxuf
         uyMq2tSBGl7eGr6GoBUOIz9L7CUWx5yqJU+E/vcfk+oXsbVcJT215nv+DIn7+RijA9RG
         8FA5J5ARG4ltPKoF6DBb8cDyq9tdXrDD+7QH+3cj6WoEOwmRuW3jTBJXToDj12/c2XhB
         rEOAIXT5lLwStTRyySmrDqOZk3enizD0zUp4/BKRTjXgEs6pGICwU/P+zF3Dy4WbgLjU
         SfyQ==
X-Received: by 10.140.93.244 with SMTP id d107mr14107364qge.41.1394628981675;
 Wed, 12 Mar 2014 05:56:21 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Wed, 12 Mar 2014 05:55:51 -0700 (PDT)
In-Reply-To: <xmqqiortijxp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243935>

On Wed, Mar 5, 2014 at 7:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [Graduated to "master"]
> * jk/pack-bitmap (2014-02-12) 26 commits
>   (merged to 'next' on 2014-02-25 at 5f65d26)

And it's finally in! Shall we start thinking about the next on-disk
format? It was put aside last time to focus on getting this series in.
My concern is shallow support (surprise?) so that cloning from a
1-year-long shallow repo is not slower than a complete one. An
extensible format is enough without going into details.
-- 
Duy
