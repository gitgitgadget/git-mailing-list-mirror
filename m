From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCHv3 08/11] fetching submodules: respect `submodule.jobs`
 config option
Date: Wed, 11 Nov 2015 20:55:10 +0100
Message-ID: <56439D1E.8080102@web.de>
References: <1446597434-1740-1-git-send-email-sbeller@google.com>
 <1446597434-1740-9-git-send-email-sbeller@google.com>
 <56426DD1.6090904@web.de>
 <CAGZ79kbqedWRDADChorvWhcmyjO4iZqt4WO8KSo917pxWgr4Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 20:55:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwbUR-0000Sj-Q6
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 20:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbbKKTz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 14:55:28 -0500
Received: from mout.web.de ([212.227.15.4]:59256 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752148AbbKKTz1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 14:55:27 -0500
Received: from [192.168.178.41] ([79.211.127.69]) by smtp.web.de (mrweb003)
 with ESMTPSA (Nemesis) id 0MNcHy-1a2d6R1zPW-007F7D; Wed, 11 Nov 2015 20:55:13
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <CAGZ79kbqedWRDADChorvWhcmyjO4iZqt4WO8KSo917pxWgr4Rg@mail.gmail.com>
X-Provags-ID: V03:K0:huqVtTzMSsMee0XTqZn8yWita6a9xQmW+IGi+bc3FyGSk/2HbJi
 zakmFoye4H3yCwsCxT0sUfIlV7Qw/A5pJ27UoFzwGdEyG1BHAxwg4puBZHSudQEh4Dg7vwg
 5ttSwfbAPW85yR4BXksrCaUNp2Y7qg+aUTSYKT6yCk94ESI5q7sYwX2WeGalLf0MyqphJmN
 nAf+KSFYCd23aVdpcWi1g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1lhFWC9xTQs=:Yo8q4nwPDJn00c/+iZK9S3
 zG2ucFOHKNZ1X6NThNvergq4kYZ4ypNWffVn5RpwyAlcZOywMxiYb3KpyC0TQbqSPi+PoJ70n
 UeeI7ctXDfv03NbRbVQFBVfqDP+wr5Mrhn2zmCOzlAdyLB7TKq5FOzTSJwWV/Egw2xLuBT78+
 NOZDUgl+FIqqI5do1bwEQYNjtb+lDR5uNJHPOgWxCHUGGZYKgNdKpZ8/r+q/amF+K9PHs2/KL
 P7e4fz5QfUwonJbqELdhXDoJuAGlxH4lC6y7qcPk0BnhWDlxlyBQ+XoYQ8x2GX1UVHaTCY+g/
 9L7KVqEU3jnpg/bV+NbCPH07pZ1YUefem6yW14M2KuyPpIjH8mvjMeQJl1jVL2C1yCrLUKgCP
 ZQ62+lc8K5DfK0rOiiWZkfFNLU7AR7NxA9VBSHKgJKAIeI3WcKpIUu1maiAgXy1oHUx3ogrH4
 45XrXOby/RimQ9ingkxmRbESG2Uwswj9NsaJGdjLNkBW/RHG8OYgGtCvUkHJ+Y/Dk/4MJSyCi
 4FQkaHSTihBCiSJDRlOO/nCWGWFnXQscQTVkRZX/DfRTO8L3KFTcELfNDhjjs9H06NhOatjLd
 tbgmAjiP51Yt1x1PUBYyzoysxvW54T7034s0jn4TmlmdFHSDyZAYZuj5mEcAUvqqmyQk0V9PO
 8n3UnlSggcISK0gvdHheGK+8qtcdmb9yzGlWppcB8hO9OBvm9nV0XcnGlNf7kbelYvyKmlHYY
 6jUPokDDB5g1vq3ypbDvlO5Lj+Nnz8Lg2TVMZRkW/k8fVPFc4nU2XTAGFwb8bc1JwG54Vtal 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281192>

Am 10.11.2015 um 23:29 schrieb Stefan Beller:
> On Tue, Nov 10, 2015 at 2:21 PM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>>> +submodule.jobs::
>>> +       This is used to determine how many submodules can be operated on in
>>> +       parallel. Specifying a positive integer allows up to that number
>>> +       of submodules being fetched in parallel. This is used in fetch
>>> +       and clone operations only. A value of 0 will give some reasonable
>>> +       configuration. It defaults to 1.
>>> +
>>
>>
>> Just curious (and sorry if this has already been discussed and I missed
>> it, but the volume of your output is too much for my current git time
>> budget ;-): While this config is for fetching only, do I recall correctly
>> that you have plans to do submodule work tree updates in parallel too?
>> If so, would it make sense to have different settings for fetching and
>> updating?
>
> TL;DR: checkout is serial, network-related stuff only will be using
> submodule.jobs

My point being: isn't "jobs" a bit too generic for a config option that
is only relevant for network-related stuff? Maybe "submodule.fetchJobs"
or similar would be better, as you are already thinking about adding
other parallelisms with different constraints later?

> In the next series (origin/sb/submodule-parallel-update) this is reused for
> fetches, clones, so only the network stuff. The checkout (as all local
> operations)
> is still done serially, as then you don't run into problems in
> parallel at the same time.
> (checkouts may be parallelized but I haven't done that yet, and postpone that
> until it has settled a bit more)

Makes sense.
