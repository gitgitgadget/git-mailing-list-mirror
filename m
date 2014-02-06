From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] t7101, t7014: rename test files to indicate what that
 file is for
Date: Thu, 6 Feb 2014 08:58:18 +0700
Message-ID: <CACsJy8C93H4YW_ZbJaEDgTyr30OXtEP+uiXB_TA9jjWzD6rGqw@mail.gmail.com>
References: <CACsJy8BXGZ+1Oqrpcky5JPCtZRwvxmxhXGfuEqY9Ct4Pt8FmJg@mail.gmail.com>
 <1391480409-25727-1-git-send-email-pclouds@gmail.com> <20140204160523.GK30398@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 06 02:58:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBEEv-000496-Pa
	for gcvg-git-2@plane.gmane.org; Thu, 06 Feb 2014 02:58:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbaBFB6t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Feb 2014 20:58:49 -0500
Received: from mail-qc0-f180.google.com ([209.85.216.180]:57998 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753156AbaBFB6t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Feb 2014 20:58:49 -0500
Received: by mail-qc0-f180.google.com with SMTP id i17so2148093qcy.11
        for <git@vger.kernel.org>; Wed, 05 Feb 2014 17:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1mHK4ubjNn8x2PedN8iTmb0HyEhucrgX4Ahj46aXNxI=;
        b=O1HiboqRaBIU3LBQwYcbQg1eM/DbTi558wskusEwzjtYpCCYO1xwD8K2+9Bn8/UTHI
         P0H67ZS4Nwpvc6aRrEn6mbgIMT3S3SkzCfyKWbmAHgGDEw1puYP3okxeNWw+jZQmFiCM
         jfE+X3vy8RbJJi406pQ/DdXD37MEkZ5u22edvmuIrVw4/zWpBMhVwLqR9yipG3e9mTtz
         ZVzfwg8BgHOzgPvpC4spn0JgQtTsX+DgJpk9Q1Ru22iQRrP4nud8n92UcBITj2NYlmtO
         JQCmelr14N0zBHU5aDqOeo+b9AGe1bOb+iwCQmUxmrqVNbCmn33ZXt7c/0SOCOH3DXb/
         zjBQ==
X-Received: by 10.140.84.19 with SMTP id k19mr7815846qgd.98.1391651928332;
 Wed, 05 Feb 2014 17:58:48 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Wed, 5 Feb 2014 17:58:18 -0800 (PST)
In-Reply-To: <20140204160523.GK30398@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241682>

On Tue, Feb 4, 2014 at 11:05 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>  t/t7101-reset-empty-subdirs.sh (new +x) | 63 +++++++++++++++++++++++++++++++++
>>  t/t7101-reset.sh (gone)                 | 63 ---------------------------------
>>  t/t7104-reset-hard.sh (new +x)          | 46 ++++++++++++++++++++++++
>>  t/t7104-reset.sh (gone)                 | 46 ------------------------
>
> Hm, summary incorporated in the diffstat.  Neat. :)

Yeah, it's from this patch [1]. Maybe I should give it another push,
then remove --summary from format-patch diffstat.

[1] http://article.gmane.org/gmane.comp.version-control.git/213752
-- 
Duy
