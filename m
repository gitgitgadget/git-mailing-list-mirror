From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v4 10/32] cache.h: define constants LOCK_SUFFIX and LOCK_SUFFIX_LEN
Date: Fri, 12 Sep 2014 10:32:42 -0700
Message-ID: <CAL=YDWmkphVddWQF028_AmVMzcPQ8nw9sCnpzPSijbN7o5xjdQ@mail.gmail.com>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
	<1409989846-22401-11-git-send-email-mhagger@alum.mit.edu>
	<CAL=YDWmgwwQsCSpVsQ5U+c=4RcLdzo-j_hmxDk-AJWdRUk_SsQ@mail.gmail.com>
	<541329B8.1050200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Sep 12 19:32:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSUiG-0002n4-At
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 19:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956AbaILRco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 13:32:44 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:53719 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751065AbaILRcn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 13:32:43 -0400
Received: by mail-vc0-f178.google.com with SMTP id hy4so1022737vcb.37
        for <git@vger.kernel.org>; Fri, 12 Sep 2014 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ESgBJbaPho6b9GLERUWO1taPctFALOkcphVyY7roNkQ=;
        b=igD059MIpkLpNBQRo5278g3FvsBjdMnidYExiehQ2HRUAOzgKd9zn6B9eO77ZkiXCG
         tCEZQYF+Da9BszBoQuyQg2nDTgPt3mHeCQtk90F79Fqsauxa5R5cJOg0RVejsrs3ATP+
         Ujz3Z3h9V36YYnuDnFKNKVOThXBAgLcGPkObvf217XMYb7KDZRKfIYKnqr2fbS5Fc1Fk
         vxmkmf2OmTDHzQBJA7OiTryFmuKx8ddnfSMpORFr0Q7lz93gy6+TCfrXkutOK1PfQN5W
         iDnTutl1Zv1r4rOBew8CnpyVVUDM0wg2EQUJ++BM1mmWHB5+ukdl5LgO0s4cyJVIkiUZ
         fPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ESgBJbaPho6b9GLERUWO1taPctFALOkcphVyY7roNkQ=;
        b=So+/fKGglKGhyfVOA6X/tfV+nBlyQxXclJh7T/+TL2R1SqGDA2SKOS3fBNUUXv219w
         qCFl54cte5lre+fjZb5n0/dt8tXrzMvdXqUmyqG5dKwHt9jHPW9Z9THKauTIeBpqEAm2
         ugTiyaY1T0cM8IcmJ/BRgjeVXulFWrWBOMLtfRjIz/5BQQZHneJA/4dZXaSHYkm6Nouk
         h2f2Uo9jXbq1VDiy4sUWE1AJFoXuHCSzWhZOowUmkllQjWtfrfIA7+UTMI/3j/9Cg3je
         v6AzDZnZE+jUDvedEELfYpyXC7gVqbD8UArzFcggS6bZQc1nYQCN9f6Hr3Nq0/bA2GzF
         Q5fg==
X-Gm-Message-State: ALoCoQlsSoN+00AfS4krkFAtCxX9Wj09nBpQHzJ9QJExh5fEvVbTGT0IAgAyL+ePGkogINRGZdEz
X-Received: by 10.220.159.204 with SMTP id k12mr8108213vcx.15.1410543162551;
 Fri, 12 Sep 2014 10:32:42 -0700 (PDT)
Received: by 10.52.231.232 with HTTP; Fri, 12 Sep 2014 10:32:42 -0700 (PDT)
In-Reply-To: <541329B8.1050200@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256931>

On Fri, Sep 12, 2014 at 10:13 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 09/12/2014 12:42 AM, Ronnie Sahlberg wrote:
>> Maybe we should not have a public constant defined for the length :
>> +#define LOCK_SUFFIX_LEN 5
>>
>> since it encourages unsafe code like :  (this was unsafe long before
>> your patch so not a regression)
>> +       i = strlen(result_file) - LOCK_SUFFIX_LEN; /* .lock */
>>         result_file[i] = 0;
>>
>>
>>
>> What about removing LOCK_SUFFIX_LEN from the public API and introduce
>> a helper function something like :
>>
>>
>> /* pointer to the character where the lock suffix starts */
>> char *lock_suffix_ptr_safe(const char *filename)
>> {
>>     size_t len = strlen(filename);
>>     if (len < 5)
>>        die("BUG:...
>>     if (strcmp(filename + len - 5, LOCK_SUFFIX)
>>        die("BUG:...
>>     return filename + len - 5;
>> }
>>
>> and use it instead?
>
> At the end of this patch series, LOCK_SUFFIX_LEN is only used in two
> places outside of lockfile.c:
>
> * In check_refname_component(), to ensure that no component of a
> reference name ends with ".lock". This only indirectly has anything to
> do with lockfiles.
>
> * In delete_ref_loose(), to derive the name of the loose reference file
> from the name of the lockfile. It immediately xmemdupz()s the part of
> the filename that it needs, so it is kosher.
>
> I will add a function get_locked_file_path() for the use of the second
> caller.
>
> I like being able to use the symbolic constant at the first caller, and
> it is not dangerous. I don't think it is so important to make the
> constant private, because I think somebody programming sloppily wouldn't
> be deterred for long by not seeing a symbolic constant for the suffix
> length. So if it's OK with you I'll leave the constant.

It is OK with me.
