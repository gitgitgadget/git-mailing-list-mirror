From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Back-dating commits--way back--for constitution.git
Date: Thu, 5 Aug 2010 21:58:36 +0000
Message-ID: <AANLkTikWc0rKV9rQsLfmZvhdqAuvATmbur2ZqQ4Xu7uo@mail.gmail.com>
References: <i372v0$3np$1@dough.gmane.org>
	<AANLkTik2B8pGo8uR4yxV3nz-Nx6dcU+fiO8GWgv9-VtW@mail.gmail.com>
	<4C599781.2020603@gmail.com>
	<4C5B2F2E.4050709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Joel C. Salomon" <joelcsalomon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 23:58:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh8SY-0004Gp-IA
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 23:58:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758370Ab0HEV6i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 17:58:38 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:55953 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756979Ab0HEV6h convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 17:58:37 -0400
Received: by iwn33 with SMTP id 33so517603iwn.19
        for <git@vger.kernel.org>; Thu, 05 Aug 2010 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FEbJ9H3ucce9tzJVv3CammypgjDUAvJPSn75P1Zs3i0=;
        b=rOaBT6qKMhStF9I4O/cLE4pbrwwA+XiEUrw+yTMf0PrlmlKwj1wExYIZJEGQ+g9hSc
         eqFoBhbbvO6HUGJHJx5RzXJGPtdCRIFWzSxUGj0rB4QiNcI7jteC8QwVp7f3yp58+ltI
         kVG2bl8T2peaS8fNNclt0QlMTxTtiJWcgATp0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VEB9HuSOU2RPOdUIJ8EdvL3uZiLwPviA7bZBkatEyaOAzqlNic43v0EkQsQYasfO+F
         cakgoqk19lbVKSaPKYXqJMd1/uYGm3Bhj5atUWtuIA0++M8QM3k8LM7eAsH77mro7GPv
         D9NeHMCUSeBlI8h3ZNVogGo6KDBIvVRfzzp6Y=
Received: by 10.231.31.71 with SMTP id x7mr4668150ibc.33.1281045516452; Thu, 
	05 Aug 2010 14:58:36 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Thu, 5 Aug 2010 14:58:36 -0700 (PDT)
In-Reply-To: <4C5B2F2E.4050709@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152725>

On Thu, Aug 5, 2010 at 21:37, Joel C. Salomon <joelcsalomon@gmail.com> =
wrote:
> On 08/04/2010 12:38 PM, Joel C. Salomon wrote:
>> I'll put my Constitution project up on GitHub in a few days. =C2=A0J=
ust note
>> that I *will* rebase and publish.
>
> It's up, at <http://github.com/jcsalomon/constitution>, with one comm=
it.
> =C2=A0(No amendments yet.)
>
> I'm curious to find out if folks with 64-bit time_t get the correct
> author and commit times.

On 32bit:

commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
Author: The Philadelphia Convention <>
Date:   Wed Dec 31 19:59:59 1969 -0400

On 64bit:

commit 826a4f7721fe1c3963a733ecbc5422f05925af5d
Author: The Philadelphia Convention <>
Date:   Mon Sep 17 13:00:00 1787 -0400

It would be useful to turn that into a TODO test for Git.
