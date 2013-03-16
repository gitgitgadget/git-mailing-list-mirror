From: Adam Retter <adam@exist-db.org>
Subject: Re: git svn error "Not a valid object name"
Date: Sat, 16 Mar 2013 12:07:51 +0000
Message-ID: <CAJKLP9aX20i+oy7AMhh5+uAmP2Np4tUGTEvR+XDHyG1a_DSXtQ@mail.gmail.com>
References: <CAJKLP9ZQBXf5ZZY9FccOAL5QU+q1b5SnAfvP9BpARdqvzPuWeg@mail.gmail.com>
	<20130316014548.GA16253@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Dannes Wessels <dannes@exist-db.org>,
	Wolfgang Meier <wolfgang@exist-db.org>,
	=?UTF-8?B?TGVpZi1Kw7ZyYW4gT2xzc29u?= <ljo@exist-db.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Mar 16 13:08:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGpuO-0007Ob-52
	for gcvg-git-2@plane.gmane.org; Sat, 16 Mar 2013 13:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592Ab3CPMHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Mar 2013 08:07:53 -0400
Received: from mail-ob0-f171.google.com ([209.85.214.171]:49623 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755044Ab3CPMHw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Mar 2013 08:07:52 -0400
Received: by mail-ob0-f171.google.com with SMTP id x4so4069045obh.16
        for <git@vger.kernel.org>; Sat, 16 Mar 2013 05:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:x-gm-message-state;
        bh=c8lBG+t5Ui18wmT/5PagC4xG3XWKmhLAFyPlH5Yz2Bc=;
        b=RSLoKttbfGncBd5lTxXChHN3GbRvAxR6cB4XR/9OsWFnlZqKJqr7W0HPD/iC5W8Sli
         K3zTi4Xgi0QSO6KODjgk5t0kzQzq5ZHnZxaQcLSbHIo+mpfxgdtNGx74HeKGoEPqQoHG
         ltX3Tu0n/c7SFWhNoyz9KnOG2gprU1XRNfJuACL3rMztuH527NalYWaF+jkTgKZpEFb/
         ox0TQnIlisq9+nGdpDcw3aa2HT9yJskmVS/mlUVjplshdR97CE1XuxdsEpr3W3bV7tGs
         pYVHQlg7k26cURNZunXv4V+Vzz95ab2rYbyIHrW25QsjG+fLYJ2uVq59JRMcH0o9rqUn
         QVVA==
X-Received: by 10.182.64.74 with SMTP id m10mr4293497obs.61.1363435671587;
 Sat, 16 Mar 2013 05:07:51 -0700 (PDT)
Received: by 10.76.33.166 with HTTP; Sat, 16 Mar 2013 05:07:51 -0700 (PDT)
In-Reply-To: <20130316014548.GA16253@dcvr.yhbt.net>
X-Gm-Message-State: ALoCoQknfFXvr7jb+2ykDHh7OtOKymfds0uAVgPW2mPEZgJmUgn18U/B7dg3FpP6TGFkGAXU8b2Y
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218300>

>> fatal: Not a valid object name
>> ls-tree -z  ./webapp/api/: command returned error: 128
>>
>> I have no idea what this means, or how to fix this.
>> We are using Git version 1.8.1.GIT on Amazon EC2 Linux.
>>
>> Any suggestions please?
>
> You might've hit a bug in branch detection, but I'd have to look at the
> repo to be certain and fix it if neded.
> --no-follow-parent should work, but you'd lose branch/tag history.

Hi Eric,

Thanks for the response, ideally we would like to keep our history
which is why we are really using one of these tools in the first
place.

If your able, any idea of when you might be able to take a look at the
bug? Our svn repo is publicly available for all.


-- 
Adam Retter

eXist Developer
{ United Kingdom }
adam@exist-db.org
irc://irc.freenode.net/existdb
