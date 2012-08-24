From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: in_merge_bases() is too expensive for recent "pu" update
Date: Fri, 24 Aug 2012 18:51:21 +0700
Message-ID: <CACsJy8Ap-T-5KPK1HdGVM3Eyr7LqgsLuc7jvXLZJrtsmiRUSFw@mail.gmail.com>
References: <CACsJy8C-VxzwigyUDHnUkXN7vhB+93X96pH9MvgB0ps7v-_NmQ@mail.gmail.com>
 <878vd5k7uu.fsf@thomas.inf.ethz.ch> <CACsJy8DJLmNWDNhGczk_0qDngHxDgQMh7zskxJXTqLGQ8gwugw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 24 13:52:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4sQs-0004ZB-3G
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 13:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756183Ab2HXLvz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Aug 2012 07:51:55 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:47310 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754226Ab2HXLvw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2012 07:51:52 -0400
Received: by ialo24 with SMTP id o24so3252470ial.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 04:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lWchftncIEme1xoyHifoWUz0PLNbY5qhZ94omLb+xeU=;
        b=K/LFi42wsY36E+sJY8zser+lTm0Ci7QbHPWuR4LfdIxMHO+aOgy2LJGXQ/Lh3oPRuI
         2QXe/se6mJZaeuD4iqUK+FgwAqblW5nWH7+3+v3NFnI+KAmCOEnEbqANot55aCCeTF11
         6IR+vf/WrByTCJ3l5xyqY+oN5hyJfq3uXvgou+UXJ/qizbMXCDGk9Z1a0bI5ANacJgQy
         glSZCic5k2xTXdHdZKQ2WOYFVlCjvWzZtZqAixlgFCsgt8ImTUdB9dhN/68IXZn+YQNy
         ULmKzkpEHq4UDlNQdFU8bHXsbdgcA1eREKqm/aXiaWNLl170e7mDlPa2ZACpdWP3d5rt
         rNsQ==
Received: by 10.42.157.5 with SMTP id b5mr4070839icx.37.1345809111624; Fri, 24
 Aug 2012 04:51:51 -0700 (PDT)
Received: by 10.64.35.12 with HTTP; Fri, 24 Aug 2012 04:51:21 -0700 (PDT)
In-Reply-To: <CACsJy8DJLmNWDNhGczk_0qDngHxDgQMh7zskxJXTqLGQ8gwugw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204206>

On Fri, Aug 24, 2012 at 6:42 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Without looking into detail (as I'm not familiar with this code), this
> patch does not help much.

And I should have looked. git merge-base does not use that function.
With your patch, git fetch is instant again for same 'pu' update.
-- 
Duy
