From: Brandon Casey <drafnel@gmail.com>
Subject: Re: [PATCH 1/2] git-send-email.perl: support no- prefix with older GetOptions
Date: Sun, 15 Feb 2015 17:35:20 -0800
Message-ID: <CA+sFfMcpGfF+KaPk-jOPaueHS01rZ5fZws8Czavf6b0cUWxrbw@mail.gmail.com>
References: <xmqq8ug2pvw7.fsf@gitster.dls.corp.google.com>
	<1423858769-1565-1-git-send-email-gitster@pobox.com>
	<1423858769-1565-2-git-send-email-gitster@pobox.com>
	<CA+sFfMdVBgqV6Ar53eo_PEzHSLMc+Z_fA_ND5CBEtX8=pKvk_Q@mail.gmail.com>
	<031750B1-259D-4F19-8484-98A7A1266248@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"Tom G. Christensen" <tgc@statsbiblioteket.dk>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 02:35:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNAay-0006oZ-95
	for gcvg-git-2@plane.gmane.org; Mon, 16 Feb 2015 02:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbbBPBfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2015 20:35:22 -0500
Received: from mail-ie0-f172.google.com ([209.85.223.172]:42346 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbbBPBfV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2015 20:35:21 -0500
Received: by iecrp18 with SMTP id rp18so15568878iec.9
        for <git@vger.kernel.org>; Sun, 15 Feb 2015 17:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=m/IBIbG65dPYtQ64IWkSuA7PIgt8KdXCaSxVNS5Y12A=;
        b=kvOY9A8YtwEvxWwGjNT1Nt4V/Z8BZSecJVhy/gvkExOMw+beZF6ehzMITQ9xXVEpX4
         OQKOt/oci0b6qT2OgB3xE3mXb7vTBxlz8sc7L8jV0ihFmyAP2mMGwraWtQwPZCCPRVHh
         tm9XBCTs9IXO7QDfM1oWbR7MzUu8/BmotjV1nHKj2l+70gTe14xh4B6lQNG+Nwv5jpDo
         mEzwcyCMUZ0rwk9Q75d7eC6+SKsY01mPQKPZD7JupPB8Xs5GNkc9e9b957g6AVDSvHcq
         UQt4E7E6qVWZzG7zsDjlipk/mojgSQ10vVQ/wsjnBMpiPuTHsMaREz3vp0g+7rnDVJFt
         EGDw==
X-Received: by 10.42.223.194 with SMTP id il2mr27116875icb.94.1424050520788;
 Sun, 15 Feb 2015 17:35:20 -0800 (PST)
Received: by 10.64.58.201 with HTTP; Sun, 15 Feb 2015 17:35:20 -0800 (PST)
In-Reply-To: <031750B1-259D-4F19-8484-98A7A1266248@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263865>

On Sun, Feb 15, 2015 at 1:51 AM, Kyle J. McKay <mackyle@gmail.com> wrote:
> On Feb 14, 2015, at 22:32, Brandon Casey wrote:
>
>> On Fri, Feb 13, 2015 at 12:19 PM, Junio C Hamano <gitster@pobox.com>
>> wrote:
>>>
>>> From: "Kyle J. McKay" <mackyle@gmail.com>
>>>
>>> Only Perl version 5.8.0 or later is required, but that comes with
>>> an older Getopt::Long (2.32) that does not support the 'no-'
>>> prefix.  Support for that was added in Getopt::Long version 2.33.
>>>
>>> Since the help only mentions the 'no-' prefix and not the 'no'
>>> prefix, add explicit support for the 'no-' prefix when running
>>> with older GetOptions versions.
>>
>>
>> ultra-ultra-nit: s/when running/for when running/
>
>
> So it would say "add explicit support for the 'no-'prefix for when running
> with"...  That doesn't make sense to me.
>
>> The current wording
>> makes it sound like the explicit support is only enabled when running
>> with older GetOpt versions.
>
>
> How about this instead:
>
> Since the help only mentions the 'no-' prefix and not the 'no'
> prefix, add explicit support for the 'no-' prefix to support
> older GetOptions versions.

Works for me.

-Brandon
