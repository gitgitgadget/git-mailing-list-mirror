From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 4 Feb 2016 18:42:56 +0700
Message-ID: <CACsJy8Cau0mpz8zVjvz7RPt-s=xmaCCmz0p8OCup9-Q1MnwWCQ@mail.gmail.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com> <1454443734.5545.1.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 12:43:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRIJz-0004A9-Gg
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 12:43:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754075AbcBDLna (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 06:43:30 -0500
Received: from mail-lf0-f43.google.com ([209.85.215.43]:33089 "EHLO
	mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751873AbcBDLn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 06:43:27 -0500
Received: by mail-lf0-f43.google.com with SMTP id m1so34809994lfg.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 03:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=eUr9VPkq+SKnuF3x4gy5FjAVCq7vbuOl91vv6l9T/eo=;
        b=rr4vo99CjtYUyeTZkb1KZcH6wlyrdXJeBRU+UsIHmxYc63onLsSk4CKRSMI1K8+28U
         WfWeJPJJNZ45iUfG0OrIcaBHEpkwA6I54A+4ySqDYIfv2TDVjyCh3dncnZLM7u2tsFpC
         eH3K82PuhcVzRMN6Rkd1hZTMSxTbEBfivLTeoZ0Y5yz7T899Q0ciIO8lAjaDYM0Nhq2Q
         uvSopFfr1rxn6xNHBfRWhrujijEd6/GtBWdmDTNqU1vpAFm4Dc+2vO7bOebOReadbuFj
         EUYC+MCO7BTg8rs5XrMFf1/ZU+4gZlY4/1uvspwliILcLoWNDlHhWhQzJHGextGaizaI
         tCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=eUr9VPkq+SKnuF3x4gy5FjAVCq7vbuOl91vv6l9T/eo=;
        b=ULSnsMMkyToijisKpG7rbWbuXGj/46s68EfMoREspoEbTw4D3H5Eg/XlZxzST7AW5U
         BA/5yFFBxCMiRgIKCl383fJatJ8AnkFIWnXwlM6EHdm3ag6JdcPyRLj48pYyJse00MK9
         PI/HCWZgRIFMsdEHIX6oD0+W+SiUyOFWjckL02v81lgp8BE3C6B4HHBAybDgFPDj3qbD
         plk7+QVIwKfORUQHbZF0JK5/bjWfYJiCtL+r4IwikIZihP2UerIDwI/76MG+YjFvatyM
         suc02IxqkYY3huGn6UDdaiNgaLMYmaZS2ivI4HXyBD2F5xFcNNE6RpEq67GI106N2jfq
         qHoA==
X-Gm-Message-State: AG10YOTU+gqagtJBPuA9su2KVLdob/iwuocQd+0+WoekgJEE/S4sGtcdjKZa3Kp22tPDEm6rw7GY5/nOAA+ndQ==
X-Received: by 10.25.43.212 with SMTP id r203mr3335813lfr.162.1454586206432;
 Thu, 04 Feb 2016 03:43:26 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 4 Feb 2016 03:42:56 -0800 (PST)
In-Reply-To: <1454443734.5545.1.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285453>

On Wed, Feb 3, 2016 at 3:08 AM, David Turner <dturner@twopensource.com> wrote:
> Are there any more reviews on this?  I do have some changes from this
> set, but they're pretty minor so I don't want to post a new one (unless
> folks would rather see those changes before reviewing).  Let me know.

Last note. Since this is new code, maybe you can wrap translatable
strings with _(), basically any visible string that machines do not
need to recognize.
-- 
Duy
