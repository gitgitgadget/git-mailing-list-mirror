From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: "Sparse checkout leaves no entry on working directory" all the
 time on Windows 7 on Git 1.8.5.2.msysgit.0
Date: Thu, 6 Feb 2014 20:30:16 +0700
Message-ID: <CACsJy8CG=d4jdQMW0tddrqUPCa+72yZe6i7LDBisWNo6KPF03g@mail.gmail.com>
References: <web-57771132@mx45.intranet.ru> <52F38C1D.709@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: konstunn@ngs.ru, Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Feb 06 14:30:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBP2b-0008K0-II
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 14:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbaBFNar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Feb 2014 08:30:47 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:64144 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388AbaBFNar (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Feb 2014 08:30:47 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so3041884qcx.24
        for <git@vger.kernel.org>; Thu, 06 Feb 2014 05:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=tYkKBxr3T9h/1TNIq4h5LGmCK6oGogLsVekc91bIoOQ=;
        b=hKWg+nD4BnqiVXSu5+mmlPRV21edQpzmceTznM5bFZxc6KMpSUkg5e3SnRJubCRe4I
         9x+gMLXtOy1fOgMgbQOD+mUGFHcN0J7EbnVb7VbOK66me+GF04Tx5867TOK6qgr+nBxx
         9z0kd8KucHhZ0BaUfWypeJXokhY30JxNrt67fd3sPaSJIbyvZxZQn7oxtZaBRpbqleMJ
         SGjyZjUYHgW3THLToRca/NH5TitNs5IzMMzwwAchZldmlb5Sbzvdxxsj7gPBVvnZpfc1
         o6/rDHR9LjlpElMeBkOwa7XvKB+ABj7gNUl4BoF6BpDKKML+YzNaKIjouVXBQcTiPDxH
         Fbrg==
X-Received: by 10.140.107.138 with SMTP id h10mr11581112qgf.30.1391693446517;
 Thu, 06 Feb 2014 05:30:46 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 6 Feb 2014 05:30:16 -0800 (PST)
In-Reply-To: <52F38C1D.709@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241692>

On Thu, Feb 6, 2014 at 8:20 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 2/6/2014 12:54, schrieb konstunn@ngs.ru:
>> However I typed the checkout directory in file
>> ..git/info/sparse-checkout by using different formats with
>> and without the leading and the trailing slashes, with and
>> without asterisk after trailing slash, having tried all
>> the possible combinations, but, all the same,
>> nevertheless, the error occured.
>
> Make sure that you do not use CRLF line terminators in the sparse-checkout
> file.

I suspected the same thing. But it looks like we do trim CRLF. Another
option is the file is encoded in utf-16 or some encoding which ascii
is not a subset of.
-- 
Duy
