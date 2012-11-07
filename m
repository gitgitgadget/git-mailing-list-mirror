From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [RFC] Add a new email notification script to "contrib"
Date: Wed, 7 Nov 2012 22:47:53 +0100
Message-ID: <CACBZZX6=e6_qO=wMcxLdUAc6XxYpdiP-9RPRsCXrVC_iuJ11Jg@mail.gmail.com>
References: <1342249182-5937-1-git-send-email-mhagger@alum.mit.edu> <50092C8C.3000305@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Andy Parkins <andyparkins@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	=?UTF-8?B?U3RlZmFuIE7DpHdl?= <stefan.naewe@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Marc Branchaud <mbranchaud@xiplink.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 07 22:48:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWDU3-0000Lc-NJ
	for gcvg-git-2@plane.gmane.org; Wed, 07 Nov 2012 22:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221Ab2KGVsO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2012 16:48:14 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:62992 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753200Ab2KGVsN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2012 16:48:13 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so2187959oag.19
        for <git@vger.kernel.org>; Wed, 07 Nov 2012 13:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aSLV85eWyWkNdmMwyH+057SMKlGbpPetJ20PaIYLzjc=;
        b=VJKR/OBE56i0Ss/X/nRR5dY2VHL6pk0+NYwwoe0XJ3rqTUVfe+rnLCRDzSrA/BBZmI
         D8uOvgUT4SXju9W564yivkricIhuJ0MKZEUnQ3JoZYEMLI/UYpkIoQbu2q6c2kx9b1AP
         3vpk7vAlEpGon39mC0VH+V9kXG3dQ3haL/d7oxkoJnvjAG0FmN4zd/K/y9tY3q6HMxok
         QpAjuE8EVhH+57RuZc1yQW1+GbBFaQFght2WF4BR9zI8ROybWJF8Fv8+YcugxA3Hli2D
         eJG3lxT1q3JfHXiy+paLy6lZcItprUdA4k+znKy+3eVZBLdXrpZeU9viiOtqNbIz9Qga
         VM5w==
Received: by 10.60.12.106 with SMTP id x10mr1455569oeb.10.1352324893286; Wed,
 07 Nov 2012 13:48:13 -0800 (PST)
Received: by 10.60.93.225 with HTTP; Wed, 7 Nov 2012 13:47:53 -0800 (PST)
In-Reply-To: <50092C8C.3000305@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209143>

On Fri, Jul 20, 2012 at 12:01 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 07/14/2012 08:59 AM, mhagger@alum.mit.edu wrote:
>>
>> Add a new Python script, contrib/hooks/post-receive-multimail.py, that
>> can be used to send notification emails describing pushes into a git
>> repository.  [...]
>
>
> Thanks to everybody for your feedback.  I will try to incorporate it in a
> new version of the script, which I will put forward as a replacement for
> contrib/hooks/post-receive-email rather than as an alternative.  But I have
> very little open-sourcing time these days, and will be on vacation next
> week, so please be patient (or feel free to lend a hand if you are so
> inclined).

I'm curious as to whether you got around to this? I'd be interested in
updates on this script.
