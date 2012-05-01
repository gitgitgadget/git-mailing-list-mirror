From: Michael Witten <mfwitten@gmail.com>
Subject: Re: Newbie grief
Date: Tue, 1 May 2012 06:24:07 +0000
Message-ID: <CAMOZ1BvMB_Y74eK4Ca1HEzbqiGVCgKp=45Wiu=aQuTXOd-5UZQ@mail.gmail.com>
References: <4F9F128C.5020304@palm.com> <201204302331.q3UNVo7o032303@no.baka.org>
 <4F9F28F5.2020403@palm.com> <201205010137.q411bxaU002449@no.baka.org>
 <4F9F52B9.9060508@palm.com> <08704bd2e32343a4b9def80e4fa1efa2-mfwitten@gmail.com>
 <7vvckgbew5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Rich Pixley <rich.pixley@palm.com>,
	Seth Robertson <in-gitvger@baka.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 08:24:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP6Vv-0006ln-CE
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 08:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753200Ab2EAGYj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 May 2012 02:24:39 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:50148 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752706Ab2EAGYi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 May 2012 02:24:38 -0400
Received: by qcro28 with SMTP id o28so1777006qcr.19
        for <git@vger.kernel.org>; Mon, 30 Apr 2012 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Lb0Ujc7FSZP/O50CAeGscQ7jtdnFlWBPzh/1Wuc/9CY=;
        b=tMtQTN7rb0m3l7YoIFkCNaH1Tx03oGHMBjd1vh6S76JZI1QKwcJgkVdVqM5X1qm2Qv
         AHaICQVFS+Samso9TfZJOG95IC+iMg6b7kxq0HZyLomZj2wYbWmPVQu1Tt3IVtHLZ9N6
         j6B0CobUdE+yz45Z8KfoTHzx+Vfb7R1X1NpJp/u/XssSI6B6P9OijqD9YYc0VhB6cL4p
         Xrm3IriCrQdbBkarRCD4kdEDkftjGaV/Gbuq1VI3huFpfxCaxCt0IP+SYYre8T/lDbbZ
         DSuYWcBffDuq3OodnCeePw8pXpOrjZbRyqrCQT0Wy3/PTmY6zfrdc0Z6qFOHPcoRVpK1
         4G3A==
Received: by 10.224.102.7 with SMTP id e7mr3524692qao.15.1335853477947; Mon,
 30 Apr 2012 23:24:37 -0700 (PDT)
Received: by 10.229.122.13 with HTTP; Mon, 30 Apr 2012 23:24:07 -0700 (PDT)
In-Reply-To: <7vvckgbew5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196663>

On Tue, May 1, 2012 at 06:21, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Witten <mfwitten@gmail.com> writes:
>
>> Here's a start for a more precise discussion.
>
> When does the "Cache server" updated from the "$uri_for_central_repo"=
 in
> this picture? =C2=A0If it is after push by either from Machine A or B=
, somebody
> needs to reconcile that and whatever A/B pushed.
>
> And between Hg style "split head" or Git style refs/remotes/* namespa=
ces
> there is no difference to perform that reconcilation. =C2=A0Somebody =
needs to
> run "merge" on the "Cache server" and at some point the result needs =
to be
> pushed to the $uri_for_central_repo back.
>
> So...

Examples of pushing to the central repo and updating the cache repo
are given at the bottom.
