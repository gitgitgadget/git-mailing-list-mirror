From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: git-grep while excluding files in a blacklist
Date: Tue, 17 Jan 2012 16:19:49 +0700
Message-ID: <CACsJy8A8eWt_wcxWrdjgmkHZpS1bBet7DTT-bRf9zrxfszUtjw@mail.gmail.com>
References: <CA++fsGHGrNQzR-schP0yTXnD4jkYJjHHVk6QoJvfxPX9mguJPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Dov Grobgeld <dov.grobgeld@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 10:20:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rn5DS-00057R-5N
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 10:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab2AQJUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 04:20:24 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52172 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751340Ab2AQJUV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 04:20:21 -0500
Received: by bkas6 with SMTP id s6so1397327bka.19
        for <git@vger.kernel.org>; Tue, 17 Jan 2012 01:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=L2M0WPqI4tMRrnXrBpr/18fFRNBccP2fQH55MkCADPA=;
        b=NxMX2R3+vewrzaZe8oQl01QIZnaRT76LBQGgNXOje/YK5sEXMHRpv2oAMB+e9MdYIo
         E4OHOxUwhh20b3YZBFyww/CGPlcXf87zPUyBhWqUIPXOVO5snQF5xe7RWaJB4/AVI0Xb
         nNwkA8e0p/0KIWd7ZKbI6KVfS3Yn0dOXBWZus=
Received: by 10.204.157.130 with SMTP id b2mr4911593bkx.22.1326792020208; Tue,
 17 Jan 2012 01:20:20 -0800 (PST)
Received: by 10.205.123.145 with HTTP; Tue, 17 Jan 2012 01:19:49 -0800 (PST)
In-Reply-To: <CA++fsGHGrNQzR-schP0yTXnD4jkYJjHHVk6QoJvfxPX9mguJPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188702>

On Tue, Jan 17, 2012 at 4:14 PM, Dov Grobgeld <dov.grobgeld@gmail.com> wrote:
> Does git-grep allow searching for a pattern in all files *except*
> files matching a pattern. E.g. in our project we have multiple DLL's
> in git, but when searching I would like to exclude these for speed. Is
> that possible with git-grep?

Not from command line, no. You can put "*.dll" to .gitignore file then
"git grep --exclude-standard".
-- 
Duy
