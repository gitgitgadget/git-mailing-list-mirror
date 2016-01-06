From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new repos
Date: Wed, 6 Jan 2016 19:52:21 +0700
Message-ID: <CACsJy8DQMBfSh1re0jMk1W=d9gYa2=6jqO+Q6bqam5WBY3hfmg@mail.gmail.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
 <1449102921-7707-14-git-send-email-dturner@twopensource.com> <567AA2DF.1020408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jan 06 13:52:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGnaC-0000np-Nx
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 13:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601AbcAFMwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 07:52:54 -0500
Received: from mail-lf0-f42.google.com ([209.85.215.42]:33810 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbcAFMww (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 07:52:52 -0500
Received: by mail-lf0-f42.google.com with SMTP id y184so312159247lfc.1
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 04:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LjVDHodweySGYsbwQP/i4SQ2vynpzKWpMdeHW+wuBtY=;
        b=NwLijfgIbnOVgEOpba351XLNJy2AsPh+9YIqezzipnU5iB8otwSX3gKvIAFyjyzDZ9
         +0bkm3RkG5TKvtQqiXjrsDm09wtQ7L7cg0fLVluVdqGwcabuSi/dz78dp1Lqv3k4isb8
         40Ko/crh+xMW4jtDYuEIYh8GkD+WsUPxQH40hTx1k9D4p6T7vpifv8TJ99jXWyTH0Ybs
         2SSBCgRQODwMn8L11KjxpelJ+i938Ag2h4FbaPaHPCGTKxLJpHWsQB9PdxF1LVk6CvKS
         Jxq7qXxrrtq6RKZPwbzapgGEq02Spgz+43z04pyENEv4dGLnmTSAuvcrt1FoQROfadqM
         3kWQ==
X-Received: by 10.25.161.144 with SMTP id k138mr27170397lfe.83.1452084771236;
 Wed, 06 Jan 2016 04:52:51 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 04:52:21 -0800 (PST)
In-Reply-To: <567AA2DF.1020408@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283439>

On Wed, Dec 23, 2015 at 8:34 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 12/03/2015 01:35 AM, David Turner wrote:
>> diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
>> index 8174d27..9ea6753 100644
>> --- a/Documentation/git-init.txt
>> +++ b/Documentation/git-init.txt
>> @@ -12,7 +12,7 @@ SYNOPSIS
>>  'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
>>         [--separate-git-dir <git dir>]
>>         [--shared[=<permissions>]] [directory]
>> -
>> +       [--refs-backend-type=<name>]
>
> ISTM that "backend" (used here in this option name, and in the manpage)
> is not such a meaningful term to users. Could we pick a less obscure
> term? E.g., maybe "--ref-storage=<name>"?

>From an (ex-)translator point of view, storage is also easier to
translate than the technical term "backend". I know we do not
translate option names, but whatever term you use usually show up in
some user-facing messages that need translating. But I do prefer
backend in source code, I think it expresses the idea much better than
storage.
-- 
Duy
