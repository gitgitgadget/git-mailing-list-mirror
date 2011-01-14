From: Joe Corneli <holtzermann17@gmail.com>
Subject: Re: working with a large repository and git svn
Date: Fri, 14 Jan 2011 07:43:19 +0000
Message-ID: <AANLkTikCvjDqUpL-=srVKcMQx+NM6bV7FabmJ+4sPqD7@mail.gmail.com>
References: <AANLkTimKbS3ECzOaGtNgvx7DThJGH_DkPmg4ehKXGtwc@mail.gmail.com>
	<201101120830.47016.wjl@icecavern.net>
	<20110113032300.GB9184@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 08:43:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdeJk-0008TC-4A
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 08:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752613Ab1ANHnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jan 2011 02:43:21 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64227 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1ANHnT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 02:43:19 -0500
Received: by iyj18 with SMTP id 18so2275852iyj.19
        for <git@vger.kernel.org>; Thu, 13 Jan 2011 23:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:content-type;
        bh=j4w5rqUJXCO5U+DeZwxbUsNEgOKMjCOrqYNhf3efH+U=;
        b=sWmSYGLvJsrkd7HFubQmTtUIw/g9PMpkIXTtTheFxjjrvlVAYIWxHSvvwj9dxx9OF1
         VSjg8lkZhh1sjluw2mouKDgj2gmBEAz50JydIMXSjATcb7YNoqrtYATvGO+fM21M0cnf
         QStnXPvELHi1sybx3D55gc8HMGr+di8dfcL8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        b=a1h7nO1fFSbt08nymYq6SuqoaaUZ+3Xci7OVxrnVQXyl1g0CQxYiaAm+Kg8Mr82lEE
         t6JPirlN7dZAWvASEHNRDyzfDQgVFiblrii/e6uLruY4Hp9Vvx3tLzx91B37uye74iTS
         /wfuOOLZMJs8++U350AlagLS12YzGASnGgbG0=
Received: by 10.231.12.7 with SMTP id v7mr416331ibv.78.1294990999225; Thu, 13
 Jan 2011 23:43:19 -0800 (PST)
Received: by 10.231.85.146 with HTTP; Thu, 13 Jan 2011 23:43:19 -0800 (PST)
In-Reply-To: <20110113032300.GB9184@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165075>

> I think the state of the art is currently git2svn

Thanks, that did indeed work, though, for the record it uses committer
name and email in the log that it generates, not author name and
email, but no worries!

Joe
